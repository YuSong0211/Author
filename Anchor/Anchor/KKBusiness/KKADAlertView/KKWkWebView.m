//
//  KKWkWebView.m
//  mt
//
//  Created by 小鱼 on 2021/10/11.
//

#import "KKWkWebView.h"
#import <WebKit/WebKit.h>
#import "CoustomWebMenuView.h"
static void *WKProgressContext = &WKProgressContext;
static void *WKTitleContext = &WKTitleContext;
@interface KKWkWebView()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *wkWebView;
// 进度条
@property (nonatomic, strong) UIProgressView *progressView;
// 悬浮按钮蒙层
@property (nonatomic,strong) CoustomWebMenuView * meunView;
// 悬浮按钮
@property (nonatomic,strong) UIButton * suspensionButton;
// 当前控制器类型，全屏还是带有导航
@property (nonatomic,assign)CustomWebViewType vcType;
// 导航按钮的参数
@property (nonatomic,strong)NSDictionary * navRightButtonparamDic;
@end
@implementation KKWkWebView
/// 重写本类init方法
/// @param webURL webView链接
/// @param vcType 控制器类型
-(instancetype)initWithUrl:(NSString *)webURL title:(NSString *)title vcType:(CustomWebViewType)vcType{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

//-(void)viewDidLoad{
//    [super viewDidLoad];
//    [self removeData];
//    // 添加视图
//    [self addViews];
//    // 添加监听
//    //[self addKvo];
//    if (self.url.length>0) {
//        // 加载html
//        [self loadRequest:self.url];
//    }
//
//    if (self.vcType == CustomWebViewFull) {
//        // 初始化小球
//        [self initDragbutton];
//    }else{
//
//    }
//}

// 视图将要出现
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    // 设置导航代理
//    self.navigationController.delegate = self;
//}

// 初始化全局悬浮小球
//- (void)initDragbutton{
//
//    // 悬浮小球
//    self.suspensionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.suspensionButton.frame = CGRectMake(30, 150, 55, 55);
//    [self.suspensionButton setBackgroundImage:[UIImage imageNamed:@"webview_menu_left_ic"] forState:UIControlStateNormal];
//    [self.view addSubview:self.suspensionButton];
//    WS
//    [self.suspensionButton pj_addDragMovingAdhere:YES mainViewHeight:self.view.frame.size.height - KK_NAV_BAR_HEIGHT  clickBlock:^(UIButton * _Nonnull button) {
//        SS
//        self.suspensionButton.isClicked =! self.suspensionButton.isClicked;
//        if (self.meunView.hidden == YES) {
//            // 出现
//            self.meunView.hidden = NO;
//            // 悬浮按钮最前
//            [self.view bringSubviewToFront:button];
//            // 出现功能按钮
//            [self.meunView showTheMenuViewWithButtonFrame:button.frame];
//        }else{
//            // 消失视图
//            [self.meunView dismissTheMenuView];
//        }
//    }];
//
//    // 小球移动的位置
//    [self.suspensionButton setMoveBlock:^(BOOL isLeft) {
//        SS
//        if (isLeft == YES) {
//            [self.suspensionButton setBackgroundImage:[UIImage imageNamed:@"webview_menu_left_ic"] forState:UIControlStateNormal];
//        }else{
//            [self.suspensionButton setBackgroundImage:[UIImage imageNamed:@"webview_menu_right_ic"] forState:UIControlStateNormal];
//        }
//    }];
//}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    if (self.wkWebView.isLoading) {
//        [self.wkWebView stopLoading];
//    }
//    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
//    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
//        //当前视图控制器在栈中，故为push操作
//        NSLog(@"push");
//    }else if ([viewControllers indexOfObject:self] == NSNotFound) {
//        //当前视图控制器不在栈中，故为pop操作
//        NSLog(@"pop");
//        //self.navigationController.navigationBar.hidden = NO;
//        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress" context:WKProgressContext];
//        [self.wkWebView removeObserver:self forKeyPath:@"title" context:WKTitleContext];
//        [self.wkWebView removeFromSuperview];
//    }
//}

// 添加视图
- (void)addViews{
//    [self.view addSubview:self.wkWebView];
//    [self.view addSubview:self.progressView];
//    [self.view addSubview:self.meunView];
}

// 添加kvo检测
- (void)addKvo{
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:WKProgressContext];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:WKTitleContext];
}

