//
//  KKPublicUploadSuccessModel.m
//  KK
//
//  Created by 小草 on 2021/7/29.
//

#import "KKPublicUploadSuccessModel.h"

@implementation KKPublicUploadSuccessModel


+(void)uploadSuccessToServiceWithInfo:(NSString *)batchId
                              eventId:(NSString *)eventId
                             isFinish:(BOOL)isFinish
                               status:(appvapiCallbackEvent_Status)status
                           completion:(nullable void(^)(BOOL finish))completion{
    // 上传后将所需的参数通知服务端
    appvapiOssApiuploadCallbackCallbackMessageReq * publishedParam = [appvapiOssApiuploadCallbackCallbackMessageReq createRequest];
    publishedParam.request.batchId.id_p = batchId;
    publishedParam.request.event.eventId.id_p = eventId;
    publishedParam.request.event.status = status;
    // [publishedParam.request setHasEvent:YES];
    // [publishedParam.request setHasBatchId:YES];
    publishedParam.request.event.status = isFinish; // YES 为上传成功  NO 取消上传
    // 通知服务上传成功
    [[NetWorkMgr createMgrWithMessage:publishedParam]sendRequest:^(appvapiUploadCallbackResp * message) {
        completion(message.success);
    } failed:^(requestErrorCode errorCode) {
        completion(NO);
    }];
}

@end
