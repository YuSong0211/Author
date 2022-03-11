//
//  KKBase64Util.h
//  mt
//
//  Created by 小草 on 2021/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKBase64Util : NSObject

/**
* Base64编码
*/
+(NSString *)base64Encode:(NSString *)data;

/**
* Base64解码
*/
+(NSString *)base64Dencode:(NSString *)data;


+ (NSData*)base64Decode:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
