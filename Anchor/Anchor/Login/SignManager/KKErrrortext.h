//
//  KKErrrortext.h
//  mt
//
//  Created by 小鱼 on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    KKUpdate = 1,//
    KKDomainCheck = 2,//
    KKGetDomain,
    KKUCLogin ,//
    KKApiAssginLogin=403,
    KKUserAccountBlocked,///账户被封
    KKUserForbiddenWords = 25018,///账户被禁言 
    KKApiLogin,
    KKIndex,
    KKInternalServerError = 500, //服务器内部错误
    KKServerDiscern = 501,    //服务器不能识别请求
    KKBadGateway = 502,       //服务器繁忙
    KKServerAvailable = 503, //服务器不可用
    KKBadGatewaytimeout = 504, //服务器繁忙超时
    KKHttpNotSupport = 505,    //http协议不支持
} ErrorRequestType;
@interface KKErrrortext : NSObject
+(NSString *)getErrorWitherrorRequestType:(ErrorRequestType)errorRequestType  WithErrorCode:(NSUInteger)errorCode;
+(BOOL)isTostWithApiStr:(NSString*)apiStr;
@end

NS_ASSUME_NONNULL_END
