//
//  KKUploadOssModel.m
//  KK
//
//  Created by 小草 on 2021/8/9.
//

#import "KKUploadOssModel.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>

@interface KKUploadOssModel ()

// 线程管理
@property (nonatomic,strong) NSOperationQueue *queue;

@property (nonatomic,strong) NSMutableArray * putMangerArray;

// 信息数据
@property (nonatomic,strong) KKUploadInfoModel * infoModel;

// 鉴权信息数据
@property (nonatomic,strong) KKUploadAuthenticationModel * authenticationModel;

@property (nonatomic,assign) BOOL isCancelUpload; // 是否手动退出上传

@end

@implementation KKUploadOssModel



/// 阿里云上传
/// @param authenticationModel 鉴权model
/// @param videInfo 文件信息model
/// @param status 当前方法执行的状态回调
-(void)OssWithUpload:(KKUploadAuthenticationModel *)authenticationModel videoInfo:(KKUploadInfoModel *)videInfo callBack:(UploadProgress)status{
    
    // 每次调用之前先重置当前的状态
    [self cancelUpload:NO];
    
    self.isCancelUpload = NO;
    
    // 文件信息
    self.infoModel = videInfo;
    // 鉴权信息
    self.authenticationModel = authenticationModel;
    
    // 初始化线程
    self.queue = [[NSOperationQueue alloc]init];
    
    // 初始化OSS provider
    NSString *accessKey = authenticationModel.accessKey;
    NSString *secretKey = authenticationModel.secretKey;
    NSString *sessionToken = authenticationModel.sessionToken;
    
    // 构建临时授权模式
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKey secretKeyId:secretKey securityToken:sessionToken];
    
    for (NSInteger i = 0; i<videInfo.soucreArray.count; i++) {
        self.queue.maxConcurrentOperationCount = videInfo.soucreArray.count;
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            // client端的配置,如超时时间，开启dns解析等等
            OSSClientConfiguration *cfg = [[OSSClientConfiguration alloc] init];
            OSSClient *  client = [[OSSClient alloc] initWithEndpoint:[richers getCanUseUrl:Ocdomain_oss] credentialProvider:credential clientConfiguration:cfg];
            // 优先上传图片
            [self upload:client uploadIndex:i callBack:status];
        }];
        if (self.queue.operations.count != 0) {
            [operation addDependency:self.queue.operations.lastObject];
        }
        [self.queue addOperation:operation];
    }
    
}

