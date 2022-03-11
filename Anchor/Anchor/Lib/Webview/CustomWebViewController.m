//
//  CustomWebViewController.m
//
//
//  Created by 小草 on 2019/3/18.
//  Copyright © 2019年 小草. All rights reserved.
//

#import "CustomWebViewController.h"
#import <WebKit/WebKit.h>
#import "UIView+DragButton.h"
#import "CoustomWebMenuView.h" // 悬浮按钮蒙层
#import "KKWebViewEventModel.h" // webview数据处理model
#import "KKWebViewManger.h" // webview管理器
#import "KKApplePay.h"
#import "KKMySelfModel.h"
#import "BRPickerView.h" // 选择地区
#import "KKSelectBankListView.h" // 选择银行
#import "UIDevice+XJDevice.h" // 设备转屏
#import "AppDelegate.h"
#import "KKSecurityPolicy.h" // 创建请求实例
#import "KKActivityView.h" // 活动页面自定义的view
#import "LoginViewController.h" // 绑定手机号页面

static void *WKProgressContext = &WKProgressContext;
static void *WKTitleContext = &WKTitleContext;

@interface CustomWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,CoustomWebMenuViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
// 悬浮按钮蒙层
@property (nonatomic,strong) CoustomWebMenuView * meunView;
// 悬浮按钮
@property (nonatomic,strong) KKClearButton * suspensionButton;
// 当前控制器类型，全屏还是带有导航
@property (nonatomic,assign)CustomWebViewType vcType;
// 导航按钮的参数
@property (nonatomic,strong)NSDictionary * navRightButtonparamDic;

@property (nonatomic,assign) BOOL isPop; // 是否是pop返回

@property (nonatomic,strong) KKSelectBankListView * selectBankListView; // 选择银行

@property (nonatomic,strong) NSDictionary * jsRequestParams; // js请求参数记录

@property (nonatomic,strong) UIColor * selfColor; // 本类的颜色
@property (nonatomic,strong) NSString * navTitle;

@property (nonatomic,assign) BOOL isfirstSuccess; // 首次是否成功

@property (nonatomic,assign) BOOL isActive; // 是否是活动页，活动页，充值提现下面是自定义的view

@property (nonatomic,strong) KKActivityView * activeView;// 活动页面的列表


@end

@implementation CustomWebViewController

/// 重写本类init方法
/// @param webURL webView链接
/// @param vcType 控制器类型
-(instancetype)initWithUrl:(NSString *)webURL title:(NSString *)title vcType:(CustomWebViewType)vcType{
    self = [super init];
    if (self) {
        self.navTitle = title;
        self.vcType = vcType; // 类型
        self.url = webURL; // URL
        self.isActive = NO;
    }
    return self;
}

-(instancetype)initWithActiveUrl:(NSString *)webURL
                           title:(NSString *)title vcType:(CustomWebViewType)vcType{
    self = [super init];
    if (self) {
        self.navTitle = title;
        self.vcType = vcType; // 类型
        self.url = webURL; // URL
        self.isActive = YES;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.selfColor = self.view.backgroundColor;
    self.navigationItem.title = self.navTitle; // 标题
    
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    self.isFirstFrom = YES;
    // 添加视图
    [self addViews];
    if (self.url.length>0) {
        // 加载html
        [self loadRequest:self.url];
    }
    if (self.vcType == CustomWebViewFull || self.vcType == CustomWebViewHorizontalScreenFull) {
        // 初始化小球
        [KKConfig share].isLandscape = self.vcType == CustomWebViewHorizontalScreenFull ? YES : NO;
        [self initDragbutton];
    }else{
        self.isShowLeftBack = YES;
        // 开启竖屏
        [self portraitVc];
    }
    // 从后台进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appFormBacToFront) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // 点击活动的条目
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activeSelectItem:) name:@"activeSelectItem" object:nil];
    
    // 检查是否有网
    [self checkIsNetwork];
}

