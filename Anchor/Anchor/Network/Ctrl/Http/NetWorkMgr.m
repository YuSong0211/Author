//
//  NetWorkMgr.m
//  KK
//
//  Created by hk on 2021/8/3.
//

#import "NetWorkMgr.h"
#import "NetWorkError.h"
#import "KKHub.h"
#import "SignController.h"
#import "AppLinkDomainMgr.h"
#import "AppTimeSysMgr.h"
#import "AppDelegate.h"
#import "AppVersionMgr.h"

@interface NetWorkMgr()
        
//需要发送的消息
@property (strong,nonatomic)  id msg;

//存放的头
@property(strong,nonatomic) NSMutableArray<HeadItem*>* headList;

//成功回调
@property (copy,nonatomic)  onRequestSuccess success;

//失败回调
@property (copy,nonatomic)  onRequestFail fail;

@property (assign,nonatomic) BOOL useNetCore;

@property (nonatomic, strong)SignController *signCtrl;

@end

@implementation NetWorkMgr


//创建空对象
+ (NetWorkMgr *)createMgr{
    NetWorkMgr* netwoek = [[NetWorkMgr alloc] init];
    netwoek.headList = [[NSMutableArray alloc] init];
    return netwoek;
}


//创建api 请求接口对象。
+ (NetWorkMgr *)createMgrWithMessage:(id)message{
    NetWorkMgr* network = [NetWorkMgr createMgr];
    [network setMessage:message];
    network.useToken = YES;
    return network;
}

//创建uc消息对象
+ (NetWorkMgr *)ucCreateMgrWithMessage:(id)message useToken:(BOOL)useToken {
    NetWorkMgr* network = [NetWorkMgr createMgr];
    [network setMessage:message];
    network.useToken =useToken;
    return network;
}

- (void)setMessage:(id)message{
    self.msg = message;
}

//使用netcore 接口获取信息
- (void)sendRequestWithNetCore:(onRequestSuccess)succ failed:(onRequestFail)failed{
    self.success = succ;
    self.fail = failed;
    self.useNetCore = YES;
    [self sendRequest];
}

//发送请求
- (void)sendRequest:(onRequestSuccess)succ failed:(onRequestFail)failed{
    self.success = succ;
    self.fail = failed;
    [self sendRequest];
}

+(void)cancelRequestWithUrlStr:(NSString *)urlStr{
    if ([[KKUserInfo share].taskDict.allKeys containsObject:urlStr]) {
        NSURLSessionDataTask* dataTask =[KKUserInfo share].taskDict[urlStr];
        [dataTask cancel];
    }
}

//真正的发送接口
- (void)sendRequest {
    GProtoBufferMessage* sendParam = self.msg;
    OC_DomainType  domainType = [richers getDomainType:sendParam.packageName];
    NSString *url = [richers getRequestUrl:domainType apiName:sendParam.apiName];
    NSLog(@"请求URL地址 = %@/%@",url,sendParam.apiName);
    NSLog(@"请求参数 = %@",sendParam.pb_request);
    AFURLSessionManager *manager = [AppVersionMgr shareMgr].manager;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *temp;
    if ([KKUserInfo share].timestampMills) {
        long long nowTime = [[KKTool getNowTimeTimestamp3] integerValue];
        long long times = [KKUserInfo share].timestampMills +  nowTime;
        temp = [NSString stringWithFormat:@"%lld",times];
    }else {
        temp =  [KKTool getNowTimeTimestamp3];
    }
    NSData *bodyData = [richers encodeBody:sendParam.apiName body:[sendParam.pb_request data] type:domainType timeSpan:temp] ;
    [request setHTTPBody:bodyData];
    request.timeoutInterval = netWork_timeoutInterval;
    //设置请求头
    if (sendParam.requestHeads!=nil) {
        for(NSString *compKey in sendParam.requestHeads) {   // 正确的字典遍历方式
            NSString *comp = [sendParam.requestHeads objectForKey:compKey];
            [request setValue:comp forHTTPHeaderField:compKey];
        }
    }
    [request setValue:[KKUserInfo share].deviceIPAdress forHTTPHeaderField:@"x-client-ip"];
    NSURLSessionDataTask* dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  responseObject, NSError * _Nullable error) {
        NSLog(@"NSURLResponse = %@",response);
        BOOL isOk = [self checkRespose:(NSHTTPURLResponse*)response];
        //解析数据
        if(isOk){
            if(responseObject==nil){
                [self setError:ReceiveError];
                return;
            }
            [[KKUserInfo share].taskDict removeObjectForKey:sendParam.apiName];
            responseObject = [richers decodeBody:responseObject type:domainType];
            sendParam.pb_respose = [sendParam.pb_respose initWithData:responseObject error:nil];
            NSHTTPURLResponse* resp = (NSHTTPURLResponse*)response;
            sendParam.resposeHeads = [[NSMutableDictionary alloc] init];
            for (NSString* key in resp.allHeaderFields) {
                [sendParam.resposeHeads setValue:resp.allHeaderFields[key] forKey:key];
            }
            NSLog(@"成功响应返回值 = %@",sendParam.pb_respose);
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.success(sendParam.pb_respose);
                });
            }else {
                self.success(sendParam.pb_respose);
            }
            if (![AppTimeSysMgr shareMgr].isInit) {
                NSString* serverDate = resp.allHeaderFields[@"Date"];
                [[AppTimeSysMgr shareMgr] initSysTime:serverDate];
            }
        }
    }];
    [[KKUserInfo share].taskDict addEntriesFromDictionary:@{sendParam.apiName:dataTask}];
    [dataTask resume];
}

