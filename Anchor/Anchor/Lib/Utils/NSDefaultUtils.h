//
//  NSDefaultUtils.h
//  KK
//
//  Created by hk on 2021/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//系统数据组合
extern NSString* const default_ucToken;

@interface NSDefaultUtils : NSObject

//获取数据
+(NSString*)getString :(NSString*)key;

+(void)setString :(NSString*)key :(NSString*)value;

@end

NS_ASSUME_NONNULL_END