// 视图将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 设置导航代理
    self.navigationController.delegate = self;
}

/// 从后台进入前台
-(void)appFormBacToFront{
    
    if ([[KKTool getCurrentVC] isMemberOfClass:[self class]] && [self isCurrentViewControllerVisible:self]) {
        [self webViewCallTwo:[KKWebViewEventModel viewwillApperNofiJs]];
        [self updateUserLeverInfor];//后台进前台刷新用户信息
    }
}

// 活动页面点击cell
-(void)activeSelectItem:(NSNotification *)nofi{
    if (nofi.object) {
        
        // call2webview('{"event": "enterActByIdx", "data": "1"}')
        
        NSDictionary * params = @{@"event":@"enterActByIdx",@"data":[nofi object]};
        // 字典转字符串
        [self webViewCallTwo:[KKTool convertToJsonData:params]];
    }
}

-(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

// 视图已经出现
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.isFirstFrom) {
        self.isFirstFrom = NO;
    }else{
        // 每次进入webview中
        [self webViewCallTwo:[KKWebViewEventModel viewwillApperNofiJs]];
    }
    
    // 全屏
    if (self.vcType == CustomWebViewHorizontalScreenFull) {
        self.meunView.frame = CGRectMake(0, 0,KK_SCREEN_HEIGHT, KK_SCREEN_HEIGHT);
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.rotateDirection = YES;
        // 开启横屏
        [self zoomInWithDirection:UIInterfaceOrientationLandscapeLeft];
        
        // 禁用返回手势
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }else{
        [self portraitVc];
        // 开启返回手势
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

// 每次进入都会调用 parent 则代表侧滑返回成功
-(void)didMoveToParentViewController:(UIViewController *)parent{
    if (self.isFirstFrom == NO && parent == nil) {
        [self removeMessageHandle];
    }
}

-(void)removeMessageHandle{
    [_wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"call2native"];
}


// 开启竖屏
-(void)portraitVc{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.rotateDirection = NO;
    // 开启竖屏
    [self zoomInWithDirection:UIInterfaceOrientationPortrait];
}

- (void)zoomInWithDirection:(UIInterfaceOrientation)orientation
{
    [self enterLandscapeFullScreen:UIInterfaceOrientationLandscapeLeft animated:NO];
}
- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation animated:(BOOL)animated
{
    [UIDevice setOrientation:orientation];
}

// 初始化全局悬浮小球
- (void)initDragbutton{
    
    // 悬浮小球
    self.suspensionButton = [KKClearButton buttonWithType:(UIButtonTypeCustom)];
    self.suspensionButton.frame = CGRectMake([KKConfig share].suspensionButtonX, [KKConfig share].suspensionButtonY, 55, 55);
    if (kScreenWidth/2> [KKConfig share].suspensionButtonX) {
        [self.suspensionButton setBackgroundImage:[UIImage imageNamed:@"webview_menu_left_ic"] forState:UIControlStateNormal]; // 在左边
    }else{
        [self.suspensionButton setBackgroundImage:[UIImage imageNamed:@"webview_menu_right_ic"] forState:UIControlStateNormal]; // 在右边
    }
    [self.view addSubview:self.suspensionButton];
    WS
    [self.suspensionButton pj_addDragMovingAdhere:YES mainViewHeight:self.vcType == CustomWebViewHorizontalScreenFull ? KK_SCREEN_WIDTH : self.view.frame.size.height  clickBlock:^(UIButton * _Nonnull button) {
        SS
        self.suspensionButton.isClicked =! self.suspensionButton.isClicked;
        if (self.meunView.hidden == YES) {
            // 出现
            self.meunView.hidden = NO;
            // 悬浮按钮最前
            [self.view bringSubviewToFront:button];
            // 出现功能按钮
            [self.meunView showTheMenuViewWithButtonFrame:button.frame];
        }else{
            // 消失视图
            [self.meunView dismissTheMenuView];
        }
    }];
    
    // 小球移动的位置
    [self.suspensionButton setMoveBlock:^(BOOL isLeft) {
        SS
        if (isLeft == YES) {
            [self.suspensionButton setBackgroundImage:[UIImage imageNamed:@"webview_menu_left_ic"] forState:UIControlStateNormal];
        }else{
            [self.suspensionButton setBackgroundImage:[UIImage imageNamed:@"webview_menu_right_ic"] forState:UIControlStateNormal];
        }
    }];
    
    // 是否显示充值按钮
    if (self.isShowPay == YES) {
        [self.meunView changeButtonIcon:1];
    }else{
        [self.meunView changeButtonIcon:0];
    }
}


// 添加视图
- (void)addViews{
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.meunView];

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- JS 调用 OC 时 webview 会调用此方法
// message.body JS执行传递的消息
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if (message.body) {
        NSDictionary* dic = [self dictionaryWithJsonString:message.body];
        NSString* method = [dic objectForKey:@"method"];
        if(method == NULL){
            return;
        }
        if ([method isEqualToString:@"openPage"]) {
            [self openPageWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"morebtn"]) {
            [self addRightButton:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"nomorebtn"]){
            [self hiddenRightButton];
        }else if ([method isEqualToString:@"doIap"]){
            // 内购
            [self applePay:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"pickerView"]){
            // 选择地区或银行
            [self selectAddressOrBank:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"updateWebviewTitle"]){
            [self updateNavTitleWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"request"]){
            // 为js创建一个请求实例
            [self forJsToCreateRequestWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"toast"]){
            // 显示toast弹窗
            [self forjsShowToastWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"close"]){
            [self removeMessageHandle];
            // 返回
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([method isEqualToString:@"loading"]){
            // 显示小球
            [self showLoadingViewWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"renderActList"]){
            [self forJsaddActiveView:[self dictionaryWithJsonString:message.body]];
        }
    }
}

/// 打开一个页面
/// @param paramDic js传的参数
-(void)openPageWithParams:(NSDictionary *)paramDic{
    if (paramDic != nil) {
        if ([paramDic objectForKey:@"objType"]) {
            if ([[paramDic objectForKey:@"objType"] isEqualToString:@"nativepage"]) {
                // 原生
                [self openNativePage:paramDic];
            }else if ([[paramDic objectForKey:@"objType"] isEqualToString:@"webviewpage"]){
                // webview
                [self openHybdPage:paramDic];
            }else if ([[paramDic objectForKey:@"objType"] isEqualToString:@"nativeweb"]){
                // 打开原生浏览器的协议，objType=nativeweb
                //  "webviewObj":"https://www.inke.com/"
                if ([paramDic objectForKey:@"webviewObj"]) {
                    [self goSystemSafari:[paramDic objectForKey:@"webviewObj"]];
                }
            }
        }
    }
}

/// 打开一个原生页面
/// @param paramDic 参数
-(void)openNativePage:(NSDictionary *)paramDic{
    if (paramDic != nil) {
        if ([paramDic objectForKey:@"nativeObj"]) {
            if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"kf"]) {
                // 打开客服页面
                [KKTool intoServerChat];
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"userpage"]){
                // 打开用户主页
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"svideo"]){
                // 打开二级视频列表
                // KKDownVideoVC * twoLevelVideoVC = [[KKDownVideoVC alloc]init];
                // [self.navigationController pushViewController:twoLevelVideoVC animated:YES];
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"invite"]){
                // 分享推广
              
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"invitelog"]){
                // 分享推广记录
              
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"social"]){
                [self removeMessageHandle];
                // 分享社区
              
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"activity"]){
                // 活动tab
                [self removeMessageHandle];
                // 活动tab
                [self.navigationController popToRootViewControllerAnimated:NO];
                [KKConfig share].mainTabbatViewController.selectedIndex = 2;
                [[KKConfig share].mainTabbatViewController mcTabBarController:[KKConfig share].mainTabbatViewController didSelectViewController:[CustomWebViewController new]];
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"live"]){
                // 直播界面
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"mobileBind"]){
                // 绑定手机号界面
                // 未绑定手机号
                LoginViewController *login = [[LoginViewController alloc]init];
                login.isWebviewFrom = YES;
                if ([KKUserInfo share].telephone.length >0) {
                    login.loginType = ChangePhone;
                    login.isUpdataPhone = YES;
                }else{
                    login.loginType = BindPhone;
                    login.isBingDingPhone = YES;
                }
                [self.navigationController pushViewController:login animated:YES];
            }
        }
    }
} 


