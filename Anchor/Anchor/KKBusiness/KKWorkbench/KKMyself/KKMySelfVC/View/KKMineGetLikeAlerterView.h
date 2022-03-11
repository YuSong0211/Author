//
//  KKMineGetLikeAlerterView.h
//  KK
//
//  Created by ProgramMa on 2021/7/29.
//

#import <UIKit/UIKit.h>
#import "appvUser.pbobjc.h"// 用户信息类
#import "appvBasic.pbobjc.h"// 用户信息内容类
NS_ASSUME_NONNULL_BEGIN

@interface KKMineGetLikeAlerterView : UIView
- (void)showInView:(appvapiUserInfoBasic *)basic;
@end

NS_ASSUME_NONNULL_END
