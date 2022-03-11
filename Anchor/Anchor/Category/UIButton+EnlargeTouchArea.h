//
//  UIButton+EnlargeTouchArea.h
//  voiceNote
//
//  Created by deng on 2021/5/4.
//  Copyright © 2021 deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;//上下左右范围

- (void)setEnlargeEdge:(CGFloat) size;//方形范围

@end