/// 打开一个webview页面
/// @param paramDic 参数
-(void)openHybdPage:(NSDictionary *)paramDic{
    
    if (paramDic != nil) {
        NSInteger fullScreen = [[paramDic objectForKey:@"webviewFullScreen"] intValue];
        NSString * url = [paramDic objectForKey:@"webviewObj"];
        NSString * title = [paramDic objectForKey:@"webviewTitle"];
        
        // 悬浮小球是否显示充值按钮
        BOOL isShowPay = NO;
        if ([paramDic objectForKey:@"webviewEnableWallet"]) {
            if ([[paramDic objectForKey:@"webviewEnableWallet"] integerValue] == 1) {
                isShowPay = YES;
            }
        }
        // 即将打开webview的背景颜色，由js控制
        UIColor * viewColor;
        if ([paramDic objectForKey:@"bgColor"]) {
            viewColor = [KKColor colorWithstr:[paramDic objectForKey:@"bgColor"]];
        }
        // 是否横屏展示webview
        if ([paramDic objectForKey:@"webviewLandscape"] && [[paramDic objectForKey:@"webviewLandscape"] integerValue] == 1) {
            //if ([[paramDic objectForKey:@"webviewLandscape"] integerValue] == 1) {
                CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:CustomWebViewHorizontalScreenFull];
                newWeb.isShowPay = isShowPay;
                [self.navigationController pushViewController:newWeb animated:YES];
                newWeb.isCustomeColor = YES;
                newWeb.view.backgroundColor = viewColor;
            //}
        }else{
            CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:fullScreen==0?CustomWebViewNav:CustomWebViewFull];
            newWeb.isShowPay = isShowPay;
            [self.navigationController pushViewController:newWeb animated:YES];
            newWeb.isCustomeColor = YES;
            newWeb.view.backgroundColor = viewColor;
        }
    }
}