#pragma mark -- JS 调用 OC 时 webview 会调用此方法
// message.body JS执行传递的消息
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
//    if (message.body) {
////        if ([message.name isEqualToString:@"call2native"]) {
////            [self openPageWithParams:[self dictionaryWithJsonString:message.body]];
////        }else if ([message.name isEqualToString:@"morebtn"]) {
////            [self addRightButton:[self dictionaryWithJsonString:message.body]];
////        }else if ([message.name isEqualToString:@"nomorebtn"]){
////            [self hiddenRightButton];
////        }
//        NSDictionary* dic = [self dictionaryWithJsonString:message.body];
//        NSString* method = [dic objectForKey:@"method"];
//        if(method == NULL){
//            return;
//        }
//        if ([method isEqualToString:@"openPage"]) {
//            [self openPageWithParams:[self dictionaryWithJsonString:message.body]];
//        }else if ([method isEqualToString:@"morebtn"]) {
//            [self addRightButton:[self dictionaryWithJsonString:message.body]];
//        }else if ([method isEqualToString:@"nomorebtn"]){
//            [self hiddenRightButton];
//        }
//    }
}

/// 打开一个页面
/// @param params js传的参数
-(void)openPageWithParams:(NSDictionary *)paramDic{
    if (paramDic != nil) {
        if ([paramDic objectForKey:@"objType"]) {
            if ([[paramDic objectForKey:@"objType"] isEqualToString:@"nativepage"]) {
                // 原生
                [self openNativePage:paramDic];
            }else if ([[paramDic objectForKey:@"objType"] isEqualToString:@"webviewpage"]){
                // webview
                [self openHybdPage:paramDic];
            }
        }
    }
}

/// 打开一个原生页面
/// @param paramDic 参数
-(void)openNativePage:(NSDictionary *)paramDic{
//    if (paramDic != nil) {
//        if ([paramDic objectForKey:@"nativeObj"]) {
//            if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"kf"]) {
//                // 打开客服页面
//                LatelyDao *dao = [[LatelyDao alloc] init];
//                dao.uid = @"uid";
//                dao.avatar = @"www.baidu.com";
//                dao.nickName = @"用户名称";
//                [KKTool intoChatPageWithLatelyDao:dao type:IMChat_SERVICE isFromeMessageListInto:NO userInfo:nil];
//            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"userpage"]){
//                // 打开用户主页
//                KKOtherVideoMainPageVC * otherVc = [[KKOtherVideoMainPageVC alloc]init];
//                otherVc.userInfo = nil;
//                [self.navigationController pushViewController:otherVc animated:YES];
//            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"svideo"]){
//                // 打开二级视频列表
////                KKDownVideoVC * twoLevelVideoVC = [[KKDownVideoVC alloc]init];
////                [self.navigationController pushViewController:twoLevelVideoVC animated:YES];
//            }
//        }
//    }
}

/// 打开一个webview页面
/// @param paramDic 参数
-(void)openHybdPage:(NSDictionary *)paramDic{
//    if (paramDic != nil) {
//        NSInteger fullScreen = [[paramDic objectForKey:@"webviewFullScreen"] intValue];
//        NSString * url = [paramDic objectForKey:@"webviewObj"];
//        NSString * title = [paramDic objectForKey:@"webviewTitle"];
//        CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:fullScreen==0?CustomWebViewNav:CustomWebViewFull];
//        [self.navigationController pushViewController:newWeb animated:YES];
//    }
}

// 添加导航按钮
-(void)addRightButton:(NSDictionary *)params{
    self.navRightButtonparamDic = params;
//    if ([params objectForKey:@"menuTitle"]) {
//        [self addRightButtonItemWith:[params objectForKey:@"menuTitle"]];
//    }
}

// 导航按钮点击事件
-(void)rightButtonItemAction{
    [self openPageWithParams:self.navRightButtonparamDic];
}

