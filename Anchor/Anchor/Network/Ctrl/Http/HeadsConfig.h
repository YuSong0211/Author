//
//  HeadsConfig.h
//  KK
//
//  Created by hk on 2021/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeadsConfig : NSObject
-(HeadsConfig*)initWithDataKey:(NSString*)key value:(NSString*)value;
// 获取用户uctoken
+(NSMutableArray *)getReuqestHeadeUcToken;
// 获取用户apitoken
+(NSMutableArray *)getReuqestHeadeApiToken;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *value;

@end

NS_ASSUME_NONNULL_END