// 走苹果支付
-(void)applePay:(NSDictionary *)paramsDic{
    if ([paramsDic objectForKey:@"iapProductId"] && [paramsDic objectForKey:@"iapPayId"]) {
        [self pay:[paramsDic objectForKey:@"iapPayId"] productid:[paramsDic objectForKey:@"iapProductId"]];
    }
}

// 去系统浏览器
-(void)goSystemSafari:(NSString *)link{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link] options:@{} completionHandler:^(BOOL success) {
        if (success == YES) {
            NSLog(@"打开成功");
        }
    }];
}

-(void)pay:(NSString *)payid productid:(NSString *)produceid{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"支付请求中"];
    
    [[KKApplePay shareIAPManager]  addPurchWithProductID:produceid  completeHandle:^(IAPPurchType type, NSData * _Nonnull data) {
        [SVProgressHUD dismiss];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        KKWebPayType resultType;
        if (IAPPurchSuccess == type) {
            // 成功
            resultType = KKWebPaySuccess;
            [self updateUserLeverInfor];
        }
        else if(IAPPurchFailed == type){
            // 购买失败
            resultType = KKWebPayFail;
        }
        else if(IAPPurchCancel == type){
            // 取消购买
            resultType = KKWebPayCancel;
        }
        else if(IAPPurchVerFailed== type){
            // 订单校验失败
            resultType = KKWebPayOrderAuthFail;
        }
        else if(IAPPurchNotArrow== type){
            // 不允许内购
            resultType = KKWebPayNoUseApplePay;
        }
        // 通知js结果
        [self webViewCallTwo:[KKWebViewEventModel payResultCallBackJs:resultType]];
    } withPrepeID:payid];
}

