//
//  KKGeneralGradientColor.m
//  DownloadData
//
//  Created by ProgramMa on 2021/7/19.
//

#import "KKGeneralGradientColor.h"
#import "KKGeneralGradientCircle.h"
@interface KKGeneralGradientColor()
@property (nonatomic,strong)CAGradientLayer *subLayer;
@end
@implementation KKGeneralGradientColor
+(void)KK_createByCAGradientLayer:(NSArray *)colors
                     direction:(GradientType)direction
                     layerView:(UIView *)layerView
                     isConstraint:(BOOL)isConstraint{
    if (isConstraint) {
        [layerView.superview setNeedsLayout];
        [layerView.superview layoutIfNeeded];
    }
    CAGradientLayer *layer = [CAGradientLayer new];
    //存放渐变的颜色的数组
    layer.colors = colors;
    //起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
    switch (direction) {
        case GradientTypeTopToBottom:
            layer.startPoint = CGPointMake(0.0, 0.0);
            layer.endPoint = CGPointMake(0.0, 1.0);
            break;
        case GradientTypeLeftToRight:
            layer.startPoint = CGPointMake(0.0, 0.0);
            layer.endPoint = CGPointMake(0.5, 0.0);
            break;
        case GradientTypeLeftToRightCenter:
            layer.startPoint = CGPointMake(0.0, 0.0);
            layer.endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    layer.frame = CGRectMake(0, 0, layerView.frame.size.width, layerView.frame.size.height);
    [layerView.layer insertSublayer:layer atIndex:0];
    
}
+ (UIImage *)KK_getGradientImageFromColors:(NSArray *)colors
                                 direction:(GradientType)direction
                                imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(0.0, 0.0);
    switch (direction) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}
+(void)KK_createByRingCAGradientLayer:(CGRect)frame
                               colors:(NSArray *)colors
                            layerView:(UIView *)layerView
                            lineWidth:(CGFloat)lineWidth
                          strokeColor:(UIColor *)strokeColor
                             progress:(CGFloat)progress
                   progressTitleColor:(UIColor *)progressTitleColor
                isHiddenProgressTitle:(BOOL)isHiddenProgressTitle
                            direction:(GradientType)direction
{
    NSInteger typeIndex = 0;
    switch (direction) {
        case GradientTypeTopToBottom:
            typeIndex = 0;
            break;
        case GradientTypeLeftToRight:
            typeIndex = 1;
            break;
        case GradientTypeLeftToRightCenter:
            typeIndex = 2;
            break;
        default:
            break;
    }
    KKGeneralGradientCircle *pathView =[[KKGeneralGradientCircle alloc] initWithFrame:frame lineWidth:lineWidth strokeColor:strokeColor colors:colors direction:typeIndex];
    pathView.backgroundColor =[UIColor clearColor];
    pathView.progress = progress;
    pathView.progressTitleColor = progressTitleColor;
    pathView.isHiddenProgressTitle = isHiddenProgressTitle;
    [layerView addSubview:pathView];
}

+ (void)KK_removeFromSuperlayerView:(UIView *)layerView {
    NSArray<CALayer *> *subLayers = layerView.layer.sublayers;
    NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[CAGradientLayer class]];
    }]];
    [removedLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
}
@end
