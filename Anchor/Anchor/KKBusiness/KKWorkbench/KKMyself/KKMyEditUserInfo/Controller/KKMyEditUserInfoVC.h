//
//  KKMyEditUserInfoVC.h
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import "KKSecondBaseVC.h"
#import "appvUser.pbobjc.h"// 用户信息类
#import "appvBasic.pbobjc.h"// 用户信息内容类
NS_ASSUME_NONNULL_BEGIN

@interface KKMyEditUserInfoVC : KKSecondBaseVC
// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;
@property (nonatomic,copy)void (^editUpdatePhoneBlock)(NSString *phone);// 修改手机号
@end

NS_ASSUME_NONNULL_END