// 添加导航按钮
-(void)addRightButton:(NSDictionary *)params{
    self.navRightButtonparamDic = params;
    if ([params objectForKey:@"menuTitle"]) {
        [self addRightButtonItemWith:[params objectForKey:@"menuTitle"]];
    }
}

// 导航按钮点击事件
-(void)rightButtonItemAction{
    [self openPageWithParams:self.navRightButtonparamDic];
}

// 更新导航标题
-(void)updateNavTitleWithParams:(NSDictionary *)paramDic{
    if ([paramDic objectForKey:@"webviewTitle"]) {
        NSString * title = [paramDic objectForKey:@"webviewTitle"];
        if (title.length >0) {
            self.navigationItem.title = title;
            
        }
    }
}

// 为js创建一个请求实例
-(void)forJsToCreateRequestWithParams:(NSDictionary *)params{
    self.jsRequestParams = params;
    [KKSecurityPolicy sendRequestWithRequest:params WithNetCore:^(NSString * _Nonnull requestID, id  _Nonnull message, NSString * _Nonnull httpCode, NSString * _Nonnull xerrCode) {
        [self requestResultToCallJsXerror:[xerrCode intValue] WithHttpCode:httpCode data:message requestid:[requestID intValue]];
    } failed:^(NSString * _Nonnull requestID, NSError * _Nullable error, NSString * _Nonnull httpCode, NSString * _Nonnull xerrCode) {
        [self requestResultToCallJsXerror:[xerrCode intValue] WithHttpCode:httpCode data:@"" requestid:[requestID intValue]];
    }];
}

// 为js提供显示的toast
-(void)forjsShowToastWithParams:(NSDictionary *)params{
    if ([params objectForKey:@"content"] != nil) {
        NSString * content = [NSString stringWithFormat:@"%@",[params objectForKey:@"content"]];
        
        [SVProgressHUD showMessage:content];
    }
}

// 选择地区或银行
-(void)selectAddressOrBank:(NSDictionary *)params{
    if ([params objectForKey:@"objType"]) {
        if ([[params objectForKey:@"objType"] isEqualToString:@"bank"]) {
            // bankJSON 是否为空
            if ([params objectForKey:@"bankJSON"]) {
                // 获取银行列表
                NSArray * banksArray = [params objectForKey:@"bankJSON"];
                // 初始化默认选中下标
                NSString * defaulString;
                if ([params objectForKey:@"now"]) {
                    defaulString = [params objectForKey:@"now"];
                }
                
//                else{
//                    // 找不到默认选择下标0
//                    defaulString = banksArray[0];
//                }
                // 是否可以找到下标
                NSInteger index = 0;
                if ([banksArray containsObject:defaulString]) {
                    index = [banksArray indexOfObject:defaulString];
                }
                [self selectBank:banksArray defaultIndex:index params:params defauletString:defaulString];
            }else{
                [SVProgressHUD showMessage:@"无数据，无法唤起银行列表"];
            }
        }else if ([[params objectForKey:@"objType"] isEqualToString:@"area"]) {
            // 初始化默认选中下标 componentsSeparatedByString
            NSArray * defaulString;
            if ([params objectForKey:@"now"]) {
                NSString * now = [params objectForKey:@"now"];
                if (now.length != 0) {
                    defaulString = [[params objectForKey:@"now"] componentsSeparatedByString:@" "];
                }else{
                    // 找不到默认选择下标0
                    defaulString = @[@0,@0,@0];
                }
            }else{
                // 找不到默认选择下标0
                defaulString = @[@0,@0,@0];
            }
            [self selectAddress:defaulString];
        }
    }
}

