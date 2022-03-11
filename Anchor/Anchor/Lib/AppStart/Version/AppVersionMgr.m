//
//  AppVersionMgr.m
//  KK
//
//  Created by hk on 2021/8/31.
//


#import "AppVersionMgr.h"
#import "KKAppStartVC.h"
#import "KKAdModel.h"

 

@interface AppVersionMgr()

@property(nonatomic,strong)OnBoolComplete complete;

/**
 缓存消息
 */
@property(nonatomic,strong)serviceapplinkCheckLastedResponse* mResponse;
    
@end

@implementation AppVersionMgr

+ (AppVersionMgr *)shareMgr{
    static dispatch_once_t once;
    static AppVersionMgr *manager;
    dispatch_once(&once, ^{
        manager = [AppVersionMgr new];
    });
    return manager;
}
-(AFURLSessionManager *)manager{
    if (!_manager) {
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        if([richers isUseTLS]){
            [_manager setSecurityPolicy:[self customSecurityPolicy]];
            [self checkCredential:_manager];
        }
    }
    return _manager;
}
- (AFSecurityPolicy*)customSecurityPolicy {
AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
NSData *certData = [KKTool getHttpsCer];// [NSData dataWithContentsOfFile:cerPath];
    NSString* o = [[NSString alloc] initWithData:certData encoding:NSUTF8StringEncoding];
NSSet   *dataSet = [NSSet setWithArray:@[certData]];
[securityPolicy setAllowInvalidCertificates:NO];
[securityPolicy setPinnedCertificates:dataSet];
[securityPolicy setValidatesDomainName:YES];
    
    
return securityPolicy;
}


//校验证书
 - (void)checkCredential:(AFURLSessionManager *)manager
 {
 
     [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
    
}];
__weak typeof(manager)weakManager = manager;
[manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
   NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
   __autoreleasing NSURLCredential *credential =nil;
   NSLog(@"authenticationMethod=%@",challenge.protectionSpace.authenticationMethod);
   //判断是核验客户端证书还是服务器证书
   if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
       // 基于客户端的安全策略来决定是否信任该服务器，不信任的话，也就没必要响应挑战
//       [weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]
       if(YES) {
           // 创建挑战证书（注：挑战方式为UseCredential和PerformDefaultHandling都需要新建挑战证书）
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
           disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
       }
   } else {
       // client authentication
       SecIdentityRef identity = NULL;
       SecTrustRef trust = NULL;
       
       NSData *PKCS12Data =  [KKTool getHttpsP12];//[NSData dataWithContentsOfFile:p12];
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
- (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
OSStatus securityError = errSecSuccess;
//client certificate password
NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"mcjiws"
                                                            forKey:(__bridge id)kSecImportExportPassphrase];

CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);


    
    
if(securityError == 0) {
   CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);

    const void* chain = NULL;
    
    chain  = CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemCertChain);
    CFArrayRef array = (CFArrayRef*)chain;
    
    
   const void*tempIdentity =NULL;
   tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
   *outIdentity = (SecIdentityRef)tempIdentity;
   const void*tempTrust =NULL;
   tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
   *outTrust = (SecTrustRef)tempTrust;
    int c =2;
} else {
   NSLog(@"Failedwith error code %d",(int)securityError);
   return NO;
}
return YES;
 }

/**
 启动版本更新逻辑
 */


-(void)resginStart{
    serviceapplinkLinkPassportApicheckLastedCheckLastedRequest *request = [serviceapplinkLinkPassportApicheckLastedCheckLastedRequest createRequest];
    int c = [richers getIosPackageType];
    c+=2;
    request.request.clientType = c;
    request.request.version = KKappVersionCode;
    request.request.grayscale = [KKUserInfo share].grayscale;
    //serviceapplinkCheckVersionResponse
     [[NetWorkMgr createMgrWithMessage:request] sendRequest:^(serviceapplinkCheckLastedResponse*   message) {
        [KKLoadingView hidden];
        self.mResponse = message;
        self.appADArray = message.adsArray;
        [self getAppNoticeListWithVideoAvList:message];
        [self decodeUrlList];
        [KKPubTagVCModel shareToolGetManager].ossProvider = message.config.ossProvider;
        if (message.hasAppVersion) {
            self.isNewVersion = YES;
            [self decodeResponse];
        }else{
            self.isNewVersion = NO;
            self.complete(YES);
        }
        
    } failed:^(requestErrorCode errorCode) {

        WS
        NSString *showtext = [KKErrrortext getErrorWitherrorRequestType:KKUpdate WithErrorCode:errorCode];
        [KKLoadingView hidden];
        KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"重试" buttonEnable:YES];
        KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:showtext] setViewEnable:NO];
        [controller.itemConfigArray  addObject:item];
        [KKAltView dismiss];
        [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
            SS
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                [self resginStart];
            });
        }];
        

        
    }];
}

-(void)startCheck{
    [KKLoadingView hidden];
    [richers sDomainCheck:^(bool ok) {
        if (ok) {
            [AppTimeSysMgr initGcdReloadTime];
            [self resginStart];
            return;
        }
        //弹窗提示
        [KKTool popNoNetworkConnection:^{
            [KKLoadingView showView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self startCheck];
            });
        }];
    }];
}

-(void)start:(OnBoolComplete)complete{
    self.complete = complete;
    [KKLoadingView showView];
    //这个才是真正的检测
    [self startCheck];
}
///获取app公告列表 获取视频广告
-(void)getAppNoticeListWithVideoAvList:(serviceapplinkCheckLastedResponse* )message{
    [KKAdModel share].noticesArray = message.noticesArray;
    if (message.feedAdsArray.count>0) {
        for (serviceapplinkAdvertisement *adVert in message.feedAdsArray) {
            if (adVert.adPlacement == 1) {
                [[KKAdModel share].advertisementArray addObject:adVert];
            }
        }
    }

}