- (AFSecurityPolicy *)customSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    NSData *certData = [KKTool getHttpsCer];
    NSSet *dataSet = [NSSet setWithArray:@[certData]];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setPinnedCertificates:dataSet];
    [securityPolicy setValidatesDomainName:YES];
    return securityPolicy;
}


//检测返回消息是否满足需求
-(BOOL)checkRespose:(NSHTTPURLResponse*)respose{
    if (!respose) {
        [self setError:999];
        self.fail(999);
        return NO;
    }
    NSString* proxyErr = respose.allHeaderFields[@"X-Proxy-Err"];
    if(proxyErr!=NULL && proxyErr.length>0){
        int code =[proxyErr intValue];
        if(code>0){
            [self setApiError:code];
            return NO;
        }
    }
    NSString* proxyErrs = respose.allHeaderFields[@"X-Err"];
    if(proxyErrs!=NULL && proxyErrs.length>0){
        int code =[proxyErrs intValue];
        [self setApiError:code];
        return NO;
    }
    if(respose.statusCode!= 200 && respose.statusCode>200){
        [self setError:(requestErrorCode)respose.statusCode];
        return NO;
    }
    return YES;
}

//检测是否可以发送信息
-(BOOL)checkCanSendRequest{
    if(![[NetWrokStatesCtrl getInstance] networkIsAvailable]){
        [self setError:ClientNetNoAvauable];
        NSLog(@"网络不可用");
        return NO;
    }
    if(self.msg == NULL){
        [self setError:MessageIsNull];
        return NO;
    }
    return YES;
}


//api 业务
-(void)setApiError:(requestErrorCode)errorCode{
    NSString* errorCodeStr = [[NetWorkError getInstance] getCode:(int)errorCode];
    NSLog(@"Api业务请求失败 = %@",errorCodeStr);
    if(self.fail!=NULL){
        if (errorCode  == UCTokenTimeOut) {
            [KKUserInfo share].ucToken = nil;
            [KKUserInfo share].apiToken = nil;
            [KKUserInfo share].telephone = nil;
            [KKHub showMtTostWithTitle:@"提示" WithText:@"登陆已过期,请点击重新登陆!" WithBtnText:@"确定,取消" WithClickBlock:^(NSInteger index) {
                if (index ==0) {
                    [self.signCtrl.loginSignilCallBack subscribeNext:^(id  _Nullable x) {
                        [self sendRequest];
                    }];
                    [self.signCtrl sign];
                }else{
                    exit(0);
                }
            }];
           
            return;
        }
        else if (errorCode == 25018){
            [SVProgressHUD showMessage:[KKErrrortext getErrorWitherrorRequestType:(ErrorRequestType)errorCode WithErrorCode:errorCode]];
        }
        
        if (![NSThread isMainThread]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showMessage:[KKErrrortext getErrorWitherrorRequestType:(ErrorRequestType)errorCode WithErrorCode:errorCode]];
                self.fail(errorCode);
            });
        }else {
            if (![errorCodeStr isEqualToString:@"未知错误!"]) {
                [SVProgressHUD showMessage:[KKErrrortext getErrorWitherrorRequestType:(ErrorRequestType)errorCode WithErrorCode:errorCode]];
            }
            self.fail(errorCode);
        }
    }
    else{
        //系统公用实现处理
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showMessage:[KKErrrortext getErrorWitherrorRequestType:(ErrorRequestType)errorCode WithErrorCode:errorCode]];
            });
        }else {
            [SVProgressHUD showMessage:[KKErrrortext getErrorWitherrorRequestType:(ErrorRequestType)errorCode WithErrorCode:errorCode]];

        }
        self.fail(errorCode);
    }
}

//回调错误信息
- (void)setError:(requestErrorCode)errorCode{
    [KKLoadingView hidden];
    [SVProgressHUD dismiss];
    GProtoBufferMessage* sendParam = self.msg;
    if (errorCode  == UCTokenTimeOut ) {
        [KKTool showSystemAlertWithTitle:@"提示" message:@"登陆状态失效,请重新登录" isShowCancel:NO completion:^{
            [[KKUserInfo share] clearUserInfo];
            AppDelegate *dele =(AppDelegate*) [UIApplication sharedApplication].delegate;
            [dele setTingWindow];
        } cancel:^{
            [[KKUserInfo share] clearUserInfo];
            AppDelegate *dele =(AppDelegate*) [UIApplication sharedApplication].delegate;
            [dele setTingWindow];
        }];
        return;
    }
    if(![[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
        NSLog(@"系统请求失败 = %i",errorCode);
        if ([KKErrrortext isTostWithApiStr:sendParam.apiName]) {
//            [SVProgressHUD showMessage:@"网络无连接,请稍后重试!"];
        }
    }
    else{
        self.fail(errorCode);
    }
}


- (SignController *)signCtrl{
    if (!_signCtrl) {
        _signCtrl = [[SignController alloc] init];
    }
    return _signCtrl;
}
@end
