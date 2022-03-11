//
//  KKPublicUpLoadFileMoudle.m
//  KK
//
//  Created by 小草 on 2021/7/28.
//

#import "KKPublicUpLoadFileMoudle.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>

@interface KKPublicUpLoadFileMoudle ()
// 信息数据
@property (nonatomic,strong) KKUploadInfoModel * infoModel;
// 上传管理
@property (nonatomic,strong) NSMutableArray * putMangerArray;

@property (nonatomic,strong) NSOperationQueue *queue;

@end

@implementation KKPublicUpLoadFileMoudle
/// 传入需要上传的数据，开始上传。
/// @param infoModel 有图片 和 视频 两种类型
-(instancetype)initWithInfoModel:(KKUploadInfoModel *)infoModel{
    self = [super init];
    if (self) {
        // 调用上传
        self.infoModel = infoModel;
    }
    return self;
}
// 开始上传
-(void)startUpload{
    id<OSSCredentialProvider> credential = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSString * url =  [NSString stringWithFormat:@"%@api/ossReq?content=%@",testGetUrl,[self KKStingUrlEncode:contentToSign]];
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
   
    NSInteger count = self.infoModel.videoPath.length>0?2:1;
   
    self.queue = [[NSOperationQueue alloc] init];
    for (NSInteger i = 0; i<count; i++) {
        self.queue.maxConcurrentOperationCount = count;
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
    // 填写文件完整路径，例如exampledir/exampleobject.txt
    if (self.infoModel.imageData != nil && index == 0) {
         // 图片
        put.objectKey = self.infoModel.imageName;
        put.uploadingData = self.infoModel.imageData;
    }else{
        // 视频
        put.objectKey = self.infoModel.videoName;
        put.uploadingFileURL = [NSURL fileURLWithPath:self.infoModel.videoPath];
    }
    // 设置上传进度。
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 已经上传总长度、待上传的总长度。
        if (self.infoModel.uploadProgressBlock) {
            self.infoModel.uploadProgressBlock(totalByteSent, totalBytesExpectedToSend,index==1?YES:NO);
        }
    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            if (self.infoModel.uploadStateBlock) {
                self.infoModel.uploadStateBlock(UploadStateUploadComplete, [NSString stringWithFormat:@"https://xcrx012.oss-cn-hangzhou.aliyuncs.com/%@",put.objectKey]);
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
-(void)cancelUpload{
    // 停止所有上传信息
    for (OSSPutObjectRequest * put in self.putMangerArray) {
        [put cancel];
    }
    // 取消所有线程
    [self.queue cancelAllOperations];
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
