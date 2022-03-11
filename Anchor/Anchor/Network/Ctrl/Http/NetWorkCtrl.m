//
//  NetWorkCtrl.m
//  KK
//
//  Created by hk on 2021/6/23.
//

#import "NetWorkCtrl.h"
#import <AFNetworking.h>
#import "UcPrimaryApiSign.pbobjc.h"


@interface NetWorkCtrl()

@property (nonatomic,strong)GPBMessage *resp;

@end

NetWorkCtrl *_netWork = nil;
@implementation NetWorkCtrl
+ (instancetype)requestShare {
    if (!_netWork) {
        _netWork = [[NetWorkCtrl alloc] init];
    }
    return _netWork;
}


+ (instancetype)requestShareWithRespose:(GPBMessage *)resp{
    if (!_netWork) {
        _netWork = [[NetWorkCtrl alloc] init];
        _netWork.resp = resp;
    }
    else{
        _netWork.resp = resp;
    }
    return _netWork;
}


//用这个请求
- (NetWorkCtrl *)KK_request:(id)message heads:(NSMutableArray<HeadsConfig *> *)heads requestType:(RequsetType)requestType complete:(OnComplete)complete failed:(OnFailed)failed{
    
    GProtoBufferMessage* pb = message;
    NSData *reqdata = [pb.pb_request data];
    //拼接url
    NSString* url = @"";
    if(requestType == ApiUcLogin){
        url = [testDataGetUrl stringByAppendingString:pb.apiName];
    }
    else{
        url = [testGetUrl stringByAppendingString:pb.apiName];
    }
    //end
    NSLog(@"请求地址1:\n%@\n",url);
    //head
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    switch (requestType) {
        case HttpReqGet:
        {
            [request setHTTPMethod:@"GET"];
        }
            break;
        case HttpReqPost:
        {
            [request setHTTPMethod:@"POST"];
        }
            break;
        default:
            [request setHTTPMethod:@"POST"];
            break;
    }
    //end
    if(heads!=NULL &&heads.count>0){
        //拼接head
        for (int i=0; i<heads.count; i++) {
            HeadsConfig* headparam = heads[i];
            [request setValue:headparam.value forHTTPHeaderField:headparam.key];
        }
    }
    //增加服务器协议 head 头标识
    // 根据后台要求自行增加此处标识
    [request setValue:@"application/grpc" forHTTPHeaderField:@"Content-Type"];
    //组建字节流
    [request setHTTPBody:reqdata];
    NSDictionary* req_heads = request.allHTTPHeaderFields;
//    NSLog(@"传参:content---: %@", pb.pb_request);
//    NSLog(@"请求head===>%@\n---------",req_heads);
    //暂时使用nsurlseesion
    NSURLSession *seesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if(resp.statusCode == 200){
            
            // 业务层code错误码
            NSInteger errorCode = 0;
            if ([resp.allHeaderFields.allKeys containsObject:@"x-err"]) {
                errorCode = [resp.allHeaderFields[@"x-err"] integerValue];
            }
            if (errorCode == 0) {
                // 当前block是否在主线程
                NSError *error = NULL;
                int len = data.length;
                pb.pb_respose = [pb.pb_respose initWithData:data error:nil];
                if (![NSThread isMainThread]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       // NSLog(@"返回数据:==========%@", pb.pb_respose);
                        complete(pb);
                    });
                }else {
                   // NSLog(@"返回数据:==========%@",pb.pb_respose);
                    complete(pb);
                   // NSLog(@"%@",response);
                }
            }else {
                [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回业务层错误码:%@",resp.allHeaderFields[@"x-err"]]];
            }
        }else  if(resp.statusCode == 500){
            // 服务器返回500处理具体错误信息(弹出提示)
            [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回错误码:%@",resp.allHeaderFields[@"x-proxy-err"]]];
        }else{
            // 服务器返回404不做处理
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failed(-1);
                });
            }else {
                failed(-1);
                NSLog(@"%@",response);
            }
        }
    }];
    [task resume];
    return self;
    
}