// 选择地区
-(void)selectAddress:(NSArray *)defaultArray{
    WS
    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[defaultArray[0], defaultArray[1], defaultArray[2]] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
        SS
        NSString * addressName = [NSString stringWithFormat:@"%@ %@ %@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
        [self.wkWebView evaluateJavaScript:[NSString stringWithFormat:@"call2webviewHandles.pickerViewResult('area','%@')",addressName] completionHandler:^(id _Nullable, NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    }];
}

// 选择银行
-(void)selectBank:(NSArray *)bankNames defaultIndex:(NSInteger)index params:(NSDictionary *)params defauletString:(NSString *)defauletString{
    
//    NSString * defauletString;
//    if (index < bankNames.count - 1) {
//        defauletString = bankNames[index];
//    }else{
//        defauletString = bankNames[0];
//    }
    
    
    // 初始化银行选择器
    self.selectBankListView = [[KKSelectBankListView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.selectBankListView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:self.selectBankListView];
    self.selectBankListView.params = params;
    self.selectBankListView.locationStr = defauletString;
    // 传入银行数据
    self.selectBankListView.banksArray = (NSMutableArray *)bankNames;
    WS
    [self.selectBankListView setBankBlock:^(NSString * _Nonnull bankName) {
        SS
        [self.wkWebView evaluateJavaScript:[NSString stringWithFormat:@"call2webviewHandles.pickerViewResult('bank','%@')",bankName] completionHandler:^(id _Nullable, NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    }];
}

// 为js提供loading
-(void)showLoadingViewWithParams:(NSDictionary *)params{
    if (params.allKeys>0) {
        if ([params objectForKey:@"show"]) {
            [KKLoadingView showFullScreen];
        }else if ([params objectForKey:@"hide"]){
            [KKLoadingView hidden];
        }
    }
}


/// 为js添加一个页面
/// @param params 参数
-(void)forJsaddActiveView:(NSDictionary *)params{
    [self.view addSubview:self.activeView];
    [self.activeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.activeView.params = params;
    
}

#pragma mark -- 加载页面
- (void)loadRequest:(NSString *)webUrl{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    [self.wkWebView loadRequest:request];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //网页title
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.wkWebView){
            self.navigationItem.title = self.wkWebView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma makr -- 点击返回按钮
-(void)back:(UITapGestureRecognizer *)tap{
    // 调用js
    NSString *jsFounction = [NSString stringWithFormat:@"jsFunctionHideModal('')"];
    [self.wkWebView evaluateJavaScript:jsFounction completionHandler:^(id object, NSError * _Nullable error) {
        if (error == nil) {
        }
    }];
}
// 创建webview
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        // app提供；打开一个原生或webview页面
        [userContentController addScriptMessageHandler:self name:@"call2native"];
        configuration.userContentController = userContentController;
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        // 开启会导致前端 字体 页面布局不对。
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:configuration];
        _wkWebView.navigationDelegate = self;
        _wkWebView.scrollView.bounces = NO;
        _wkWebView.UIDelegate = self;
        [_wkWebView.scrollView setBackgroundColor:[UIColor clearColor]];
        _wkWebView.opaque = NO;
        if(@available(iOS 11.0, *)) {
            _wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _wkWebView;
}
// 自定义菜单视图
-(CoustomWebMenuView *)meunView{
    if (!_meunView) {
        _meunView = [[CoustomWebMenuView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT)];
        _meunView.hidden = YES;
        _meunView.delegate = self;
    }
    return _meunView;
}

-(KKActivityView *)activeView{
    if (!_activeView) {
        _activeView = [[KKActivityView alloc]initWithFrame:CGRectZero];
        WS
        [_activeView setParmeToDataArrBlock:^(BOOL isHidden) {
            SS
            [KKNodateView disMissWithLoadFailViewWithShowView:self.view];
        }];
        
    }
    return _activeView;
}

// 点击悬浮按钮出现遮罩，遮罩中的按钮点击事件
-(void)clickMeunButtonType:(CoustomWebMenuViewType)buttonType{
    if (buttonType == CoustomWebMenuViewCancelType) {
        [self removeMessageHandle];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonType == CoustomWebMenuViewReloadType){
        [self.wkWebView reload];
    }else if (buttonType == CoustomWebMenuViewBackType){
        if (self.wkWebView.canGoBack == YES) {
            [self.wkWebView goBack];
        }else{
            [self removeMessageHandle];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if(buttonType == CoustomWebMenuViewSelfHiddenType){
    }else if (buttonType == CoustomWebMenuViewPay){
        // 充值
        CustomWebViewController * cusvc = [[ CustomWebViewController alloc] initWithUrl:[KKTool getWalletUrl] title:@"" vcType:CustomWebViewNav];
        [self.navigationController pushViewController:cusvc animated:YES];
    }
    self.suspensionButton.isClicked = NO;
}

#pragma mark - WKNavigationDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


// 检查是否有网络
-(void)checkIsNetwork{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[NetWrokStatesCtrl getInstance] isRealyNetAvailable] == NO) {
            self.wkWebView.hidden = YES;
            self.view.backgroundColor = [KKColor getColor:appBgColor];
            // 出现加载失败视图
            [KKNodateView showMySelfLoadFailViewWithLoadState:KKLoadFail withShowView:self.view withAssignLoadBlock:^{
                if ([[NetWrokStatesCtrl getInstance] isRealyNetAvailable] == YES) {
                    
                    self.wkWebView.hidden = NO;
                    self.view.backgroundColor = self.selfColor;
                    
                    // 重新加载webview
                    [self loadRequest:self.url];
                    [KKNodateView disMissWithLoadFailViewWithShowView:self.wkWebView];
                }else{
                    [self checkIsNetwork];
                }
            }];
        }
    });
}


// 拦截web弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    if (self) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionHandler();
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    if (self) {
        //    DLOG(@"msg = %@ frmae = %@",message,frame);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            completionHandler(NO);
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionHandler(YES);
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    if (self) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = defaultText;
        }];
        [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionHandler(alertController.textFields[0].text?:@"");
        }])];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHidden = NO;
    [self.navigationController setNavigationBarHidden:isHidden animated:YES];
}

