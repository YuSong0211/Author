//
//  UIView+DragButton.m
//  TargetAct
//
//  Created by PlatoJobs  on 2020/4/15.
//  Copyright © 2020 PlatoJobs . All rights reserved.
//

#import "UIView+DragButton.h"
#import <objc/runtime.h>

@implementation UIView (DragButton)

static char DragAdhere;
static char DragBlock;
static char DragHeight;
static char Dragclicked;
static char DragMove;

- (void)setFrameHeight:(CGFloat)frameHeight {
    objc_setAssociatedObject(self, &DragHeight, [NSString stringWithFormat:@"%f",frameHeight], OBJC_ASSOCIATION_COPY);
}

- (CGFloat)frameHeight {
    return [objc_getAssociatedObject(self, &DragHeight) floatValue];
}

- (void)setIsClicked:(BOOL)isClicked {
    objc_setAssociatedObject(self, &Dragclicked, [NSString stringWithFormat:@"%d",isClicked], OBJC_ASSOCIATION_COPY);
}

- (BOOL)isClicked {
    return [objc_getAssociatedObject(self, &Dragclicked) boolValue];
}

-(void)setMoveBlock:(moveButtonDirection)moveBlock{
    objc_setAssociatedObject(self, &DragMove, moveBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(moveButtonDirection)moveBlock{
    return objc_getAssociatedObject(self, &DragMove);
}

- (void)pj_addDragMovingAdhere:(BOOL)adhere mainViewHeight:(CGFloat)mainViewHeight clickBlock:(void (^) (UIButton *button))block {
    objc_setAssociatedObject(self, &DragAdhere, @(adhere), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &DragBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.frameHeight = mainViewHeight;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
}
- (void)tap:(UITapGestureRecognizer *)tap {
    void (^ block)(UIButton *button) = objc_getAssociatedObject(self, &DragBlock);
    if (block) {
        block((UIButton *)tap.view);
    }
}
- (void)pan:(UIPanGestureRecognizer *)pan {
    if (self.isClicked) {
        return;
    }
    BOOL adhere = [objc_getAssociatedObject(self, &DragAdhere) boolValue];
    if (pan.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.25 animations:^{
            pan.view.center = [pan locationInView:pan.view.superview];
        }];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        pan.view.center = [pan locationInView:pan.view.superview];
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat bottomHeight = [[UIApplication sharedApplication] statusBarFrame].size.height == 20 ? 0 : 34;
        CGFloat x = pan.view.frame.origin.x;
        CGFloat y = pan.view.frame.origin.y;
        CGFloat width = pan.view.frame.size.width;
        CGFloat height = pan.view.frame.size.height;
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = self.frameHeight - bottomHeight;
        /** 以下代码功能：防止按钮超出屏幕 */
        if (x < 0) {
            x = 0;
        } else if (x + width > kWidth) {
            x = kWidth - width;
        }
        if (y < 0) {
            y = 0;
        } else if (y + height > kHeight) {
            y = kHeight - height;
        }
        if (adhere) {
            /** 以下代码功能：使按钮始终吸附屏幕四条边 */
            CGFloat centerX = pan.view.center.x;
            CGFloat centerY = pan.view.center.y;
            if (centerX - centerY > 0 && centerX + centerY < kWidth) {
                y = 30;
                if (x + width / 2 > kWidth / 2.0) {
                    x = kWidth - width - 30;
                }else {
                    x = 30;
                }
            } else if (centerX + centerY > kHeight && centerX - centerY < kWidth - kHeight) {
                y = kHeight - height - 30;
                if (x + width / 2 > kWidth / 2.0) {
                    x = kWidth - width - 30;
                }else {
                    x = 30;
                }
            } else if (centerX - centerY <= 0 && centerX + centerY <= kHeight && centerX < kWidth / 2.0) {
                x = 30;
                if (y > kHeight - height - 30) {
                    y = kHeight - height - 30;
                }
            } else {
                x = kWidth - width - 30;
                if (y > kHeight - height - 30) {
                    y = kHeight - height - 30;
                }
            }
            //最小不能小于30
            if (y < 30) {
                y = 30;
            }
            [UIView animateWithDuration:0.25 animations:^{
                pan.view.frame = CGRectMake(x, y, width, height);
            }];
        } else {
            if (x != pan.view.frame.origin.x || y != pan.view.frame.origin.y) {
                [UIView animateWithDuration:0.25 animations:^{
                    pan.view.frame = CGRectMake(x, y, width, height);
                }];
            }
        }
        //记录X、Y
        [KKConfig share].suspensionButtonX = x;
        [KKConfig share].suspensionButtonY = y;
    }
    BOOL isLeft = YES;
    if (pan.view.frame.origin.x+pan.view.frame.size.width/2>KK_SCREEN_WIDTH/2) {
        isLeft = NO;
    }else{
        isLeft = YES;
    }
    // 当前是否在左边
    if (self.moveBlock) {
        self.moveBlock(isLeft);
    }
}

@end
