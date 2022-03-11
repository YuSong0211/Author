//
//  KKMyEditUserInfoNikeNameVC.h
//  KK
//
//  Created by ProgramMa on 2021/7/28.
//

#import "KKSecondBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKMyEditUserInfoNikeNameVC : KKSecondBaseVC
@property (nonatomic,copy)NSString *nikeName;// 昵称
@property (nonatomic,copy)void (^editUserInfoNikeNameBlock)(NSString *content);
@end

NS_ASSUME_NONNULL_END
