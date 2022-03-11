//
//  KKSecondBaseVC.h
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "SGPagingView.h"

NS_ASSUME_NONNULL_BEGIN

//***控制器基类****

@interface KKSecondBaseVC : UIViewController

///返回按钮点击事件
- (void)backAction;

///是否禁用返回手势
/// @param isProhib YES 禁用  NO不禁
- (void)isProhibitPopGestureRecognizer:(BOOL)isProhib;

///是否显示返回按钮
@property (nonatomic,assign) BOOL isShowLeftBack;

/// 是否禁用全屏手势
/// @param isProhibit YES 禁用  NO不禁用
- (void)isProhibitFullScreenPopGestureRecognizer:(BOOL)isProhibit;

///添加文字右按钮
- (void)addRightButtonItemWith:(NSString *)title;

/// 隐藏右按钮
-(void)hiddenRightButton;

///右按钮点击事件
- (void)rightButtonItemAction;

///是否展示键盘的Toolbar
- (void)keyboardEnableAutoToolbar:(BOOL)enableAutoToolbar;

@end

NS_ASSUME_NONNULL_END