- (NetWorkCtrl*)KK_requestWhitUrl:(NSString *)url
                       paramsBody:(GPBMessage *)paramsBody
                            heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                      requestType:(RequsetType)requestType
                        respBlock:(HttpResp)respBlock{
    NSData *data =  [paramsBody data];
    if (data.bytes == 0 || kStringIsEmpty(url)) {
        // url或者data请求头不存在直接返回请求失败操作
        respBlock(HttpReqInvied,data);
        return self;
    }
//    if (self.requestStates == 1) {
//        // 登录请求
//        url = [testDataGetUrl stringByAppendingString:url];
//        NSLog(@"===========%@",url);
//    }else {
//        // 其他请求
        //url = [testGetUrl stringByAppendingString:url];
//    }
    
    if(requestType == ApiUcLogin){
        url = [testDataGetUrl stringByAppendingString:url];
    }
    else{
        url = [testGetUrl stringByAppendingString:url];
    }
    
    NSLog(@"请求地址1:\n%@\n",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    switch (requestType) {
        case HttpReqGet:
        {
            [request setHTTPMethod:@"GET"];
        }
            break;
        case HttpReqPost:
        {
            [request setHTTPMethod:@"POST"];
        }
            break;
        default:
            [request setHTTPMethod:@"POST"];
            break;
    }
    if(heads!=NULL &&heads.count>0){
        //拼接head
//        for (int i=0; i<heads.count; i++) {
//            HeadsConfig* headparam = heads[i];
//            [request setValue:headparam.value forHTTPHeaderField:headparam.key];
//        }
    }
    NSString* uuid = [[KKUserInfo share] uid];
    [request setValue:uuid forHTTPHeaderField:@"x-netcore_test"];
    //增加服务器协议 head 头标识
    // 根据后台要求自行增加此处标识
    [request setValue:@"application/grpc" forHTTPHeaderField:@"Content-Type"];
    //组建字节流
    [request setHTTPBody:data];
    NSDictionary* req_heads = request.allHTTPHeaderFields;
    NSLog(@"传参:content---: %@", paramsBody);
    NSLog(@"请求head===>%@\n---------",req_heads);
    //暂时使用nsurlseesion
    NSURLSession *seesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if(resp.statusCode == 200){
            
            // 业务层code错误码
            NSInteger errorCode = 0;
            if ([resp.allHeaderFields.allKeys containsObject:@"x-err"]) {
                errorCode = [resp.allHeaderFields[@"x-err"] integerValue];
            }
            if (errorCode == 0) {
                // 当前block是否在主线程
                NSError *error = NULL;
                GPBMessage *messageData = [GPBMessage parseFromData:data error:&error];
                if(self.resp!=NULL){
                    messageData = [self.resp initWithData:data error:&error];
                }
               
                if (![NSThread isMainThread]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                      //  NSLog(@"返回数据:==========%@",messageData);
                        respBlock(HttpReqSuccess,data);
                    });
                }else {
                    //NSLog(@"返回数据:==========%@",messageData);
                    respBlock(HttpReqSuccess,data);
                   // NSLog(@"%@",response);
                }
            }else {
                [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回业务层错误码:%@",resp.allHeaderFields[@"x-err"]]];
            }
        }else {
            [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回错误码:%@",resp.allHeaderFields[@"x-proxy-err"]]];
            // 服务器返回404不做处理
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    respBlock(HttpReqInvied,data);
                });
            }else {
                respBlock(HttpReqInvied,data);
                NSLog(@"%@",response);
            }
        }
    }];
    [task resume];
    return  self;
}


