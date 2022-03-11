//
//  KKPublishViewModel.h
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKModelBase.h"
#import "KKUploadInfoModel.h"
#import "KKPubLishVideoDataDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKUploadModel : KKModelBase

@property (nonatomic,weak) id<KKPubLishVideoDataDelegate>delegate;


/// 接受视频信息model后开始上传
/// @param videoInfo 视频信息model
-(void)publishBeginUploadingWithVideoInfo:(KKUploadInfoModel *)videoInfo;


/// 用户头像上传方法
/// @param info 包含用户头像的信息
-(void)avaterBeginUploadWithInfo:(KKUploadInfoModel *)avaterInfo;

// 开始上传视频图片和视频
// 私有方法，只在内部进行调用
// 外部访问 beginUploadingWithVideoInfo
-(void)startUploadWithAuthorizaModel:(KKUploadAuthenticationModel *)authorizaModel
                      videoInfoModel:(KKUploadInfoModel *)videInfoModel;

@property (nonatomic,strong) KKUploadInfoModel * fileModel;

/// 取消上传
-(void)cancelUpload:(BOOL)isNofiService;

@end

NS_ASSUME_NONNULL_END
