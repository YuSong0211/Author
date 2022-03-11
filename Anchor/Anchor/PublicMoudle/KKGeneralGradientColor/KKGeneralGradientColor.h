//
//  KKGeneralGradientColor.h
//  DownloadData
//
//  Created by ProgramMa on 2021/7/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeLeftToRightCenter = 2//从左到右居中
};
NS_ASSUME_NONNULL_BEGIN

@interface KKGeneralGradientColor : NSObject
/**
 /// view渐变色
 @param colors 颜色集合 @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor]
 @param direction 填充方向
 @param layerView 需要填充的view
 @param isConstraint 是否进行了约束 默认为NO
 */
+(void)KK_createByCAGradientLayer:(NSArray *)colors
                     direction:(GradientType)direction
                     layerView:(UIView *)layerView
                     isConstraint:(BOOL)isConstraint;
/**
 /// view渐变色(图片)
 @param colors 颜色集合@[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor](可以设置多个颜色)
 @param direction 填充方向
 @param imgSize 填充的控件宽高   CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height)
 return     渐变图片
 */
+ (UIImage *)KK_getGradientImageFromColors:(NSArray*)colors
                                 direction:(GradientType)direction
                                imgSize:(CGSize)imgSize;
/**
 /// 圆环渐变色
 @param frame 圆环需要显示的frame
 @param colors 开始与结束颜色集合@[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor](可以设置多个颜色)
 @param layerView 需要将圆环添加到的view
 @param lineWidth 圆环宽度
 @param strokeColor 圆环默认颜色
 @param progress 圆环进度
 @param progressTitleColor 圆环进度标题颜色
 @param isHiddenProgressTitle 是否隐藏进度标题
 @param direction 填充方向
 */
+(void)KK_createByRingCAGradientLayer:(CGRect)frame
                               colors:(NSArray *)colors
                            layerView:(UIView *)layerView
                            lineWidth:(CGFloat)lineWidth
                          strokeColor:(UIColor *)strokeColor
                             progress:(CGFloat)progress
                   progressTitleColor:(UIColor *)progressTitleColor
                isHiddenProgressTitle:(BOOL)isHiddenProgressTitle
                            direction:(GradientType)direction;


/// 移除渐变色layer
/// @param layerView 当前view
+ (void)KK_removeFromSuperlayerView:(UIView *)layerView;

@end

NS_ASSUME_NONNULL_END
