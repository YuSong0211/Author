//
//  KKUploadAuthenticationModel.h
//  KK
//
//  Created by 小草 on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKUploadAuthenticationModel : NSObject

@property(nonatomic, strong) NSString * accessKey; // 临时-access-key

@property(nonatomic, strong) NSString * secretKey; // 临时-secret-key

@property(nonatomic, strong) NSString * sessionToken; // 临时会话token

@property(nonatomic, assign) UInt64 expiration; // 会话过期的时间点（毫秒时间戳）

@property(nonatomic, strong) NSString * batchId; // 本次上传的批次

@property(nonatomic, assign) BOOL hasCoverFileEvent; // 是否有封面文件事件

@property(nonatomic, assign) BOOL hasVideoFileEvent; // 是否有视频文件事件


// 视频封面及视频ID
@property(nonatomic, readwrite, strong) NSString * coverFileEventId; // 视频封面资源的上传事件的id

@property(nonatomic, readwrite, strong) NSString * coverFileBucketName; // 视频封面上传对象的桶信息

@property(nonatomic, readwrite, strong) NSString * coverFileObjectName; // 视频封面上传对象的信息

@property(nonatomic, readwrite, strong) NSString * firstCoverFileEventId; // 第一帧视频封面资源的上传事件的id

@property(nonatomic, readwrite, strong) NSString * firstCoverFileBucketName; // 第一帧视频封面上传对象的桶信息

@property(nonatomic, readwrite, strong) NSString * firstCoverFileObjectName; // 第一帧视频封面上传对象的信息


@property(nonatomic, readwrite, strong) NSString * videoFileEventId; // 视频资源的上传事件的id

@property(nonatomic, readwrite, strong) NSString * videoFileBucketName; // 视频上传对象的桶信息

@property(nonatomic, readwrite, strong) NSString * videoFileObjectName; // 视频上传对象的信息

@property(nonatomic,strong)NSMutableArray *fileEventsArray; // 所有上传事件的信息


@property (nonatomic,assign) BOOL isForbiddenWords; // 是否被禁言


@end

NS_ASSUME_NONNULL_END
