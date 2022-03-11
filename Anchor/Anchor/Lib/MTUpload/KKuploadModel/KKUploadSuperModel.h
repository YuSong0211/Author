//
//  KKUploadSuperModel.h
//  KK
//
//  Created by 小草 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "KKUploadAuthenticationModel.h"
#import "KKUploadInfoModel.h"
#import "KKPublicUploadSuccessModel.h" // 上传成功回调
#import "AWSS3.h" // 上传框架 S3
#import "richers.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KKUploadState) {
    KKUploadStateUploading,    // 上传中
    KKUploadStateUploadFailed, // 上传失败
    KKUploadStateUploadComplete, // 上传完成
    KKUploadStateUploadCancel, // 退出上传
    KKUploadStateUploadForbiddenWords, // 被禁言
    kkUPLoadStatetextNil  //帖子内容为nin
};

typedef void (^UploadProgress)(CGFloat Progress,KKUploadState state,BOOL isGetProgress);


@interface KKUploadSuperModel : NSObject


/// 上传到S3
/// @param authenticationModel 鉴权信息model
/// @param videInfo 视频信息
/// @param status 当前进度 当前状态
-(void)AwsWithUpload:(KKUploadAuthenticationModel *)authenticationModel
           videoInfo:(KKUploadInfoModel *)videInfo
            callBack:(UploadProgress)status;

/// 上传到Oss
/// @param authenticationModel 鉴权信息model
/// @param videInfo 视频信息
/// @param status 当前进度 当前状态
-(void)OssWithUpload:(KKUploadAuthenticationModel *)authenticationModel
           videoInfo:(KKUploadInfoModel *)videInfo
            callBack:(UploadProgress)status;

/// 传入需要上传的数据，开始上传。
/// @param infoModel 有图片 和 视频 两种类型
-(void)initWithInfoModel:(KKUploadInfoModel *)infoModel;

/// 取消上传
/// @param isNofiService 默认手动取消需要通知服务端
-(void)cancelUpload:(BOOL)isNofiService;
@end

NS_ASSUME_NONNULL_END