/// 开始上传
/// @param client 上传工具
/// @param index 当前上传的下标
/// @param status 当前上传的回调状态
-(void)upload:(OSSClient *)client
  uploadIndex:(NSInteger)index
     callBack:(UploadProgress)status{
    // 服务端文件名称
    NSString * serviceFileName = @"这是服务端给我的文件名称，我要传给OSS";
    // 文件bucketName
    NSString * fileBucketName = @"iOS从数组中根据文件名称取值bucketName";
    // 文件的事件id
    NSString * fileEventId = @"iOS从数组中根据文件名称取值eventid";
    
    // 文件信息
    UploadOSSDataModel * fileModel = self.infoModel.soucreArray[index];
    
    // 文件名称
    NSString * fileName = fileModel.objectName;
    // 查询鉴权信息
    for (appvapiOssCertificateEvent * objectEventInfo in self.authenticationModel.fileEventsArray) {
        if ([fileName isEqualToString:objectEventInfo.objectOriginalName]) {
            // 找到上传文件所需内容
            fileBucketName = objectEventInfo.bucketName;
            fileEventId = objectEventInfo.eventId.id_p;
            serviceFileName = objectEventInfo.objectName;
        }
    }
    // 初始化上传请求
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // 将所有的和上传请求加入数组中，方便取消上传的时候调用
    [self.putMangerArray addObject:put];
    
    // 填写Bucket名称
    put.bucketName = fileBucketName;
    put.objectKey = serviceFileName;
    
    if ([put.objectKey isEqualToString:@"这是服务端给我的文件名称，我要传给OSS"]) {
        NSLog(@"11111111111");
    }
    
    if (fileModel.isImage) {
        // 图片
        put.contentType = @"image/jpeg";
        
        CGFloat zipNumber = fileModel.isThumbImage?thumbnailCoverZip:videoCoverZip;
        
        // 新的加密
        NSData * imageData = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(fileModel.image, zipNumber)];
        put.uploadingData = imageData;
    }else{
        put.contentType = @"video/mp4";
        put.objectKey = serviceFileName;
        // 新的加密
        put.uploadingData =  [richers encodeMedia:EncodeType_Video src:[NSData dataWithContentsOfFile:fileModel.videoFilePath]];
    }
    
    // 计算上传进度
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 以最后一个上传的文件进度为基准
        CGFloat progress = ((CGFloat)totalByteSent/(CGFloat)totalBytesExpectedToSend)*100;
        if (progress >100) {
            progress = 100;
        }
        // UI层是否可以用此进度展示
        BOOL isGetProgress = NO;
        // 如果当前全是图片，则以每张上传进入作为展示
        // 计算方式: 单个图片上传进度 = 图片个数 / 100
        if (self.infoModel.isImage == YES) {
            isGetProgress = YES;
            if (progress == 100) {
                status(100,KKUploadStateUploading,isGetProgress);
            }
        }else{
            isGetProgress = index == self.infoModel.soucreArray.count-1?YES:NO;
            status(progress,KKUploadStateUploading,isGetProgress);
        }
        NSLog(@"当前上传进度-- %f",progress);
    };
    
    // 上传结果回调
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        
        // 退出的话，下面就不执行了
        if (self.isCancelUpload == YES) {
            return nil;
        }
        
        NSLog(@"%@",put.objectKey);
        if (task.error == nil) {
            if (task.cancelled == YES){
                status(0,KKUploadStateUploadCancel,YES);
            }
            if (task.completed == YES){
                [self uploadedNotifictionService:YES authorID:self.authenticationModel.batchId
                                         eventid:fileEventId
                                      totalCount:self.infoModel.soucreArray.count
                                    currentIndex:index
                                  callBackStatus:appvapiCallbackEvent_Status_StatusSuccess
                                        callBack:status];
            }
        } else {
            if (status) {
                //status(100,self.isCancelUpload==YES?KKUploadStateUploadCancel:KKUploadStateUploadFailed,YES);
                status(100,KKUploadStateUploadFailed,YES);
            }
        }
        return nil;
    }];
    [putTask waitUntilFinished];
}


/// 上传成功后通知服务端
/// @param isfinish 是否上传成功，或取消上传
/// @param authorid 鉴权信息
/// @param eventid 时间id
/// @param status 当前状态及进度
-(void)uploadedNotifictionService:(BOOL)isfinish
                         authorID:(NSString *)authorid
                          eventid:(NSString *)eventid
                       totalCount:(NSInteger)count
                     currentIndex:(NSInteger)index
                   callBackStatus:(appvapiCallbackEvent_Status)callBackStatus
                         callBack:(UploadProgress)status{
    // 上传成功回调
    [KKPublicUploadSuccessModel uploadSuccessToServiceWithInfo:authorid eventId:eventid isFinish:isfinish status:callBackStatus completion:^(BOOL finish) {
        if (callBackStatus == appvapiCallbackEvent_Status_StatusSuccess) {
            if (finish == YES) {
                if (index == count - 1) {
                    status(100.0,KKUploadStateUploadComplete,index==count-1?YES:NO);
                }
            }else{
                status(100.0,KKUploadStateUploadFailed,YES);
                [self cancelUpload:NO];
            }
        }else{
            [self cancelUpload:NO];
        }
    }];
}


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  下面的是自签名的目前不用   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



