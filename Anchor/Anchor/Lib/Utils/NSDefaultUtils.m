//
//  NSDefaultUtils.m
//  KK
//
//  Created by hk on 2021/6/23.
//

#import "NSDefaultUtils.h"

//uctoken 系统缓存
NSString * const default_ucToken = @"KKkj_x_uctoken";

@implementation NSDefaultUtils

//获取数据
+ (NSString *)getString:(NSString *)key{
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    NSString *val = [defult objectForKey:key];
    return val==NULL?@"":val;
}

//添加数据
+ (void)setString:(NSString *)key :(NSString *)value{
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setObject:value forKey:key];
    [defult synchronize];
}

@end
