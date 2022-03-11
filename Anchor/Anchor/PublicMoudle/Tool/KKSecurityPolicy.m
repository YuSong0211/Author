//
//  KKSecurityPolicy.m
//  mt
//
//  Created by 小鱼 on 2021/11/3.
//

#import "KKSecurityPolicy.h"
#import "KKBase64Util.h"
#import "AppVersionMgr.h"
@implementation KKSecurityPolicy
+(void)sendRequestWithRequest:(NSDictionary *)requestDic WithNetCore:(requestSuccess)success
                       failed:(requestFailed)fail{
    NSString *requesID =   requestDic[@"objRequestId"];
    NSString *url =  requestDic[@"objUrl"];
    NSString *body = requestDic[@"objBody"];
    NSString *objApi = requestDic[@"objApi"];
  
    OC_DomainType domainType = Ocdomain_uc;
    if ([objApi hasPrefix:@"appvapi"]) {
        domainType = Ocdomain_api;
    }
   NSString *doMainUrl = [richers getRequestUrl:domainType apiName:objApi];
   NSCharacterSet *encode_set= [NSCharacterSet URLUserAllowedCharacterSet];
   NSString * encodeStr = [@"application/x-protobuf" stringByAddingPercentEncodingWithAllowedCharacters:encode_set];

    url =  [NSString stringWithFormat:@"%@?xx-content-type=%@",doMainUrl,encodeStr];
    // base64 解密
    NSData *data =  [self base64DecodingStringWithInputText:body];
    AFURLSessionManager *manager = [AppVersionMgr shareMgr].manager;
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    [self checkCredential:manager];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *temp;
    if ([KKUserInfo share].timestampMills) {
        long long nowTime = [[KKTool getNowTimeTimestamp3] integerValue];
        long long times = [KKUserInfo share].timestampMills +   nowTime;
        temp = [NSString stringWithFormat:@"%lld",times];
    }
    else{
        temp =  [KKTool getNowTimeTimestamp3];
    }
    NSData *bodyData = [richers encodeBody:objApi body:data type:domainType timeSpan:temp];
    [request setHTTPBody:bodyData];
    
    request.timeoutInterval = netWork_timeoutInterval;
    NSURLSessionDataTask* dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  responseObject, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if (resp.statusCode == 200) {
            NSString *errorCode = @"0";
            if ([resp.allHeaderFields.allKeys containsObject:@"X-Err"]) {
                errorCode = resp.allHeaderFields[@"X-Err"];
                fail(requesID,error,[NSString stringWithFormat:@"%ld",resp.statusCode],errorCode);
            }
            else{
                NSData *resuData = [richers decodeBody:responseObject type:Ocdomain_appvgrayscale];
                NSData *base64data = [resuData base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                success(requesID,[[NSString alloc] initWithData:base64data encoding:NSUTF8StringEncoding],[NSString stringWithFormat:@"%ld",resp.statusCode],@"0");
            }
        }
        else{
            
            fail(requesID,error,[NSString stringWithFormat:@"%ld",resp.statusCode],@"-1");
        }
    }];
    [dataTask resume];
}
+ (AFSecurityPolicy*)customSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    NSData *certData = [KKTool getHttpsCer];
    NSSet   *dataSet = [NSSet setWithArray:@[certData]];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setPinnedCertificates:dataSet];
    [securityPolicy setValidatesDomainName:YES];
    
    return securityPolicy;
}
//校验证书
+ (void)checkCredential:(AFURLSessionManager *)manager
{
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
    }];
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential =nil;
        NSLog(@"authenticationMethod=%@",challenge.protectionSpace.authenticationMethod);
        //判断是核验客户端证书还是服务器证书
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            NSLog(@"serverTrust=%@",challenge.protectionSpace.serverTrust);
            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            // 确定挑战的方式
            if (credential) {
                //证书挑战  设计policy,none，则跑到这里
                disposition = NSURLSessionAuthChallengeUseCredential;
            } else {
                disposition = NSURLSessionAuthChallengePerformDefaultHandling;
            }
        } else {
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSData *PKCS12Data =[KKTool getHttpsP12];
            
            if ([self extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
            {
                SecCertificateRef certificate = NULL;
                SecIdentityCopyCertificate(identity, &certificate);
                const void*certs[] = {certificate};
                CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                disposition =NSURLSessionAuthChallengeUseCredential;
            }
        }
        *_credential = credential;
        return disposition;
    }];
}

//读取p12文件中的密码
+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"mcjiws"
                                                                  forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

+ (NSData *)base64DecodingStringWithInputText:(NSString *)inputText {
    NSInteger remainder = inputText.length % 4;
    NSMutableString *tmpMstring = [[NSMutableString alloc] initWithString:inputText];
    if (remainder > 0) {
        for (; remainder < 4; remainder++) {
            [tmpMstring appendString:@"="];
        }
    }
    NSData *data = [[NSData alloc]initWithBase64EncodedString:tmpMstring options:0];
    data = [KKBase64Util base64Decode:tmpMstring];
    return data;
}

@end