/// 传入需要上传的数据，开始上传。
/// @param infoModel 有图片 和 视频 两种类型
-(void)initWithInfoModel:(KKUploadInfoModel *)infoModel{
    self.infoModel = infoModel;
    id<OSSCredentialProvider> credential = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSString * url =  [NSString stringWithFormat:@"%@%@",testGetUrl,[self KKStingUrlEncode:contentToSign]];
        //NSString * url =  [NSString stringWithFormat:@"%@%@",[richers getCanUseUrl:Ocdomain_oss],[self KKStingUrlEncode:contentToSign]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.HTTPMethod = @"GET";
        NSURLSession *seesion = [NSURLSession sharedSession];
        static NSString * string;
        NSURLSessionDataTask *task = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 调用上传
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            string = result;
            dispatch_semaphore_signal(semaphore);
        }];
        [task resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        return string;
    }];
    self.queue = [[NSOperationQueue alloc] init];
    for (NSInteger i = 0; i<infoModel.soucreArray.count; i++) {
        self.queue.maxConcurrentOperationCount = infoModel.soucreArray.count;
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            // client端的配置,如超时时间，开启dns解析等等
            OSSClientConfiguration *cfg = [[OSSClientConfiguration alloc] init];
            OSSClient *  client = [[OSSClient alloc] initWithEndpoint:@"http://oss-cn-hangzhou.aliyuncs.com" credentialProvider:credential clientConfiguration:cfg];
            // 优先上传图片
            [self upload:client uploadIndex:i];
        }];
        if (self.queue.operations.count != 0) {
            [operation addDependency:self.queue.operations.lastObject];
        }
        [self.queue addOperation:operation];
    }
}

-(void)upload:(OSSClient *)client uploadIndex:(NSInteger)index{
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    [self.putMangerArray addObject:put];
    // 填写Bucket名称
    put.bucketName = @"xcrx012";
    
    UploadOSSDataModel * dataModel = self.infoModel.soucreArray[index];
    if ([dataModel.objectName containsString:@"image"]) {
        // 图片
        put.objectKey = dataModel.objectName;
        put.contentType = @"image/jpeg";
        NSData*data = UIImageJPEGRepresentation(dataModel.image, 0.8);
        // 新的加密
        put.uploadingData = [richers encodeMedia:EncodeType_Image src:data];
        // 旧的加密
        //put.uploadingData = [NSData encode:UIImageJPEGRepresentation(dataModel.image, 0.8)];
        
    }else{
        put.contentType = @"video/mp4";
        put.objectKey = dataModel.objectName;
        // 新的加密
        put.uploadingData =  [richers encodeMedia:EncodeType_Video src:[NSData dataWithContentsOfFile:dataModel.videoFilePath]];
        // 旧的加密
        //put.uploadingData = [NSData encode:[NSData dataWithContentsOfFile:dataModel.videoFilePath]];
    }
    // 设置上传进度。
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 已经上传总长度、待上传的总长度。
        if (self.infoModel.uploadProgressBlock) {
            NSLog(@"%f",((CGFloat)totalByteSent/(CGFloat)totalBytesExpectedToSend)*100);
            self.infoModel.uploadProgressBlock(totalByteSent, totalBytesExpectedToSend,index==self.infoModel.soucreArray.count-1?YES:NO);
        }
    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            if (self.infoModel.uploadStateBlock) {
                self.infoModel.uploadStateBlock(index==self.infoModel.soucreArray.count-1?UploadStateUploadComplete:UploadStateUploading, [NSString stringWithFormat:@"https://xcrx012.oss-cn-hangzhou.aliyuncs.com/%@",put.objectKey]);
            }
            NSLog(@"%@",[NSString stringWithFormat:@"https://xcrx012.oss-cn-hangzhou.aliyuncs.com/%@",put.objectKey]);
        } else {
            if (self.infoModel.uploadStateBlock) {
                self.infoModel.uploadStateBlock(UploadStateUploadFailed, @"");
            }
        }
        return nil;
    }];
    [putTask waitUntilFinished];
}

// 调用退出上传 infoModel会返回 UploadStateUploadCancel
-(void)cancelUpload:(BOOL)isNofiService{
    self.isCancelUpload = YES;
    // 停止所有上传信息
    for (OSSPutObjectRequest * put in self.putMangerArray) {
        [put cancel];
    }
    // 取消所有线程
    [self.queue cancelAllOperations];
    
    // 是否需要通知服务端进行记录
    if (isNofiService == YES) {
        [self uploadedNotifictionService:NO authorID:self.authenticationModel.batchId eventid:@"" totalCount:0 currentIndex:0 callBackStatus:appvapiCallbackEvent_Status_StatusCancel callBack:nil];
    }
}

-(NSMutableArray *)putMangerArray{
    if (!_putMangerArray) {
        _putMangerArray = [[NSMutableArray alloc]init];
    }
    return _putMangerArray;
}

-(NSString *)KKStingUrlEncode:(NSString *)string{
    NSString *encodedString = (NSString *)  
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
    return encodedString;
}

@end
