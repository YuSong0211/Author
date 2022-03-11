//
//  KKWebViewController.m
//  KK
//
//  Created by Gwynne on 2021/7/21.
//

#import "KKWebViewController.h"
#import <WebKit/WebKit.h>

@interface KKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation KKWebViewController

///初始化方法
- (instancetype)initWithUrl:(nonnull NSString *)urlString {
    if (self = [self init]) {
        self.urlString = urlString;
    }
    return self;
}

///懒加载webView
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT) configuration:config];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView loadRequest:[self getrequsetWithString:self.urlString]];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.tintColor = KK_THEMECOLOR;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (__kindof NSURLRequest *)getrequsetWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    return requset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self removeData];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)dealloc {
    NSLog(@"释放了");
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)backAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else {
        [super backAction];
    }
}

- (void)initSubViews {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@3);
    }];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"Share"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        NSLog(@"%f",(CGFloat)_webView.estimatedProgress);
        if (self.webView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)removeData {
    // 清除所有
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];

    /// Date from
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    /// Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // Done
        NSLog(@"清楚缓存完毕");
    }];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    self.title = self.webView.title;
    /*
    //调用js方法
    NSDictionary *qy_environment = @{
                                     @"environVar":ENVIRONVAR,
                                     };
    NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@')",[GYManager convertToJsonData:qy_environment]];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
    */
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"webView.URL = %@",webView.URL);
    if ([webView.URL.absoluteString rangeOfString:@"baidu"].location != NSNotFound) {
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    }else {
        self.navigationController.navigationBar.barTintColor = KKMainColor;
    }
    
    /*
    if ([webView.URL.absoluteString containsString:@"ptlogin2.qq.com"]) {
        NSURL *url = [NSURL URLWithString:@"wtloginmqq://ptlogin/qlogin"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
     */
    
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        
    }else {
        //允许访问
        decisionHandler(WKNavigationActionPolicyAllow);
    }
 
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    NSLog(@"%@",navigationAction.request.URL);
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
//    if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//    }
    return nil;
}

// 拦截web弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"Share"]) {
        NSDictionary *dict = message.body;
        NSLog(@"%@",dict);
        if (dict) {
            NSString *value = dict[@"type"];
            NSString *name = dict[@"key"];
            if (self.didReceiveScriptMessageCallBack) {
                self.didReceiveScriptMessageCallBack(value);
            }
            if ([name isEqual:@"changeTitle"]) {
                self.title = @"changeTitle";
//                NSAssert(NO, @"断言——————-");
         
            }else if ([name isEqual:@"closePage"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([name isEqual:@"changeColor"]) {
                if ([value isEqual:@"red"]) {
                    ;
                }
            }
        }
    }


}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHidden = [viewController isKindOfClass:[KKWebViewController class]];
    [self.navigationController setNavigationBarHidden:!isHidden animated:YES];
}


@end