//自动解析代码。
- (NetWorkCtrl*)KK_requestWhitUrlAutoParse:(NSString *)url
                       paramsBody:(GPBMessage *)paramsBody
                       paramsParser:(Class *)paramsParser
                            heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                      requestType:(RequsetType)requestType
                        respBlock:(HttpResp)respBlock{
    NSData *data =  [paramsBody data];
    if (data.bytes == 0 || kStringIsEmpty(url)) {
        // url或者data请求头不存在直接返回请求失败操作
        respBlock(HttpReqInvied,data);
        return self;
    }
    
//    if (self.requestStates == 1) {
//        // 登录请求
//        url = [testDataGetUrl stringByAppendingString:url];
//        NSLog(@"===========%@",url);
//    }else {
//        // 其他请求
        //url = [testGetUrl stringByAppendingString:url];
//    }
    if(requestType == ApiUcLogin){
        url = [testDataGetUrl stringByAppendingString:url];
    }
    else{
        url = [testGetUrl stringByAppendingString:url];
    }
    
    NSLog(@"请求地址1:\n%@\n",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    switch (requestType) {
        case HttpReqGet:
        {
            [request setHTTPMethod:@"GET"];
        }
            break;
        case HttpReqPost:
        {
            [request setHTTPMethod:@"POST"];
        }
            break;
        default:
            break;
    }
    if(heads!=NULL &&heads.count>0){
        //拼接head
        for (int i=0; i<heads.count; i++) {
            HeadsConfig* headparam = heads[i];
            [request setValue:headparam.value forHTTPHeaderField:headparam.key];
        }
    }
    //增加服务器协议 head 头标识
    // 根据后台要求自行增加此处标识
    [request setValue:@"application/grpc" forHTTPHeaderField:@"Content-Type"];
    //组建字节流
    [request setHTTPBody:data];
    NSDictionary* req_heads = request.allHTTPHeaderFields;
    NSLog(@"传参:content---: %@", paramsBody);
    NSLog(@"请求head===>%@\n---------",req_heads);
    //暂时使用nsurlseesion
    NSURLSession *seesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if(resp.statusCode == 200){
            
            // 业务层code错误码
            NSInteger errorCode = 0;
            if ([resp.allHeaderFields.allKeys containsObject:@"x-err"]) {
                errorCode = [resp.allHeaderFields[@"x-err"] integerValue];
            }
            if (errorCode == 0) {
                // 当前block是否在主线程
                NSError *error = NULL;
                GPBMessage *messageData = [GPBMessage parseFromData:data error:&error];
                if (![NSThread isMainThread]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"返回数据:==========%@",messageData);
                        respBlock(HttpReqSuccess,data);
                    });
                }else {
                    NSLog(@"返回数据:==========%@",messageData);
                    respBlock(HttpReqSuccess,data);
                    NSLog(@"%@",response);
                }
            }else {
                [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回业务层错误码:%@",resp.allHeaderFields[@"x-err"]]];
            }
        }else  if(resp.statusCode == 500){
            // 服务器返回500处理具体错误信息(弹出提示)
            [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回错误码:%@",resp.allHeaderFields[@"x-proxy-err"]]];
        }else{
            // 服务器返回404不做处理
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    respBlock(HttpReqInvied,data);
                });
            }else {
                respBlock(HttpReqInvied,data);
                NSLog(@"%@",response);
            }
        }
    }];
    [task resume];
    return  self;
}


- (NetWorkCtrl*)KK_requestSignWhitUrl:(NSString *)url
                       paramsBody:(GPBMessage *)paramsBody
                            heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                      requestType:(RequsetType)requestType
                        respBlock:(HttpResp)respBlock {
    NSData *data =  [paramsBody data];
    if (data.bytes == 0 || kStringIsEmpty(url)) {
        // url或者data请求头不存在直接返回请求失败操作
        respBlock(HttpReqInvied,data);
        return self;
    }
    // 登录请求
    url = [testDataGetUrl stringByAppendingString:url];
    NSLog(@"请求地址1:\n%@\n",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    switch (requestType) {
        case HttpReqGet:
        {
            [request setHTTPMethod:@"GET"];
        }
            break;
        case HttpReqPost:
        {
            [request setHTTPMethod:@"POST"];
        }
            break;
        default:
            break;
    }
    if(heads!=NULL &&heads.count>0){
        //拼接head
        for (int i=0; i<heads.count; i++) {
            HeadsConfig* headparam = heads[i];
            [request setValue:headparam.value forHTTPHeaderField:headparam.key];
        }
    }
    //增加服务器协议 head 头标识
    // 根据后台要求自行增加此处标识
    [request setValue:@"application/grpc" forHTTPHeaderField:@"Content-Type"];
    //组建字节流
    [request setHTTPBody:data];
    NSDictionary* req_heads = request.allHTTPHeaderFields;
    NSLog(@"传参:content---: %@", paramsBody);
    NSLog(@"请求head===>%@\n---------",req_heads);
    //暂时使用nsurlseesion
    NSURLSession *seesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if(resp.statusCode == 200){
            
            // 业务层code错误码
            NSInteger errorCode = 0;
            if ([resp.allHeaderFields.allKeys containsObject:@"x-err"]) {
                errorCode = [resp.allHeaderFields[@"x-err"] integerValue];
            }
            if (errorCode == 0) {
                // 当前block是否在主线程
                NSError *error = NULL;
                GPBMessage *messageData = [GPBMessage parseFromData:data error:&error];
                if (![NSThread isMainThread]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"返回数据:==========%@",messageData);
                        respBlock(HttpReqSuccess,data);
                    });
                }else {
                    NSLog(@"返回数据:==========%@",messageData);
                    respBlock(HttpReqSuccess,data);
                    NSLog(@"%@",response);
                }
            }else {
                [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回业务层错误码:%@",resp.allHeaderFields[@"x-err"]]];
            }
        }else  if(resp.statusCode == 500){
            // 服务器返回500处理具体错误信息(弹出提示)
            [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回错误码:%@",resp.allHeaderFields[@"x-proxy-err"]]];
        }else{
            // 服务器返回404不做处理
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    respBlock(HttpReqInvied,data);
                });
            }else {
                respBlock(HttpReqInvied,data);
                NSLog(@"%@",response);
            }
        }
    }];
    [task resume];
    return  self;
}

