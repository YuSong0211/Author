//
//  UIImage+Extension.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "UIImage+Extension.h"
@implementation UIImage (Extension)
- (UIImage *)drawRoundedRectImage:(CGFloat)cornerRadius width:(CGFloat)width height:(CGFloat)height {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 1.0f);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:cornerRadius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:CGRectMake(0, 0, width, height)];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

- (UIImage *)drawCircleImage {
    CGFloat side = MIN(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), NO, 1.0f);
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, side, side)].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    CGFloat originX = -(self.size.width - side) / 2.f;
    CGFloat originY = -(self.size.height - side) / 2.f;
    [self drawInRect:CGRectMake(originX, originY, self.size.width, self.size.height)];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}



-(NSData *)compressWithMaxLength:(NSUInteger)maxLength{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    maxLength = [data length]/2;
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //    NSLog(@"1Compression = %.1f", compression);
        // NSLog(@"1In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //  NSLog(@"1After compressing quality, image size = %ld KB", data.length / 1024);
    UIImage *resultImage = [UIImage imageWithData:data];
    
    if (data.length < maxLength) return UIImageJPEGRepresentation(resultImage, compression);
  
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //   NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    // NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}



+(UIImage *)genderImageWithImageLevel:(NSInteger)level{
    
    NSString * imageName = @"KK_live_stage_one";
    
    if (level >6 && level<13) {
        imageName = @"KK_live_stage_two";
    }else if (level >12 && level <19){
        imageName = @"KK_live_stage_there";
    }else if (level >18 && level <25){
        imageName = @"KK_live_stage_four";
    }else if (level >24){
        imageName = @"KK_live_stage_five";
    }
    
    
    
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 15)];
    BGView.backgroundColor = [UIColor clearColor];
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 34, 15)];
    topImageView.backgroundColor = [UIColor clearColor];
    topImageView.image = [UIImage imageNamed:imageName];
    [BGView addSubview:topImageView];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, 12, 8)];
    textLabel.numberOfLines = 0;
    textLabel.text = [NSString stringWithFormat:@"%ld",level];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:8];
    [BGView addSubview:textLabel];
    
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(BGView.frame.size, NO, [UIScreen mainScreen].scale);
    [BGView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

