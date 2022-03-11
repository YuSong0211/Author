//
//  KKErrrortext.m
//  mt
//
//  Created by 小鱼 on 2021/9/13.
//

#import "KKErrrortext.h"

@implementation KKErrrortext
+(NSString *)getErrorWitherrorRequestType:(ErrorRequestType)errorRequestType WithErrorCode:(NSUInteger)errorCode{
    if(![[NetWrokStatesCtrl getInstance] networkIsAvailable]){
        return @"网络连接不可用";
    }
    switch (errorRequestType) {
        case KKUpdate:
            return @"检查更新失败";
            break;
        case KKDomainCheck:
            return @"所有服务器域名均不可访问";
            break;
        case KKGetDomain:
            return @"获取最新域名失败";
            break;
        case KKUCLogin:
            return @"UC登录失败...";
            break;
        case KKApiLogin:
            return @"API服务器登录失败...";
            break;
        case KKIndex:
            return @"获取首页信息失败...";
            break;
            
        case KKInternalServerError:
            return @"服务器内部错误";
            break;
        case KKServerDiscern:
            return @"服务器不能识别请求";
            break;
        case KKBadGateway:
            return @"服务器繁忙";
            break;
        case KKServerAvailable:
            return @"服务器不可用";
            break;
        case KKBadGatewaytimeout:
            return @"服务器繁忙超时";
            break;
        case KKHttpNotSupport:
            return @"http协议不支持";
            break;
        case KKApiAssginLogin:
            return @"APIToken失效,重新登录中";
            break;
        case KKUserAccountBlocked:
            return @"该账号已被封!";
            break;
        case KKUserForbiddenWords:
            return @"您已被禁言!";
            break;
            
        default:
            break;
    }
    return @" ";
}

+(BOOL)isTostWithApiStr:(NSString*)apiStr{
    if ([apiStr hasSuffix:@"checkVersion"] || [apiStr hasSuffix:@"guest"] || [apiStr hasSuffix:@"getBaseInfo"] ||[apiStr hasSuffix:@"collect"]||[apiStr hasSuffix:@"like"]||[apiStr hasSuffix:@"like"]) {
        return NO;
    }
    else if([apiStr hasSuffix:@"appIndex"]){
        return NO;
    }
    
    return YES;
}
@end

