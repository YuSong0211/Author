//
//  KKNavVC.h
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKNavVC : UINavigationController
///是否禁用全屏手势  默认NO
@property (nonatomic,assign) BOOL isForbiddenFullPopGestureRecognizer;
@end

NS_ASSUME_NONNULL_END
