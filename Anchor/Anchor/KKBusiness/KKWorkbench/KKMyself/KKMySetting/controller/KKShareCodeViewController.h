//
//  KKShareCodeViewController.h
//  mt
//
//  Created by ProgramMa on 2021/10/19.
//

#import "KKSecondBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKShareCodeViewController : KKSecondBaseVC
@property (nonatomic,copy)NSString *shareCode;// 昵称
@property (nonatomic,copy)void (^editUserInfoNikeNameBlock)(NSString *content);
@end

NS_ASSUME_NONNULL_END
