//
//  KKPublicUploadingModel.m
//  KK
//
//  Created by 小草 on 2021/8/6.
//

#import "KKPublicUploadingModel.h"
#import "appvapiContentShortVideoApipublishingPublishingRequest.h" // 上传前调用
#import "NSString+Extension.h"
#import "KKPubTagVCModel.h"
#import "AvExtraBean.h"

@implementation KKPublicUploadingModel

/// 上传前通知服务端，保存视频基本信息
/// @param videoInfo 视频基本信息
/// @param completion  上传文件的鉴权信息
+(void)uploadingToServiseModel:(KKUploadInfoModel *)videoInfo completion:(void (^)(KKUploadAuthenticationModel * _Nonnull))completion{
    NSMutableArray<appvapiIdEncode*> *idVsArray = [[NSMutableArray alloc]init];
    for (KKPubTagVCDataModel *selectDataModel in videoInfo.tags) {
        appvapiIdEncode * ids = [[appvapiIdEncode alloc]init];
        ids.id_p = selectDataModel.id_p;
//        ids.tagName = selectDataModel.title;
        [idVsArray addObject:ids];
    }
    
    // 初始化参数
    appvapiContentShortVideoApipublishingPublishingRequest * publishingParam = [appvapiContentShortVideoApipublishingPublishingRequest createRequest];
    
    publishingParam.request.title = [NSString htmlEncode:videoInfo.userTitle]; // 用户输入的标题
    publishingParam.request.tagIdsArray = idVsArray; // 用户选择标签 为空暂不处理，正常传输
    
    for (UploadOSSDataModel * uploadModel in videoInfo.soucreArray) {
        if (uploadModel.isImage == YES) {
            if (uploadModel.isFirstImage == YES) {
                publishingParam.request.firstFrameFile.URL = uploadModel.objectName; // 图片名称
                publishingParam.request.firstFrameFile.aspectRatio = uploadModel.videoOrCoverWidthHeight;
                publishingParam.request.firstFrameFile.fileByteSize = uploadModel.videoSize;
            }else{
                publishingParam.request.coverFile.URL = uploadModel.objectName; // 图片名称
                publishingParam.request.coverFile.aspectRatio = uploadModel.videoOrCoverWidthHeight;
                publishingParam.request.coverFile.fileByteSize = uploadModel.videoSize;
            }
        }else{
//            publishingParam.request.videoFile.URL = uploadModel.objectName; // 视频名称
//            publishingParam.request.videoFile.aspectRatio = uploadModel.videoOrCoverWidthHeight;
//            publishingParam.request.videoFile.fileByteSize = uploadModel.videoSize; // 视频大小
//            
//            NSURL * videoUrl = [NSURL fileURLWithPath:uploadModel.videoFilePath];
//            AVURLAsset * asset = [AVURLAsset assetWithURL:videoUrl];
//            NSInteger second = 0;
//            second = asset.duration.value / asset.duration.timescale; // 获取视频总时长,单位秒
//            NSMutableArray * beanArray = [AvExtraBean createArrayExtraWithData:2 data:[NSString stringWithFormat:@"%ld",second]];
//            NSMutableArray * beanDataArray = [[NSMutableArray alloc]init];
//            
//            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//            for (AvExtraBean * model in beanArray) {
//                [beanDataArray addObject:[model modelToJSONObject]];
//            }
//            [dic setValue:beanDataArray forKey:@"data"];
//            publishingParam.request.videoFile.extra = [KKTool convertToJsonData:[dic objectForKey:@"data"]];
        }
    }
    // 初始化鉴权信息
    KKUploadAuthenticationModel * authentication = [[KKUploadAuthenticationModel alloc]init];
    // 上传前进行请求，后端保存封面与视频信息
    [[NetWorkMgr createMgrWithMessage:publishingParam] sendRequest:^(appvapiOssEvents * message) {
        authentication.accessKey = message.ossToken.accessKey; // 临时-access-key
        authentication.secretKey = message.ossToken.secretKey; // 临时-secret-key
        authentication.sessionToken = message.ossToken.sessionToken; // 临时会话token
        authentication.expiration = message.ossToken.expiration; // 会话过期的时间点（毫秒时间戳）
        authentication.batchId = message.batchId.id_p; // 本次上传的批次
        authentication.fileEventsArray = message.fileEventsArray; // 上传的所有文件信息
        // 回调
        completion(authentication);
    } failed:^(requestErrorCode errorCode) {
        if (errorCode == ForbiddenWords) {
            authentication.isForbiddenWords = YES;
            completion(authentication);
        }else{
            completion(nil);
        }
    }];
}


/// 取消请求
+(void)cancelRequest{
    appvapiContentShortVideoApipublishingPublishingRequest * publishingParam = [appvapiContentShortVideoApipublishingPublishingRequest createRequest];
    
    [NetWorkMgr cancelRequestWithUrlStr:@"appvapi.ContentShortVideoApi/publishing"];
}
@end
