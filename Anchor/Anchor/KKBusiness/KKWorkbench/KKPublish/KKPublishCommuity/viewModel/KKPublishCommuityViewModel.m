//
//  KKPublishCommuityViewModel.m
//  mt
//
//  Created by 小草 on 2021/11/8.
//

#import "KKPublishCommuityViewModel.h"
#import "KKUploadAuthenticationModel.h" // S3 鉴权信息
#import "KKUploadOssModel.h" // S3 上传工具类
#import "AvExtraBean.h"
#import "UIImage+Extension.h"
#import "KKUploadModel.h"
#import <AVFoundation/AVFoundation.h>
@interface KKPublishCommuityViewModel ()<KKPubLishVideoDataDelegate>

// 当前请求状态
@property (nonatomic,assign) KKUploadState networkType;

// S3 工具类
@property (nonatomic,strong) KKUploadOssModel * ossModel;

@property (nonatomic,strong) KKUploadModel * uploadTool; // 上传工具类

@end


@implementation KKPublishCommuityViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

/// 单文本上传
/// @param singleText 需要发布的文字
/// @param tagArray 标签数据
-(void)singleTextToUpload:(NSString *)singleText
                 tagArray:(NSMutableArray *)tagArray{
    
    
    // 创建请求实体
    appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest * req = [appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest createRequest];
    req.request.content = singleText;
    req.request.tagIdsArray = tagArray;
    
    // 发送请求
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiIdEncode *  _Nonnull message) {
        // 成功,代理传送至控制器
        if ([self.delegate respondsToSelector:@selector(singleTextUploadComplte:)]) {
            [self.delegate singleTextUploadComplte:KKUploadStateUploadComplete];
        }
    } failed:^(requestErrorCode errorCode) {
        if (errorCode == ForbiddenWords) {
            // 失败,代理传送至控制器
            if ([self.delegate respondsToSelector:@selector(singleTextUploadComplte:)]) {
                [self.delegate singleTextUploadComplte:KKUploadStateUploadForbiddenWords];
            }
        }else{
             // 失败,代理传送至控制器
            if ([self.delegate respondsToSelector:@selector(singleTextUploadComplte:)]) {
                [self.delegate singleTextUploadComplte:KKUploadStateUploadFailed];
            }
        }
    }];
}

/// 媒体资源上传
/// @param content 文本
/// @param tagArray 标签数据
/// @param fileModel 文件model
-(void)mediaSourceUploadWithText:(NSString *)content
                        tagArray:(NSMutableArray *)tagArray
                       fileModel:(KKUploadInfoModel *)fileModel{
    
    appvapiContentCommunityApipublishingCommunityPostMediaPublishingCommunityPostMediaRequest * req = [appvapiContentCommunityApipublishingCommunityPostMediaPublishingCommunityPostMediaRequest createRequest];
    req.request.content = [NSString htmlEncode:content];
    req.request.tagIdsArray = tagArray;
    
    if (fileModel.isImage == YES) {
        NSMutableArray * fileArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<fileModel.soucreArray.count; i++) {
            UploadOSSDataModel * file = fileModel.soucreArray[i];
            if (file.isThumbImage == NO) {
                appvapiCommunityPostPicture * postPicture = [[appvapiCommunityPostPicture alloc]init];
                /** 帖子原图 */
                appvapiMIMEInfo *picture = [[appvapiMIMEInfo alloc]init];
                /** 帖子缩略图 */
                appvapiMIMEInfo *pictureThumbnail = [[appvapiMIMEInfo alloc]init];
                // 原图
                picture.URL = file.objectName;
                NSData*data = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(file.image, videoCoverZip)];
                picture.fileByteSize = data.length;
                picture.aspectRatio = [NSString stringWithFormat:@"%.0f:%.0f",file.image.size.width,file.image.size.height];
                
                // 缩略图
                UploadOSSDataModel * pictureThumbnailModel = fileModel.soucreArray[i+1];
                pictureThumbnail.URL = pictureThumbnailModel.objectName;
                NSData*pictureThumbnaildata = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(pictureThumbnailModel.image, thumbnailCoverZip)];
                pictureThumbnail.fileByteSize = pictureThumbnaildata.length;
                pictureThumbnail.aspectRatio = [NSString stringWithFormat:@"%.0f:%.0f",pictureThumbnailModel.image.size.width,pictureThumbnailModel.image.size.height];
                // 原图对象
                postPicture.picture = picture;
                // 缩略图对象
                postPicture.pictureThumbnail = pictureThumbnail;
                [fileArray addObject:postPicture];
            }
        }

        // 向服务端，保存当前帖子信息
        req.request.publishingCommunityPostMedia.publishingCommunityPostPicture.resourcesArray = fileArray;
        
    }else{
        // 视频
        for (UploadOSSDataModel * uploadModel in fileModel.soucreArray) {
            if (uploadModel.isImage == YES) {
                /** 媒体文件地址 */
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.coverFile.URL = uploadModel.objectName;
                NSData*data = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(uploadModel.image, videoCoverZip)];
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.coverFile.fileByteSize = data.length;
                /** 媒体宽高比 */
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.coverFile.aspectRatio = [NSString stringWithFormat:@"%.0f:%.0f",uploadModel.image.size.width,uploadModel.image.size.height];
                /** 媒体宽高比 */
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.resources.aspectRatio = [NSString stringWithFormat:@"%.0f:%.0f",uploadModel.image.size.width,uploadModel.image.size.height];
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.resources.fileByteSize = data.length;
            }else{
                /** 媒体文件地址 */
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.resources.URL = uploadModel.objectName;
                NSData * videoData = [richers encodeMedia:EncodeType_Video src:[NSData dataWithContentsOfFile:uploadModel.videoFilePath]];
                /** 文件大小 */
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.resources.fileByteSize = [videoData length];
                
                NSURL * videoUrl = [NSURL fileURLWithPath:uploadModel.videoFilePath];
                AVURLAsset * asset = [AVURLAsset assetWithURL:videoUrl];
                NSInteger second = 0;
                second = asset.duration.value / asset.duration.timescale; // 获取视频总时长,单位秒
                NSMutableArray * beanArray = [AvExtraBean createArrayExtraWithData:2 data:[NSString stringWithFormat:@"%ld",second]];
                NSMutableArray * beanDataArray = [[NSMutableArray alloc]init];
                
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                for (AvExtraBean * model in beanArray) {
                    [beanDataArray addObject:[model modelToJSONObject]];
                }
                [dic setValue:beanDataArray forKey:@"data"];
                req.request.publishingCommunityPostMedia.publishingCommunityPostVideo.resources.extra = [KKTool convertToJsonData:[dic objectForKey:@"data"]];
            }
        }
    }

    [self mediaUpload:req fileModel:fileModel];
}

