//
//  KKCoustomPayWebVC.m
//  mt
//
//  Created by 小草 on 2021/9/23.
//

#import "KKCoustomPayWebVC.h"
#import "KKPollingCheckManger.h"

@interface KKCoustomPayWebVC ()

@end

@implementation KKCoustomPayWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [KKLoadingView showInView:self.view];
    
    // 请求支付链接
    serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest * req = [serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest createRequest];
    req.request.paymentArgs = self.webPayId;
    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(serviceucPaymentMyh5CreatePrepayResponse * message) {
        // 将商品id存储
        [[KKPollingCheckManger sharManger].commodityIdArray addObject:message.prepayId];
        // 开启轮询是否成功
        [[KKPollingCheckManger sharManger] startPollingCheckTime:3 checkCount:100];
        [self loadRequest:message.h5RedirectURL];
    } failed:^(requestErrorCode errorCode) {
        [KKLoadingView hideInView:self.view];
        [SVProgressHUD showMessage:@"加载失败"];
    }];
}

-(void)dealloc{
    NSLog(@"释放");
}

@end