// webview加载完成传送参数
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.navigationItem.title = self.wkWebView.title;
    [self webViewCallTwo:[KKWebViewEventModel callbackTwoWebviewConversionData:NO]];
}

/// 公共事件调用js
/// @param params 参数
-(void)webViewCallTwo:(NSString *)params{
    NSLog(@"---  %@",params);
    // 字典转字符串
    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"call2webview('%@')",params] completionHandler:^(id _Nullable, NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

/// 网络请求成功后通知js
/// @param code 错误码  0  -1
/// @param data 数据
///
-(void)requestResultToCallJsXerror:(int)xerror WithHttpCode:(NSString *)httpCode  data:(id)data requestid:(int)requestid{
    
    [self.wkWebView evaluateJavaScript:[NSString stringWithFormat:@"window.call2webviewHandles.reqResult[%d](%@,%d,'%@')",requestid,httpCode,xerror,data] completionHandler:^(id _Nullable, NSError * _Nullable error) {
    }];
}


///更新用户会员信息
-(void)updateUserLeverInfor{
    [KKMySelfModel reqRefehUserBaseInfo:^(appvapiUserInfoBasic  *_Nonnull message) {
        //[KKUserInfo share].vip = message.vip;
        [KKUserInfo share].member_level = message.memberLevel;
        [KKUserInfo share].member_expiration_time = message.memberExpirationTime;
        [[KKPubTagVCModel shareToolGetManager]getMemberReloadInfo:^{
            
        }];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:VIPBACKRELOADDATACENTER object:nil];

    } :^(requestErrorCode errorCode) {
    }];
}

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        [SVProgressHUD showMessage:@"数据解析失败"];
        return nil;
    }
    return dic;
}

