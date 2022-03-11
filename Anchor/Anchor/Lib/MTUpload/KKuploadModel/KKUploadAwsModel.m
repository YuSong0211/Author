//
//  KKUploadAwsModel.m
//  KK
//
//  Created by 小草 on 2021/8/9.
//

#import "KKUploadAwsModel.h"

@interface KKUploadAwsModel ()

// 线程管理
@property (nonatomic,strong) NSOperationQueue *queue;

// 上传请求管理
@property (nonatomic,strong) AWSS3PutObjectRequest * objectRequest;

@end

@implementation KKUploadAwsModel

/// 上传到S3
/// @param authenticationModel 鉴权信息model
/// @param videInfo 视频信息
/// @param status 当前进度 当前状态
-(void)AwsWithUpload:(KKUploadAuthenticationModel *)authenticationModel
           videoInfo:(KKUploadInfoModel *)videInfo
            callBack:(UploadProgress)status{
    
    // 如果有视频会创建两次循环
    //NSInteger count = videInfo.videoPath.length==0?1:3;
    NSInteger count = videInfo.soucreArray.count;
    
    self.queue = [[NSOperationQueue alloc] init];
    for (NSInteger i = 0; i<count; i++) {
        self.queue.maxConcurrentOperationCount = count;
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            
            // 初始化S3上传工具
            AWSBasicSessionCredentialsProvider * credentialsProvider = [[AWSBasicSessionCredentialsProvider alloc]initWithAccessKey:authenticationModel.accessKey secretKey:authenticationModel.secretKey sessionToken:authenticationModel.sessionToken];
            // 指定域名
            AWSEndpoint * servicePoint = [[AWSEndpoint alloc]initWithURLString:[richers getCanUseUrl:Ocdomain_oss]]; //
            //AWSEndpoint * servicePoint = [[AWSEndpoint alloc]initWithURLString:@"http://minio.dev-env.nobojy.com"];
            // 指定时区 将 域名 及 provider传入
            AWSServiceConfiguration * configuration = [[AWSServiceConfiguration alloc]initWithRegion:AWSRegionAPEast1 endpoint:servicePoint credentialsProvider:credentialsProvider];
            [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
            // 初始化S3上传工具
            AWSS3 * ss = [AWSS3 defaultS3];
            
            // 配置上传工具请求类
            self.objectRequest = [[AWSS3PutObjectRequest alloc]init];
            self.objectRequest.ACL = AWSS3ObjectCannedACLPrivate;
            
            UploadOSSDataModel * fileModel = videInfo.soucreArray[i];
            
            // 文件名称
            //NSString * fileName = videInfo.fileNameArray[i];
            NSString * fileName = fileModel.objectName;
            
            // 服务端文件名称
            NSString * serviceFileName = @"这是服务端给我的文件名称，我要传给S3";
            
            // 文件bucketName
            NSString * fileBucketName = @"iOS从数组中根据文件名称取值bucketName";
            
            // 文件的事件id
            NSString * fileEventId = @"iOS从数组中根据文件名称取值eventid";
            for (appvapiOssCertificateEvent * objectEventInfo in authenticationModel.fileEventsArray) {
                NSLog(@"%@---%@",fileName,objectEventInfo.objectOriginalName);
                if ([fileName isEqualToString:objectEventInfo.objectOriginalName]) {
                    // 找到上传文件所需内容
                    fileBucketName = objectEventInfo.bucketName;
                    fileEventId = objectEventInfo.eventId.id_p;
                    serviceFileName = objectEventInfo.objectName;
                    //break;;
                }
            }
            if (fileModel.isImage) {
                // 图片
                self.objectRequest.contentType = @"image/jpeg";
                // 新的加密
                NSData * imageData = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(fileModel.image, 0.8)];
                self.objectRequest.body =  imageData;
                self.objectRequest.contentLength = [NSNumber numberWithUnsignedLongLong:[imageData length]];
                self.objectRequest.bucket = fileBucketName;
                self.objectRequest.key = serviceFileName;
            }else{
                self.objectRequest.contentType = @"video/mp4";
                
                // 新的加密
                 NSData * videoData = [richers encodeMedia:EncodeType_Video src:[NSData dataWithContentsOfFile:fileModel.videoFilePath]];
                 self.objectRequest.contentLength = [NSNumber numberWithUnsignedLongLong:[videoData length]];
                 self.objectRequest.body = videoData;
                
                self.objectRequest.bucket = fileBucketName;
                self.objectRequest.key = serviceFileName;
            }

            // 开始上传
            [[ss putObject:self.objectRequest] continueWithSuccessBlock:^id _Nullable(AWSTask<AWSS3PutObjectOutput *> * _Nonnull t) {
                // 是否取消上传
                if (self.objectRequest.cancelled == YES) {
                    return nil;
                }
                
                // 当前是否失败
                if (t.error) {
                    NSLog(@"上传失败，失败原因为：%@",t.error);
                }
                
                // 当前是否完成
                if (t.completed == YES) {
                    // 当前任务的id
                    NSString * eventId  = fileEventId;
                    // 上传后通知服务端
                    [self uploadedNotifictionService:YES authorID:authenticationModel.batchId eventid:eventId totalCount:count currentIndex:i callBack:status];
                }else{
                    [self cancelUpload:NO];

                    status(100.0,KKUploadStateUploadFailed,YES);
                }
                return nil;
            }];
            // 当前的上传的进度
            [self.objectRequest setUploadProgress:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
                
                // 以最后一个上传的文件进度为基准
                CGFloat progress = ((CGFloat)totalBytesSent/(CGFloat)totalBytesExpectedToSend)*100;
                if (progress >100) {
                    progress = 100;
                }
                
                
                // UI层是否可以用此进度展示
                BOOL isGetProgress = NO;
                // 如果当前全是图片，则以每张上传进入作为展示
                // 计算方式: 单个图片上传进度 = 图片个数 / 100
                if (videInfo.isImage == YES) {
                    isGetProgress = YES;
                    if (((CGFloat)totalBytesSent/(CGFloat)totalBytesExpectedToSend)*100 == 100) {
                        status(100,KKUploadStateUploading,isGetProgress);
                    }
                }else{
                    isGetProgress = i==count-1?YES:NO;
                    status(progress,KKUploadStateUploading,isGetProgress);
                }
                NSLog(@"当前上传进度-- %f",((CGFloat)totalBytesSent/(CGFloat)totalBytesExpectedToSend)*100);
            }];
        }];
        if (self.queue.operations.count != 0) {
            [operation addDependency:self.queue.operations.lastObject];
        }
        [self.queue addOperation:operation];
    }
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
                         callBack:(UploadProgress)status{
    // 上传成功回调
    [KKPublicUploadSuccessModel uploadSuccessToServiceWithInfo:authorid eventId:eventid isFinish:isfinish status:1 completion:^(BOOL finish) {
        if (finish == YES) {
            if (index == count - 1) {
                status(100.0,KKUploadStateUploadComplete,index==count-1?YES:NO);
            }
        }else{
            status(100.0,KKUploadStateUploadFailed,YES);
            [self cancelUpload:NO];
        }
    }];
}


// 取消上传
-(void)cancelUpload:(BOOL)isNofiService{
    
    // 取消上传
    [self.objectRequest cancel];
    self.objectRequest = nil;
    // 取消所有进程
    [self.queue cancelAllOperations];
    NSLog(@"取消了上传");
}
@end
