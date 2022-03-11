//
//  LXCircle.h
//  LXBezierPath
//
//  Created by zhongzhi on 2017/7/21.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KKGeneralGradientCircle : UIView
typedef NS_ENUM(NSUInteger, GradientCircleType) {
    GradientCircleTypeTopToBottom = 0,//从上到下
    GradientCircleTypeLeftToRight = 1,//从左到右
    GradientCircleTypeLeftToRightCenter = 2//从左到右居中
};
-(instancetype)initWithFrame:(CGRect)frame
                   lineWidth:(CGFloat)lineWidth
                 strokeColor:(UIColor *)strokeColor
                      colors:(NSArray *)colors
                   direction:(GradientCircleType)direction;
@property(nonatomic,assign)CGFloat progress;// 进度值
@property (nonatomic, strong)UIColor *progressTitleColor;// 进度标题颜色
@property (nonatomic, assign)BOOL isHiddenProgressTitle;// 是否隐藏进度标题 默认为NO不隐藏
@end
