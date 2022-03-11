//
//  UIFont+CoustomFont.m
//  KK
//
//  Created by 小草 on 2021/6/23.
//

#import "UIFont+CoustomFont.h"

@implementation UIFont (CoustomFont)

+(UIFont *)regularWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

+(UIFont *)semiboldWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

+(UIFont *)mediumWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

@end
