//
//  KKPublishShortVideoViewDelegate.h
//  KK
//
//  Created by 小草 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "KKUploadInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KKPublishShortVideoViewDelegate <NSObject>


/// 保存视频信息
/// @param videoInfo 视频信息model
-(void)saveThepublishVideoInfo:(KKUploadInfoModel *)videoInfo;

// 点击上传
-(void)clickCancelUpload:(BOOL)isNotiService;


@end

NS_ASSUME_NONNULL_END
