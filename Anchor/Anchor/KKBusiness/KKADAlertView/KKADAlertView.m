//
//  KKADAlertView.m
//  mt
//
//  Created by 小鱼 on 2021/10/11.
//

#import "KKADAlertView.h"
#import <WebKit/WebKit.h>
#import "AppLinkDomainMgr.h"
#import "KKWebViewEventModel.h"
#import "KKMainWebView.h"
@interface KKADAlertView ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,KKMainWebViewDelegate>
@property (nonatomic,strong) KKMainWebView *webView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong)NSArray *urlArray;
@end
@implementation KKADAlertView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.index = 0;
        
    }
    return self;
}
-(void)setUpView{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.frame = [UIScreen mainScreen].bounds;
    [window addSubview:self];
    
    CGFloat x = 55;
    CGFloat h = 300;
    CGFloat w = window.bounds.size.width - 2*x;
    CGFloat y = (window.bounds.size.height -h)/2;
//    [self.webView setFrame:CGRectMake(x, y, w, h)];
   
  
    CGFloat bh = 30;
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    closeBtn.layer.borderWidth = 1.5;
    [closeBtn.layer setCornerRadius:bh/2];
    [closeBtn.layer setMasksToBounds:YES];
    [self addSubview:closeBtn];
   
    
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [self addSubview:self.webView];
    
    serviceapplinkNotice*  adVer = self.urlArray[self.index];
    NSArray *array = [adVer.aspectRatio componentsSeparatedByString:@":"];
    
//    CGFloat scale = [UIScreen mainScreen].scale;
    if (array.count==2) {
         w = [array[0] integerValue];
         h = [array[1] integerValue];
    }
   
    CGFloat rate = w/750;
//    CGFloat hs = w/h;
//    w= ws * w;
//    h = w * hs;
    
    CGFloat webviewW = rate *self.frame.size.width;
    CGFloat webviewH = webviewW/( w/h);
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
            make.width.equalTo(@(webviewW));
            make.height.equalTo(@(webviewH));
    }];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.webView);
        make.top.equalTo(self.webView.mas_bottom).offset(15);
        make.width.equalTo(@85);
        make.height.equalTo(@(bh));
    }];
}
-(void)loadRequestWithArray:(NSArray *)urlArray withIndex:(NSInteger)index{
   
    self.urlArray = urlArray;
    self.index = index;
    [self setUpView];
    
    [self loadWebView];
}
- (KKMainWebView *)webView {
    if (!_webView) {
        _webView = [[KKMainWebView alloc] init];
        _webView.isShowView = YES;
        _webView.delegate = self;
    }
    return _webView;
}
///懒加载webView
//- (KKMainWebView *)webView {
//    if (!_webView) {
////        [userContentController addScriptMessageHandler:self name:@"call2native"];
//        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//        // app提供；设置导航右上角按钮原生
////        [userContentController addScriptMessageHandler:self name:@"morebtn"];
//        // app提供；打开一个原生或webview页面
//        [userContentController addScriptMessageHandler:self name:@"call2native"];
//        //// app提供；隐藏导航右上角按钮
////        [userContentController addScriptMessageHandler:self name:@"nomorebtn"];
//        configuration.userContentController = userContentController;
//        WKPreferences *preferences = [WKPreferences new];
//        preferences.javaScriptCanOpenWindowsAutomatically = YES;
//        configuration.preferences = preferences;
//
//        // 开启会导致前端 字体 页面布局不对。
//        _webView = [[KKMainWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:configuration];
////        _webView.navigationDelegate = self;
////        _webView.scrollView.bounces = NO;
////        _webView.UIDelegate = self;
////        _webView.scrollView.scrollEnabled = NO;
////        [_webView.layer setCornerRadius:8];
////        [_webView.layer setMasksToBounds:YES];
////        [_webView.scrollView setBackgroundColor:[UIColor clearColor]];
////        _webView.opaque = NO;
//        //[_wkWebView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#14151B'"completionHandler:nil];
////        _webView.backgroundColor = [UIColor redColor];
////        if(@available(iOS 11.0, *)) {
////            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
////        }
//    }
//    return _webView;
//}

/// 打开一个页面
/// js传的参数
//-(void)openPageWithParams:(NSDictionary *)paramDic{
//    if (paramDic != nil) {
//        if ([paramDic objectForKey:@"objType"]) {
//            if (self.openNewPage) {
//                self.openNewPage(self.index);
//            }
//            if ([[paramDic objectForKey:@"objType"] isEqualToString:@"nativepage"]) {
//                // 原生
//                [self openNativePage:paramDic];
//            }else if ([[paramDic objectForKey:@"objType"] isEqualToString:@"webviewpage"]){
//                // webview
//                [self openHybdPage:paramDic];
//            }
//            [self dismissView];
//        }
//    }
//}

    /// 打开一个原生页面
    /// @param paramDic 参数
