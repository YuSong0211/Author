//
// Copyright (c) 2016-present, Facebook, Inc.
// All rights reserved.
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree. An additional grant
// of patent rights can be found in the PATENTS file in the same directory.
//

#import "SRSecurityPolicy.h"
#import "SRPinningSecurityPolicy.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRSecurityPolicy ()

@property (nonatomic, assign, readonly) BOOL certificateChainValidationEnabled;

@end

@implementation SRSecurityPolicy

+ (instancetype)defaultPolicy
{
    return [self new];
}

+ (instancetype)pinnningPolicyWithCertificates:(NSArray *)pinnedCertificates
{
    [NSException raise:NSInvalidArgumentException
                format:@"Using pinned certificates is neither secure nor supported in SocketRocket, "
     "and leads to security issues. Please use a proper, trust chain validated certificate."];
    
    return nil;
}

- (instancetype)initWithCertificateChainValidationEnabled:(BOOL)enabled
{
    self = [super init];
    if (!self) { return self; }
    
    _certificateChainValidationEnabled = enabled;
    
    return self;
}

- (instancetype)init
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    
    return [self initWithCertificateChainValidationEnabled:YES];
    
#pragma clang diagnostic pop
}
- (void)updateSecurityOptionsInStream:(NSStream *)stream {
    NSMutableDictionary *SSLOptions = [[NSMutableDictionary alloc] init];
    [SSLOptions setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsExpiredRoots];
    [SSLOptions setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsExpiredCertificates];
    [SSLOptions setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
    [SSLOptions setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLValidatesCertificateChain];
    CFTypeRef certs[2] = {getIdentityRef(),CFArrayGetValueAtIndex(getSecCertificateRefs(), 0)};
    CFArrayRef certsArray = CFArrayCreate(NULL, (void*)certs,2,NULL);
    [SSLOptions setObject:(NSString *)kCFStreamSocketSecurityLevelNegotiatedSSL forKey:(NSString*)kCFStreamSSLLevel];
    [SSLOptions setObject:(NSString *)kCFStreamSocketSecurityLevelNegotiatedSSL forKey:(NSString*)kCFStreamPropertySocketSecurityLevel];
    [SSLOptions setObject:CFBridgingRelease(certsArray) forKey:(NSString *)kCFStreamSSLCertificates];
    [SSLOptions setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCFStreamSSLIsServer];
    [stream setProperty:SSLOptions forKey:(__bridge id)kCFStreamPropertySSLSettings];
    
}
CFArrayRef getSecCertificateRefs() {
    NSData*certData = [KKTool getHttpsCer];
    CFDataRef certCFData = (__bridge CFDataRef)certData;
    SecCertificateRef cert = NULL;
    cert =SecCertificateCreateWithData(NULL, certCFData);
    SecCertificateRef certArray[1] = { cert };
    CFArrayRef certs =CFArrayCreate(NULL, (void*)certArray,1,NULL);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust =NULL;
    OSStatus status =SecTrustCreateWithCertificates(certs, myPolicy, &myTrust);
    if(myPolicy)
        CFRelease(myPolicy);
    if(myTrust){
        CFRelease(myTrust);
    }
    return status==noErr? certs :NULL;
}

SecIdentityRef getIdentityRef() {
    NSData*PKCS12Data = [KKTool getHttpsP12];
    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
    CFStringRef password =CFSTR("mcjiws");//合成p12文件的时候设置的密码
    SecIdentityRef myIdentity =NULL;
    SecTrustRef myTrust =NULL;
    OSStatus status =noErr;
    status =extractIdentityAndTrust(inPKCS12Data, &myIdentity, &myTrust, password);
    if(myTrust)
        CFRelease(myTrust);
    return status==noErr? myIdentity :NULL;
}

OSStatus extractIdentityAndTrust(CFDataRef inPKCS12Data,SecIdentityRef*outIdentity,SecTrustRef*outTrust,CFStringRef keyPassword) {
    OSStatus securityError =errSecSuccess;
    const void*keys[] =  {kSecImportExportPassphrase };
    const void*values[] = { keyPassword };
    CFDictionaryRef optionsDictionary =NULL;
    optionsDictionary =CFDictionaryCreate(NULL, keys, values, (keyPassword ?1:0),NULL,NULL);
    CFArrayRef items =NULL;
    securityError =SecPKCS12Import(inPKCS12Data,optionsDictionary,&items);
    if(securityError ==noErr) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity =  CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)CFRetain(tempIdentity);
        const void*tempTrust =NULL;
        tempTrust =CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)CFRetain(tempTrust);
    }
    if(optionsDictionary)
        CFRelease(optionsDictionary);
    if(items)
        CFRelease(items);
    return securityError;
}


- (nonnull NSDictionary *)defaultSetting {
    NSDictionary*settings = nil;
    CFTypeRef certs[2] = {getIdentityRef(),CFArrayGetValueAtIndex(getSecCertificateRefs(), 0)};
    CFArrayRef certsArray = CFArrayCreate(NULL, (void*)certs,2,NULL);
    settings = @{(__bridge id)kCFStreamSSLCertificates:CFBridgingRelease(certsArray)};
    return settings;
}


- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust forDomain:(NSString *)domain
{
    // No further evaluation happens in the default policy.
    return YES;
}

@end

NS_ASSUME_NONNULL_END