//解析数据
-(void)decodeResponse{
    if(self.mResponse.hasAppVersion){
        self.isNeedUpdate = YES;
        if (self.mResponse.appVersion.mandatoryUpdate) {
            //如果是强制更新，提示dialog，
            KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"立即更新" buttonEnable:YES];
            KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:[NSString stringWithFormat:@"检测到新版本更新(%@)",self.mResponse.appVersion.version] content:self.mResponse.appVersion.content] setViewEnable:NO];
            [controller.itemConfigArray  addObject:item];
            [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.mResponse.appVersion.downloadURL]];
                [self decodeResponse];
            }];
            return;
        }
        else{
            //非强制更新，提示：我再想想，立即更新，如果是我再想想。直接回调
            KKAltItemConfig* cancle = [KKAltItemConfig initWithItemConfig:@"我再想想" buttonEnable:YES];
            KKAltItemConfig* ok = [KKAltItemConfig initWithItemConfig:@"立即更新" buttonEnable:YES];
            KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:[NSString stringWithFormat:@"检测到新版本更新(%@)",self.mResponse.appVersion.version] content:self.mResponse.appVersion.content] setViewEnable:NO];
            [controller.itemConfigArray  addObject:cancle];
            [controller.itemConfigArray  addObject:ok];
            [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
                if(clickIndex == KKAltItemStateCancle){
                    self.complete(YES);
                }
                else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.mResponse.appVersion.downloadURL]];
                    self.complete(YES);
//                    [self decodeResponse];
                }
            }];
            
        }
        return;
    }
    self.isNeedUpdate = NO;
    self.complete(YES);
}


//解析域名列表等。
-(void)decodeUrlList{
    //刷新域名列表
    NSMutableDictionary* dic = self.mResponse.businessDomains;
    //    [AppLinkDomainMgr shareMgr].appLinkDomainItem.domainList.ucList =((serviceapplinkDomains*)[dic objectForKey:@"uc"]).domainArray;
    if (self.mResponse.entryDomains.domainArray.count) {
        [richers updateDomainList:self.mResponse.entryDomains.domainArray];
        [richers refreshDomainList:Ocdomain_im array:self.mResponse.entryDomains.domainArray];
    }
    if ([dic objectForKey:@"download"]){
        [richers refreshDomainList:Ocdomain_download array:((serviceapplinkDomains*)[dic objectForKey:@"download"]).domainArray];
        NSString *vlink = [richers getCanUseUrl:Ocdomain_download];
        
    }
    if ([dic objectForKey:@"chat"]){
//        [richers refreshDomainList:Ocdomain_im array:((serviceapplinkDomains*)[dic objectForKey:@"chat"]).domainArray];
    }
    
    NSDictionary *domainDic = self.mResponse.dynamicDomains;
    if ([domainDic objectForKey:@"appvGrayscaleLink"]){
        [richers refreshDomainList:Ocdomain_appvgrayscale array:((serviceapplinkDomains*)[domainDic objectForKey:@"appvGrayscaleLink"]).domainArray];
    }
    if ([domainDic objectForKey:@"noticeResource"]){
        [richers refreshDomainList:Ocdomain_notice array:((serviceapplinkDomains*)[domainDic objectForKey:@"noticeResource"]).domainArray];
        NSString *upstr=   [richers getCanUseUrl:Ocdomain_update];
        NSLog(@"%@",upstr);
    }
    
    if ([domainDic objectForKey:@"advertisementResource"]){
        [richers refreshDomainList:Ocdomain_advertisement array:((serviceapplinkDomains*)[domainDic objectForKey:@"advertisementResource"]).domainArray];
    }
    if ([domainDic objectForKey:@"ossWriteEndpoints"]){
        [richers refreshDomainList:Ocdomain_oss array:((serviceapplinkDomains*)[domainDic objectForKey:@"ossWriteEndpoints"]).domainArray];
        NSString *upstr=   [richers getCanUseUrl:Ocdomain_oss];
        NSLog(@"%@",upstr);
    }
    //hybirdVer hybird-ver
    if([dic objectForKey:@"hybirdVer"]){
        NSMutableArray* arrayList = ((serviceapplinkDomains*)[dic objectForKey:@"hybirdVer"]).domainArray;
        if(arrayList.count>0){
            NSString* hyBirdVersion = arrayList[0];
            NSString* oldBirdVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"hybirdVer"];
            if(![hyBirdVersion isEqualToString:oldBirdVersion]){
                [KKAppStartVC removeWebCache];
                [[NSUserDefaults standardUserDefaults] setObject: hyBirdVersion forKey:@"hybirdVer"];
            }
        }
    }
    
   
    
}
+(void)checkHybridgeVersion:(NSString *)hyBirdVersion{
    NSString* oldBirdVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"hybirdVer"];
    if(![hyBirdVersion isEqualToString:oldBirdVersion]){
        [KKAppStartVC removeWebCache];
        [[NSUserDefaults standardUserDefaults] setObject: hyBirdVersion forKey:@"hybirdVer"];
    }
    
}


/// 获取app版本号，或者更新的版本号
/// @param newVersion true 为更新版本号，false为当前版本号
-(NSString*)getVersion:(BOOL)newVersion{
    if (!newVersion) {
        return KKappVersionCode;
    }
    if (self.isNeedUpdate) {
        return self.mResponse.appVersion.version;
    }
    return KKappVersionCode;
}


//更新重试
-(void)retry{
    if(self.isNeedUpdate){
        [self decodeResponse];
    }else{
        [SVProgressHUD showMessage:@"已是最新版本"];
    }
}


@end
