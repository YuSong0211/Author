//
//  KKMySelfViewModel.h
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKModelBase.h"
#import "BaseViewModel.h"
#import "KKMySelfModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^requestWalletMoney)(NSString *money);

@interface KKMySelfViewModel : BaseViewModel
            

/**
 //////  请求刷新用户信息
 */
-(void)reqRefehUserInfo;

/**
 //////  当用户数据发生了变化之后调用
 */
@property (nonatomic,strong) RACSubject* signalUpdateUserInfo;

//+ (void)requestWalletMoney:(requestWalletMoney)moneyBlock;


@end

NS_ASSUME_NONNULL_END
