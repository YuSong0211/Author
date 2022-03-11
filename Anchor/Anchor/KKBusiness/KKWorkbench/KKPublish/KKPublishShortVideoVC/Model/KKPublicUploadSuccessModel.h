//
//  KKPublicUploadSuccessModel.h
//  KK
//
//  Created by 小草 on 2021/7/29.
//

#import <Foundation/Foundation.h>
#import "appvPrimaryApiContent.pbobjc.h"
#import "appvapiOssApiuploadCallbackCallbackMessageReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKPublicUploadSuccessModel : NSObject

/// 上传成功后通知服务端 取消上传时通知服务端
/// @param batchId 当前上传任务id
/// @param eventId 事件id 图片或 视频id
+(void)uploadSuccessToServiceWithInfo:(NSString *)batchId
                              eventId:(NSString *)eventId
                             isFinish:(BOOL)isFinish
                               status:(appvapiCallbackEvent_Status)status
                           completion:(nullable void(^)(BOOL finish))completion;
@end

NS_ASSUME_NONNULL_END
