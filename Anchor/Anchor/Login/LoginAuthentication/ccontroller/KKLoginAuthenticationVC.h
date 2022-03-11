//
//  KKLoginAuthenticationVC.h
//  KK
//
//  Created by 小草 on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKLoginAuthenticationVC : UIViewController
@property (nonatomic,copy)void (^KKLoginAuthenticationCommintBlock) (void);
@end

NS_ASSUME_NONNULL_END
