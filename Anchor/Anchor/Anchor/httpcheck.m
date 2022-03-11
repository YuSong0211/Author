//
//  httpcheck.m
//  lmtest
//
//  Created by hk on 2021/11/8.
//

#import "httpcheck.h"
#import "richers.h"

@interface httpcheck()<NSURLSessionDelegate>
@end

@implementation httpcheck
static BOOL ok = NO;
-(BOOL)check:(NSString*)url{
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    NSString* srcUrl = url;
//    NSURL *bsUrl = [NSURL URLWithString:srcUrl];
//    NSError* error;
//    NSURLRequest *request = [NSURLRequest requestWithURL:bsUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3.0f];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//
//    NSURLSessionDataTask* resp = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if(error == nil){
//            NSLog(@"success!===>ok!");
//            ok = YES;
//        }
//        else{
//            ok = NO;
//            NSLog(@"fail=====>%@",error);
//        }
//        dispatch_semaphore_signal(semaphore);
//    }];
//
//    [resp resume];
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"%@",resp.error);
    return YES;
}


- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable mc))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate])//Client
    {
        SecIdentityRef identity = NULL;
        SecTrustRef trust = NULL;
        NSData *PKCS12Data = [KKTool getHttpsP12];
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        if ([self extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
        {
            SecCertificateRef certificate = NULL;
            SecIdentityCopyCertificate(identity, &certificate);
            const void*certs[] = {certificate};
            CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
            NSURLCredential* credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
            disposition =NSURLSessionAuthChallengeUseCredential;
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
        
    }
    else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])//Server
    {
        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
        SecCertificateRef serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
        NSData *serverData = (__bridge_transfer NSData*)SecCertificateCopyData(serverCertificate);
        NSData *localData = [KKTool getHttpsCer]; //[NSData dataWithContentsOfFile:[[NSBundle mainBundle]
        if (true)
        {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:serverTrust];
            [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
        else
        {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
        }
    }
    else
    {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
    }
}

- (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
OSStatus securityError = errSecSuccess;
//client certificate password
NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"mcjiws"
                                                           forKey:(__bridge id)kSecImportExportPassphrase];

CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);

if(securityError == 0) {
  CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items,0);
  const void*tempIdentity =NULL;
  tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
  *outIdentity = (SecIdentityRef)tempIdentity;
  const void*tempTrust =NULL;
  tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
  *outTrust = (SecTrustRef)tempTrust;
} else {

  return NO;
}
return YES;
}
@end