-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    
    if (![self.url containsString:[richers getAddr:YES]]) {
        if(completionHandler) {
            completionHandler(nil, nil);
            
        }
    }else{
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        NSURLCredential*credential =nil;
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
            if([self myCustomValidation:challenge]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(credential) {
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }else{
                
                /* 无效的话，取消 */
                disposition =NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                
            }
        }
        else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate])
            
        {//客户端认证
            
            NSData *PKCS12Data = [KKTool getHttpsP12];
            
            CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(PKCS12Data);
            
            SecIdentityRef identity;
            // 读取p12证书中的内容
            OSStatus result = [self extractP12Data:inPKCS12Data toIdentity:&identity];
            if(result !=errSecSuccess){
                completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
                return;
                
            }
            SecCertificateRef certificate =NULL;
            SecIdentityCopyCertificate(identity, &certificate);
            const void*certs[] = {certificate};
            CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
            credential = [NSURLCredential credentialWithIdentity:identity certificates:(NSArray*)CFBridgingRelease(certArray)
                                                     persistence:NSURLCredentialPersistencePermanent];
            if(credential) {
                disposition =NSURLSessionAuthChallengeUseCredential;
                
            }
            
        }
        if(completionHandler) {
            completionHandler(disposition, credential);
            
        }
    }
}

-(OSStatus) extractP12Data:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity {
    return  [KKTool extractIdentity:inP12Data toIdentity:identity];
    
}

- (BOOL)myCustomValidation:(NSURLAuthenticationChallenge*)challenge

{
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    SecTrustResultType result;
    
    // 证书的路径，此证书存放在项目目录下
    NSData *certData = [KKTool getHttpsCer];
    SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certData);
    
    NSMutableArray *cerArray;
    [cerArray addObject:(__bridge_transfer id)(certificate)];
    SecTrustSetAnchorCertificates(trust, (__bridge CFArrayRef)cerArray);
    SecTrustSetAnchorCertificatesOnly(trust, false);
    
    OSStatus status = SecTrustEvaluate(trust, &result);
    
    if(status == errSecSuccess && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified)){
        return YES;
    }
    return YES;
}


-(void)dealloc{
    NSLog(@"自定义H5页面释放了");
    //    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end




/*
 1.打开页面统一方法
 openPage({
 objType: ''// nativepage / webviewpage
 nativeObj: '' // 原生模块
 uid...
 webviewObj: '' // 网页url
 webviewFullScreen: 1
 })
 
 2.设置hybird页面右上角菜单统一方法
 setHybdRightMenu({
 menuTitle: '',
 objType: ''// nativepage / webviewpage
 nativeObj: '' // 原生模块
 uid...
 webviewObj: '' // 网页url
 webviewFullScreen: 1
 })
 
 3.删除hybird页面右上角菜单
 removeHybdRightMenu()
 
 
 可打开原生的界面包括
 obj {
 kf, // 客服界面
 userpage, // 某人用户信息，额外会附带 uid 参数
 svideo, // 某个短视频详情页面，额外会附带 vid 参数
 membercenter, // 会员卡购买
 invite // 分享邀请界面
 }
 
 */






/*
 
 ucToken
 apiToken
 用户id， __userId  (string)
 昵称， __userNickName (string)
 会员等级，__memberLevel (int)
 过期时间，__memberExpirationTime (int)
 创作等级 __creationLevel (int)
 普通用户 0
 达人 1
 明星 2
 企业 3
 官方 999
 
 
 */