- (NetWorkCtrl*)KK_requestSignTongWhitUrl:(NSString *)url
                       paramsBody:(GPBMessage *)paramsBody
                            heads:(nullable NSMutableArray<HeadsConfig *> *)heads
                      requestType:(RequsetType)requestType
                        respBlock:(HttpResp)respBlock {
    NSData *data =  [paramsBody data];
    if (data.bytes == 0 || kStringIsEmpty(url)) {
        // url或者data请求头不存在直接返回请求失败操作
        respBlock(HttpReqInvied,data);
        return self;
    }
    // 登录请求
    url = [testDataTongGetUrl stringByAppendingString:url];
    NSLog(@"请求地址1:\n%@\n",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    switch (requestType) {
        case HttpReqGet:
        {
            [request setHTTPMethod:@"GET"];
        }
            break;
        case HttpReqPost:
        {
            [request setHTTPMethod:@"POST"];
        }
            break;
        default:
            break;
    }
    if(heads!=NULL &&heads.count>0){
        //拼接head
        for (int i=0; i<heads.count; i++) {
            HeadsConfig* headparam = heads[i];
            [request setValue:headparam.value forHTTPHeaderField:headparam.key];
        }
    }
    //增加服务器协议 head 头标识
    // 根据后台要求自行增加此处标识
    [request setValue:@"application/grpc" forHTTPHeaderField:@"Content-Type"];
    //组建字节流
    [request setHTTPBody:data];
    NSDictionary* req_heads = request.allHTTPHeaderFields;
    NSLog(@"传参:content---: %@", paramsBody);
    NSLog(@"请求head===>%@\n---------",req_heads);
    //暂时使用nsurlseesion
    NSURLSession *seesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if(resp.statusCode == 200){
            
            // 业务层code错误码
            NSInteger errorCode = 0;
            if ([resp.allHeaderFields.allKeys containsObject:@"x-err"]) {
                errorCode = [resp.allHeaderFields[@"x-err"] integerValue];
            }
            if (errorCode == 0) {
                // 当前block是否在主线程
                NSError *error = NULL;
                GPBMessage *messageData = [GPBMessage parseFromData:data error:&error];
                if (![NSThread isMainThread]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"返回数据:==========%@",messageData);
                        respBlock(HttpReqSuccess,data);
                    });
                }else {
                    NSLog(@"返回数据:==========%@",messageData);
                    respBlock(HttpReqSuccess,data);
                    NSLog(@"%@",response);
                }
            }else {
                [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回业务层错误码:%@",resp.allHeaderFields[@"x-err"]]];
            }
        }else  if(resp.statusCode == 500){
            // 服务器返回500处理具体错误信息(弹出提示)
            [SVProgressHUD showMessage:[NSString stringWithFormat:@"服务器返回错误码:%@",resp.allHeaderFields[@"x-proxy-err"]]];
        }else{
            // 服务器返回404不做处理
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    respBlock(HttpReqInvied,data);
                });
            }else {
                respBlock(HttpReqInvied,data);
                NSLog(@"%@",response);
            }
        }
    }];
    [task resume];
    return  self;
}

@end
