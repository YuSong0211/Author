//
//  KKMySelfViewModel.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKMySelfViewModel.h"

@interface KKMySelfViewModel()
    
@property (nonatomic,strong) KKMySelfModel* myselfModel;
    
@end


@implementation KKMySelfViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
        [self initListener];
    }
    return self;
}

- (void)initData{
    self.myselfModel = [[KKMySelfModel alloc] init];
}

- (void)initListener{
    
    
}


//请求刷新用户信息
- (void)reqRefehUserInfo{
    [self.myselfModel reqRefehUserInfo:^(id  _Nonnull message) {
        [self.signalUpdateUserInfo sendNext:message];
    } :nil];
}

//初始化用户信息变化回调
-(RACSubject*)signalUpdateUserInfo{
    if(_signalUpdateUserInfo == nil){
        _signalUpdateUserInfo = [RACSubject subject];
    }
    return _signalUpdateUserInfo;
}

//+ (void)requestWalletMoney:(requestWalletMoney)moneyBlock{
//    
//    serviceucWalletApiamountsAmountsRequest *req  =[serviceucWalletApiamountsAmountsRequest createRequest];
//    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(serviceucAmountsResponse * _Nonnull message) {
//        NSString *money = [NSString stringWithFormat:@"%d",(message.amount.amount +message.amount.obtain.relatedAmount)];
//        moneyBlock(money);
//    } failed:^(requestErrorCode errorCode) {
//        
//    }];
//}
@end
