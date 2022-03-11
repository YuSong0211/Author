//
//  KKMainWebView.m
//  mt
//
//  Created by 小草 on 2021/11/1.
//

#import "KKMainWebView.h"
#import <WebKit/WebKit.h>
#import "KKWebViewEventModel.h"
#import "KKSecurityPolicy.h"
#import "KKApplePay.h"
#import "KKMySelfModel.h"
#import "BRAddressPickerView.h"
#import "BRStringPickerView.h"

#import "KKMySelfVC.h"
@interface KKMainWebView ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation KKMainWebView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        // [self removeData];
        
        [self addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        
        //self.webViewUrl = [NSString stringWithFormat:@"%@wallet/in",webViewUrlTest];
        NSString *urlstr =[KKTool getShowWalletUrl];
        self.webViewUrl = urlstr;            //@"http://192.168.31.9:8083/?dev#!/wallet/in";
        // 从后台进入前台
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appFormBacToFront) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}


-(void)reloadWeb{
    [self appFormBacToFront];
}

/// 从后台进入前台
-(void)appFormBacToFront{
    NSLog(@"刷新了webview");
    [self webViewCallTwo:[KKWebViewEventModel viewwillApperNofiJs]];
}

-(void)setWebViewUrl:(NSString *)webViewUrl{
    _webViewUrl = webViewUrl;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webViewUrl]]];
}

///懒加载webView
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        // app提供；设置导航右上角按钮原生
        // app提供；打开一个原生或webview页面
        [userContentController addScriptMessageHandler:self name:@"call2native"];
        //// app提供；隐藏导航右上角按钮
        configuration.userContentController = userContentController;
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        
        // 开启会导致前端 字体 页面布局不对。
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.UIDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
        [_webView.layer setCornerRadius:8];
        [_webView.layer setMasksToBounds:YES];
        [_webView.scrollView setBackgroundColor:[UIColor clearColor]];
        _webView.opaque = NO;
        //[_wkWebView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#14151B'"completionHandler:nil];
        //_webView.backgroundColor = [UIColor redColor];
        if(@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate
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
            if (self.isShowView == YES) {
                if ([self.delegate respondsToSelector:@selector(pushSecondVC)]) {
                    [self.delegate pushSecondVC];
                }
            }
            [self openPageWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"morebtn"]) {
            //[self addRightButton:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"nomorebtn"]){
            //            [self hiddenRightButton];
        }else if ([method isEqualToString:@"doIap"]){
            // 内购
            [self applePay:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"pickerView"]){
            // 选择地区或银行
            [self selectAddressOrBank:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"updateWebviewTitle"]){
            //            [self updateNavTitleWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"request"]){
            // 为js创建一个请求实例
            [self forJsToCreateRequestWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"toast"]){
            // 显示toast弹窗
            [self forjsShowToastWithParams:[self dictionaryWithJsonString:message.body]];
        }else if ([method isEqualToString:@"close"]){
            // 返回
            [[KKTool getCurrentVC].navigationController popViewControllerAnimated:YES];
        }
    }
}

