//
//  UIView+DragButton.h
//  TargetAct
//
//  Created by PlatoJobs  on 2020/4/15.
//  Copyright © 2020 PlatoJobs . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^moveButtonDirection)(BOOL isLeft);

@interface UIView (DragButton)


/**
 使按钮可拖拽，并添加按钮的点击事件

 @param adhere 按钮是否吸附屏幕边缘
 @param block  按钮点击事件
 */
- (void)pj_addDragMovingAdhere:(BOOL)adhere mainViewHeight:(CGFloat)mainViewHeight clickBlock:(void (^) (UIButton *button))block;

///外部主view的高度
@property (nonatomic,assign) CGFloat frameHeight;
///是否点击
@property (nonatomic,assign) BOOL isClicked;
/// 移动中block
@property (nonatomic,copy) moveButtonDirection moveBlock;

@end

NS_ASSUME_NONNULL_END
