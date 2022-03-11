//
//  UIImage+Extension.h
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

- (UIImage *)drawRoundedRectImage:(CGFloat)cornerRadius width:(CGFloat)width height:(CGFloat)height;

- (UIImage *)drawCircleImage;

-(NSData *)compressWithMaxLength:(NSUInteger)maxLength;


/// 直播打赏等级使用
/// @param level 等级数量
+(UIImage *)genderImageWithImageLevel:(NSInteger)level;

@end
