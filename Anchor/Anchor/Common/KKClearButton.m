//
//  KKClearButton.m
//  KK
//
//  Created by Gwynne on 2021/7/5.
//

#import "KKClearButton.h"

@implementation KKClearButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 当前btn的大小
    CGRect btnBounds=self.bounds;
    // 扩大按钮的点击范围，改为负值
    btnBounds=CGRectInset(btnBounds, -20, -20);
    // 若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
}
@end