// 为js创建一个请求实例
-(void)forJsToCreateRequestWithParams:(NSDictionary *)params{
    [KKSecurityPolicy sendRequestWithRequest:params WithNetCore:^(NSString * _Nonnull requestID, id  _Nonnull message, NSString * _Nonnull httpCode, NSString * _Nonnull xerrCode) {
        [self requestResultToCallJsXerror:[xerrCode intValue] WithHttpCode:httpCode data:message requestid:[requestID intValue]];
    } failed:^(NSString * _Nonnull requestID, NSError * _Nullable error, NSString * _Nonnull httpCode, NSString * _Nonnull xerrCode) {
        [self requestResultToCallJsXerror:[xerrCode intValue] WithHttpCode:httpCode data:@"" requestid:[requestID intValue]];
    }];
    //    [KKSecurityPolicy sendRequestWithRequest:params WithNetCore:^(NSString * _Nonnull requestID, id  _Nonnull message) {
    //        [self requestResultToCallJs:0 data:message requestid:[requestID intValue]];
    //    } failed:^(NSString * _Nonnull requestID, NSError * _Nullable error) {
    //        [self requestResultToCallJs:-1 data:@"" requestid:[requestID intValue]];
    //    }];
}
/// 网络请求成功后通知js
/// @param code 错误码  0  -1
/// @param data 数据
-(void)requestResultToCallJsXerror:(int)xerror WithHttpCode:(NSString *)httpCode  data:(id)data requestid:(int)requestid{
    
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"window.call2webviewHandles.reqResult[%d](%@,%d,'%@')",requestid,httpCode,xerror,data] completionHandler:^(id _Nullable, NSError * _Nullable error) {
    }];
}
//-(void)requestResultToCallJs:(int)code data:(id)data requestid:(int)requestid{
//
//    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"window.call2webviewHandles.reqResult[%d](%d,'%@')",requestid,code,data] completionHandler:^(id _Nullable, NSError * _Nullable error) {
//    }];
//}
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
                if ([paramDic objectForKey:@"webviewObj"]) {
                    //                    [self goSystemSafari:[paramDic objectForKey:@"webviewObj"]];
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
        
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"invite"]){
                // 分享推广
               
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"invitelog"]){
                // 分享推广记录
            
            }else if ([[paramDic objectForKey:@"nativeObj"] isEqualToString:@"social"]){
                // 分享社区
          
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
            [[KKTool getCurrentVC].navigationController pushViewController:newWeb animated:YES];
            newWeb.isCustomeColor = YES;
            newWeb.view.backgroundColor = viewColor;
            //}
        }else{
            CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:url title:title vcType:fullScreen==0?CustomWebViewNav:CustomWebViewFull];
            newWeb.isShowPay = isShowPay;
            [[KKTool getCurrentVC].navigationController pushViewController:newWeb animated:YES];
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
                }else{
                    // 找不到默认选择下标0
                    defaulString = banksArray[0];
                }
                // 是否可以找到下标
                NSInteger index = 0;
                if ([banksArray containsObject:defaulString]) {
                    index = [banksArray indexOfObject:defaulString];
                }
                [self selectBank:banksArray defaultIndex:index];
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
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"call2webviewHandles.pickerViewResult('area','%@')",addressName] completionHandler:^(id _Nullable, NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    }];
}

// 选择银行
-(void)selectBank:(NSArray *)bankNames defaultIndex:(NSInteger)index{
    
    NSString * defauletString;
    if (index < bankNames.count - 1) {
        defauletString = bankNames[index];
    }else{
        defauletString = bankNames[0];
    }
    
    [BRStringPickerView showStringPickerWithTitle:@"选择银行" dataSource:bankNames defaultSelValue:bankNames[index] isAutoSelect:YES resultBlock:^(id selectValue){
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"call2webviewHandles.pickerViewResult('bank','%@')",selectValue] completionHandler:^(id _Nullable, NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    }];
}

///更新用户会员信息
-(void)updateUserLeverInfor{
    [KKMySelfModel reqRefehUserBaseInfo:^(appvapiUserInfoBasic  *_Nonnull message) {
        //[KKUserInfo share].vip = message.vip;
        [KKUserInfo share].member_level = message.memberLevel;
        [KKUserInfo share].member_expiration_time = message.memberExpirationTime;
        [[NSNotificationCenter defaultCenter]postNotificationName:VIPBACKRELOADDATACENTER object:nil];
    } :^(requestErrorCode errorCode) {
    }];
}

// 为js提供显示的toast
-(void)forjsShowToastWithParams:(NSDictionary *)params{
    if ([params objectForKey:@"content"] != nil) {
        NSString * content = [params objectForKey:@"content"];
        [SVProgressHUD showMessage:content];
    }
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
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__ucToken('%@')",[KKUserInfo share].ucToken]completionHandler:nil];
    //    [_wkWebView evaluateJavaScript:[NSString stringWithFormat:@"__apiToken('%@')",[KKUserInfo share].apiToken]completionHandler:nil];
    [self webViewCallTwo:[KKWebViewEventModel callbackTwoWebviewConversionData:NO]];
}

-(void)webViewCallTwo:(NSString *)params{
    // 字典转字符串
    [_webView evaluateJavaScript:[NSString stringWithFormat:@"call2webview('%@')",params] completionHandler:^(id _Nullable, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"call2webview 传入参数成功");
        }
    }];
}


- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"webView.URL = %@",webView.URL);
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
//
//    }else {
//        //允许访问
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    //允许访问
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    NSLog(@"%@",navigationAction.request.URL);
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

// 拦截web弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [KKTool showSystemAlertWithTitle:message message:nil isShowCancel:NO completion:^{
        completionHandler();
    } cancel:nil];
    
}

-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    if (![self.webViewUrl containsString:[richers getAddr:YES]]) {
        if(completionHandler) {
            completionHandler(nil, nil);
            
        }
    }else{
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        NSURLCredential*credential =nil;
        //
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust] || ![challenge.protectionSpace.host hasSuffix:[richers getAddr:YES]]){
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
        else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate]){
          
                //客户端认证
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



#pragma mark - WKScriptMessageHandler
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//
//}
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
@end