//-(void)openNativePage:(NSDictionary *)paramDic{
//    if (paramDic != nil) {
//        if ([paramDic objectForKey:@"nativeObj"]) {
//            if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"kf"]) {
//                    // 打开客服页面
//                [KKTool intoServerChat];
//            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"userpage"]){
//                    // 打开用户主页
////                KKOtherVideoMainPageVC * otherVc = [[KKOtherVideoMainPageVC alloc]init];
////                otherVc.userInfo = nil;
////                [self.navigationController pushViewController:otherVc animated:YES];
//            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"svideo"]){
//                    // 打开二级视频列表
//    //                KKDownVideoVC * twoLevelVideoVC = [[KKDownVideoVC alloc]init];
//    //                [self.navigationController pushViewController:twoLevelVideoVC animated:YES];
//                }
//            }
//        }
//    }

    /// 打开一个webview页面
    /// @param paramDic 参数
//-(void)openHybdPage:(NSDictionary *)paramDic{
//        if (paramDic != nil) {
//            NSInteger fullScreen = [[paramDic objectForKey:@"webviewFullScreen"] intValue];
//            NSString * url = [paramDic objectForKey:@"webviewObj"];
//            NSString * title = [paramDic objectForKey:@"webviewTitle"];
//            CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:fullScreen==0?CustomWebViewNav:CustomWebViewFull];
//            UIViewController *vc = [KKTool getCurrentVC];
//            [vc.navigationController pushViewController:newWeb animated:YES];
//        }
//    }

//#pragma mark - WKNavigationDelegate
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"开始加载");
//}
//
//-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    //    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__ucToken('%@')",[KKUserInfo share].ucToken]completionHandler:nil];
//    //    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__apiToken('%@')",[KKUserInfo share].apiToken]completionHandler:nil];
//    [self webViewCallTwo:[KKWebViewEventModel callbackTwoWebviewConversionData]];
//}
//
//-(void)webViewCallTwo:(NSString *)params{
//    // 字典转字符串
//    [_webView evaluateJavaScript:[NSString stringWithFormat:@"call2webview('%@')",params] completionHandler:^(id _Nullable, NSError * _Nullable error) {
//    }];
//}


//- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    NSLog(@"加载失败");
//}
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSLog(@"webView.URL = %@",webView.URL);
//    /*
//    if ([webView.URL.absoluteString containsString:@"ptlogin2.qq.com"]) {
//        NSURL *url = [NSURL URLWithString:@"wtloginmqq://ptlogin/qlogin"];
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }
//     */
//
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
//
//    }else {
//        //允许访问
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//
//}

#pragma mark - WKUIDelegate
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    NSLog(@"%@",navigationAction.request.URL);
//    if (!navigationAction.targetFrame.isMainFrame) {
//        [webView loadRequest:navigationAction.request];
//    }
////    if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
////        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
////    }
//    return nil;
//}
//
//// 拦截web弹窗
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
////    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
////    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        completionHandler();
////    }])];
////    [self presentViewController:alertController animated:YES completion:nil];
//
//    [KKTool showSystemAlertWithTitle:message message:nil isShowCancel:NO completion:^{
//        completionHandler();
//    }];
//}
//
//
//#pragma mark - WKScriptMessageHandler
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    if (message.body) {
//        NSDictionary* dic = [self dictionaryWithJsonString:message.body];
//        NSString* method = [dic objectForKey:@"method"];
//        if(method == NULL){
//            return;
//        }
//        if ([method isEqualToString:@"openPage"]) {
//            [self openPageWithParams:[self dictionaryWithJsonString:message.body]];
//        }else if ([method isEqualToString:@"morebtn"]) {
////            [self addRightButton:[self dictionaryWithJsonString:message.body]];
//        }else if ([method isEqualToString:@"nomorebtn"]){
////            [self hiddenRightButton];
//        }
//    }
//}

// webview 内部跳转到其他控制器了
-(void)pushSecondVC{
    [self closeBtnAction];
}

-(void)closeBtnAction{
    [self remoAlert];
}
-(void)loadWebView{
    serviceapplinkNotice*  adVer = self.urlArray[self.index];
    NSString *urlStr = adVer.noticeURL;
    ///非http开头时 拼接公告域名
    if (![urlStr hasPrefix:@"http"]&&![urlStr hasPrefix:@"https"]) {
//        NSString *doMainStr = [[AppLinkDomainMgr shareMgr] getUrlByRequestType:DomainTypeNoticeResource];
        NSString *doMainStr = [richers getAddr:false];
        urlStr = [doMainStr stringByAppendingString:urlStr];
    }
    self.webView.webViewUrl = urlStr;
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];

    }
-(void)remoAlert{
    for (UIView *vie in self.subviews) {
        [vie removeFromSuperview];
    }
    self.webView =nil;
    if (self.index != self.urlArray.count-1) {
        self.index++;
        [self loadWebView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self  setUpView];
        });
        
    }
    else{
        [self removeFromSuperview];
    }
}
//-(void)dismissView{
//    [self removeFromSuperview];
//}
//-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
//    if (jsonString == nil) {
//        return nil;
//    }
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if(err){
//        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
//    return dic;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
