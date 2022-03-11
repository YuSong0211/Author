//
//  KKSecurityPolicy.h
//  mt
//
//  Created by 小鱼 on 2021/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//错误信息回调
typedef void (^requestFailed)(NSString* requestID,NSError * _Nullable error,NSString *httpCode,NSString *xerrCode);

//成功回调
typedef void (^requestSuccess)(NSString* requestID,id message,NSString *httpCode,NSString *xerrCode);
@interface KKSecurityPolicy : NSObject
+(void)sendRequestWithRequest:(NSDictionary *)requestDic WithNetCore:(requestSuccess)success
                       failed:(requestFailed)fail;
+ (AFSecurityPolicy*)customSecurityPolicy;
//校验证书
+ (void)checkCredential:(AFURLSessionManager *)manager;
+ (NSData *)base64DecodingStringWithInputText:(NSString *)inputText;
@end

NS_ASSUME_NONNULL_END