/// 社区文件上传
/// @param req 请求实体
-(void)mediaUpload:(id)req fileModel:(KKUploadInfoModel *)fileModel{
    // 发送请求
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiOssEvents *  _Nonnull message) {
        // 初始化鉴权信息
        KKUploadAuthenticationModel * authentication = [[KKUploadAuthenticationModel alloc]init];
        
        authentication.accessKey = message.ossToken.accessKey; // 临时-access-key
        authentication.secretKey = message.ossToken.secretKey; // 临时-secret-key
        authentication.sessionToken = message.ossToken.sessionToken; // 临时会话token
        authentication.expiration = message.ossToken.expiration; // 会话过期的时间点（毫秒时间戳）
        authentication.batchId = message.batchId.id_p; // 本次上传的批次
        authentication.fileEventsArray = message.fileEventsArray; // 上传的所有文件信息
        
        // 调用上传文件
        self.uploadTool = [[KKUploadModel alloc]init];
        self.uploadTool.delegate = self;
        [self.uploadTool startUploadWithAuthorizaModel:authentication videoInfoModel:fileModel];
//        // 调用上传
//        self.ossModel = [[KKUploadOssModel alloc]init];
//        WS
//        [self.ossModel OssWithUpload:authentication videoInfo:fileModel callBack:^(CGFloat Progress, KKUploadState state, BOOL isGetProgress) {
//            SS
//            // 代理传送显示层
//            if ([self.delegate respondsToSelector:@selector(mediaSourceUploadComplte:progress:isGetProgress:uploadModel:)]) {
//                [self.delegate mediaSourceUploadComplte:state progress:Progress isGetProgress:isGetProgress uploadModel:fileModel];
//            }
//        }];
    } failed:^(requestErrorCode errorCode) {
        if (errorCode == ForbiddenWords) {
            if ([self.delegate respondsToSelector:@selector(mediaSourceUploadComplte:progress:isGetProgress:uploadModel:)]) {
                [self.delegate mediaSourceUploadComplte:KKUploadStateUploadForbiddenWords progress:0 isGetProgress:NO uploadModel:fileModel];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(mediaSourceUploadComplte:progress:isGetProgress:uploadModel:)]) {
                [self.delegate mediaSourceUploadComplte:KKUploadStateUploadFailed progress:0 isGetProgress:NO uploadModel:fileModel];
            }
        }
    }];
}


// 当前上传进度
-(void)currentUploadProgress:(CGFloat)progress uploadState:(KKUploadState)state isGetProgress:(BOOL)isGetProgress{
    // 代理传送显示层
    if ([self.delegate respondsToSelector:@selector(mediaSourceUploadComplte:progress:isGetProgress:uploadModel:)]) {
        [self.delegate mediaSourceUploadComplte:state progress:progress isGetProgress:isGetProgress uploadModel:self.uploadTool.fileModel];
    }
}

-(void)commuityCancelUpload:(BOOL)isNofiService{
    [self.uploadTool cancelUpload:isNofiService];
}
@end
