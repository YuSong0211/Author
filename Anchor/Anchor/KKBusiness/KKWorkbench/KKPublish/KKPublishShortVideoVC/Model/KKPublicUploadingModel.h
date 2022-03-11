//
//  KKPublicUploadingModel.h
//  KK
//
//  Created by 小草 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "appvPrimaryApiContent.pbobjc.h"
#import "KKUploadInfoModel.h" // 视频信息model
#import "KKUploadAuthenticationModel.h" // 视频鉴权信息
NS_ASSUME_NONNULL_BEGIN

@interface KKPublicUploadingModel : NSObject


/// 上传前通知服务端，保存视频基本信息
/// @param videoInfo 视频基本信息
/// @param completion  上传文件的鉴权信息
+(void)uploadingToServiseModel:(KKUploadInfoModel *)videoInfo
                    completion:(nullable void(^)(KKUploadAuthenticationModel * authenticatioResult))completion;




/// 取消请求
+(void)cancelRequest;

@end

NS_ASSUME_NONNULL_END
