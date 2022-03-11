//
//  NetWorkError.h
//  KK
//
//  Created by hk on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkError : NSObject
        
//根据错误码获取错误请求
+(NetWorkError*)getInstance;


- (NSString*)getCode:(int)errorCode;

@end

NS_ASSUME_NONNULL_END
