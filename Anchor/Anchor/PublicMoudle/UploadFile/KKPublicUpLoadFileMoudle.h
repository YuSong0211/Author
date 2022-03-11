//
//  KKPublicUpLoadFileMoudle.h
//  KK
//
//  Created by 小草 on 2021/7/28.
//

#import <Foundation/Foundation.h>
#import "KKUploadInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKPublicUpLoadFileMoudle : NSObject

/// 传入需要上传的数据，开始上传。
/// @param infoModel 有图片 和 视频 两种类型
-(instancetype)initWithInfoModel:(KKUploadInfoModel *)infoModel;

// 开始上传
-(void)startUpload;

/// 调用退出上传 infoModel会返回 UploadStateUploadCancel
-(void)cancelUpload;
@end

NS_ASSUME_NONNULL_END
