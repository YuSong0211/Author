//
//  KKPublishViewModel.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKUploadModel.h"
#import "KKEditUserInfoModel.h" // 上传头像调用
#import "KKPublicUploadingModel.h" // 上传前调用
#import "KKUploadAuthenticationModel.h" // 上传前的鉴权model
#import "KKUploadSuperModel.h" // 上传的父类model
#import "KKUploadAwsModel.h" // S3
#import "KKUploadOssModel.h" // Oss

@interface KKUploadModel ()

@property (nonatomic,strong) KKUploadAwsModel * awsModel;

@property (nonatomic,strong) KKUploadOssModel * ossModel;

@property (nonatomic,assign) BOOL isCancel;

@end

@implementation KKUploadModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/// 接受视频信息model后开始上传
/// @param videoInfo 视频信息model
-(void)publishBeginUploadingWithVideoInfo:(KKUploadInfoModel *)videoInfo{
    // 将文件信息发送至后端保存
    [KKPublicUploadingModel uploadingToServiseModel:videoInfo completion:^(KKUploadAuthenticationModel * _Nonnull authenticatioResult) {
        
        self.isCancel = NO;
        if (authenticatioResult.isForbiddenWords == YES) {
            if ([self.delegate respondsToSelector:@selector(currentUploadProgress:uploadState:isGetProgress:)]) {
                [self.delegate currentUploadProgress:0 uploadState:KKUploadStateUploadForbiddenWords isGetProgress:YES];
            }
            return;
        }
        
        if (authenticatioResult!=nil && self.isCancel == NO) {
            // 开始进行分发上传
            [self startUploadWithAuthorizaModel:authenticatioResult videoInfoModel:videoInfo];
        }else{
            // 代理传送至控制层进行显示
            if ([self.delegate respondsToSelector:@selector(currentUploadProgress:uploadState:isGetProgress:)]) {
                [self.delegate currentUploadProgress:0 uploadState:KKUploadStateUploadFailed isGetProgress:NO];
            }
        }
    }];
}

/// 用户头像上传方法
/// @param avaterInfo 包含用户头像的信息
-(void)avaterBeginUploadWithInfo:(KKUploadInfoModel *)avaterInfo{
    
    [KKEditUserInfoModel uploadingUserAvaterToServiseModel:avaterInfo completion:^(KKUploadAuthenticationModel * _Nonnull authenticatioResult) {
        // 开始进行分发上传
        [self startUploadWithAuthorizaModel:authenticatioResult videoInfoModel:avaterInfo];
    }];
}

// 开始上传视频图片和视频
// 私有方法，只在内部进行调用
// 外部访问 beginUploadingWithVideoInfo
-(void)startUploadWithAuthorizaModel:(KKUploadAuthenticationModel *)authorizaModel
                      videoInfoModel:(KKUploadInfoModel *)videInfoModel{
    
    // 全局接收文件model
    self.fileModel = videInfoModel;
    
    if ([[KKPubTagVCModel shareToolGetManager].ossProvider isEqualToString:@"ali_oss"]) {
        // 调用上传
        self.ossModel = [[KKUploadOssModel alloc]init];
        [self.ossModel OssWithUpload:authorizaModel videoInfo:videInfoModel callBack:^(CGFloat Progress, KKUploadState state, BOOL isGetProgress) {
            // 代理传送至控制层进行显示
            if ([self.delegate respondsToSelector:@selector(currentUploadProgress:uploadState:isGetProgress:)]) {
                [self.delegate currentUploadProgress:Progress uploadState:state isGetProgress:isGetProgress];
            }
        }];
    }else if ([[KKPubTagVCModel shareToolGetManager].ossProvider isEqualToString:@"aws_s3"]){
        // 调用上传
        self.awsModel = [[KKUploadAwsModel alloc]init];
        [self.awsModel AwsWithUpload:authorizaModel videoInfo:videInfoModel callBack:^(CGFloat Progress, KKUploadState state, BOOL isGetProgress) {
            // 代理传送至控制层进行显示
            if ([self.delegate respondsToSelector:@selector(currentUploadProgress:uploadState:isGetProgress:)]) {
                [self.delegate currentUploadProgress:Progress uploadState:state isGetProgress:isGetProgress];
            }
        }];
    }else{
        [SVProgressHUD showMessage:@"未找到上传平台"];
    }
    
    
//    [self.awsModel AwsWithUpload:authorizaModel videoInfo:videInfoModel callBack:^(CGFloat Progress, KKUploadState state, BOOL isGetProgress) {
//        // 代理传送至控制层进行显示
//        if ([self.delegate respondsToSelector:@selector(currentUploadProgress:uploadState:isGetProgress:)]) {
//            [self.delegate currentUploadProgress:Progress uploadState:state isGetProgress:isGetProgress];
//        }
//    }];
}

/// 取消上传
-(void)cancelUpload:(BOOL)isNofiService{
    // 取消所有的请求
    //[self.awsModel cancelUpload];
    // 取消请求
    [KKPublicUploadingModel cancelRequest];
    
    // 退出上传
    if (self.ossModel) {
        [self.ossModel cancelUpload:isNofiService];
    }
    
    if (self.awsModel) {
        [self.awsModel cancelUpload:isNofiService];
    }
    
    // 当前是否是取消
    self.isCancel = YES;
}
@end