#pragma mark -- 加载页面
- (void)loadRequest:(NSString *)webUrl{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
}

#pragma mark -- frame
- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
    [self setViewPosition];
}
- (void)setViewPosition{
    self.progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2);
    self.wkWebView.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), KK_SCREEN_HEIGHT);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.wkWebView) {
//        [self.progressView setAlpha:1.0f];
//        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
//        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
//        if(self.wkWebView.estimatedProgress >= 1.0f){
//            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                [self.progressView setAlpha:0.0f];
//            } completion:^(BOOL finished) {
//                [self.progressView setProgress:0.0f animated:NO];
//            }];
//            // 隐藏加载小球
//            [KKLoadingView hideInView:self.view];
//        }
//    }//网页title
//    else if ([keyPath isEqualToString:@"title"]){
//        if (object == self.wkWebView){
//            self.title = self.wkWebView.title;
//        }else{
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//    }else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
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
        // app提供；设置导航右上角按钮原生
//        [userContentController addScriptMessageHandler:self name:@"morebtn"];
        // app提供；打开一个原生或webview页面
        [userContentController addScriptMessageHandler:self name:@"call2native"];
        //// app提供；隐藏导航右上角按钮
//        [userContentController addScriptMessageHandler:self name:@"nomorebtn"];
        configuration.userContentController = userContentController;
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        // 开启会导致前端 字体 页面布局不对。
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:configuration];
        _wkWebView.navigationDelegate = self;
        _wkWebView.scrollView.bounces = NO;
        _wkWebView.UIDelegate = self;
        [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        //[_wkWebView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#14151B'"completionHandler:nil];
        _wkWebView.backgroundColor = [KKColor getColor:appBgColor];
        if(@available(iOS 11.0, *)) {
            _wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _wkWebView;
}

// 进度条
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = KKRGBA(40, 208, 148, 1);
        _progressView.hidden = YES;
    }
    return _progressView;
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

// 点击悬浮按钮出现遮罩，遮罩中的按钮点击事件
-(void)clickMeunButtonType:(CoustomWebMenuViewType)buttonType{
    if (buttonType == CoustomWebMenuViewCancelType) {
        [SVProgressHUD showMessage:@"退出H5"];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonType == CoustomWebMenuViewReloadType){
        [SVProgressHUD showMessage:@"刷新当前页面"];
        [self.wkWebView reload];
    }else if (buttonType == CoustomWebMenuViewBackType){
        if (self.wkWebView.canGoBack == YES) {
            [SVProgressHUD showMessage:@"返回上一级H5"];
            [self.wkWebView goBack];
        }else{
            [SVProgressHUD showMessage:@"退出H5"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if(buttonType == CoustomWebMenuViewSelfHiddenType){
        [SVProgressHUD showMessage:@"隐藏"];
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

// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    self.wkWebView.hidden = YES;
    self.progressView.hidden = YES;
}


// 拦截web弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
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
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHidden = NO;
    if ([viewController isKindOfClass:[CustomWebViewController class]]) {
        isHidden = self.vcType==CustomWebViewFull?YES:NO;
    }else if ([viewController isKindOfClass:[KKChatMainViewController class]]){
        isHidden = NO;
    }else if ([viewController isKindOfClass:[KKChatMainViewController class]]){
        isHidden = NO;
    }
    [self.navigationController setNavigationBarHidden:isHidden animated:YES];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__ucToken('%@')",[KKUserInfo share].ucToken]completionHandler:nil];
    //    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__apiToken('%@')",[KKUserInfo share].apiToken]completionHandler:nil];
    
    NSLog(@"ucToken = %@    apiToken=%@",[KKUserInfo share].ucToken,[KKUserInfo share].apiToken);
    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__ucToken='%@'",[KKUserInfo share].ucToken]completionHandler:nil];
    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__apiToken='%@'",[KKUserInfo share].apiToken]completionHandler:nil];
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
        return nil;
    }
    return dic;
}

// 清除所有
- (void)removeData {
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    /// Date from
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    /// Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // Done
        NSLog(@"清除缓存完毕");
    }];
}

-(void)dealloc{
    NSLog(@"自定义H5页面释放了");
    //    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
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


















































