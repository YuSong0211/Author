//
//  KKUploadInfoModel.h
//  KK
//
//  Created by 小草 on 2021/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class UploadOSSDataModel;

typedef NS_ENUM(NSUInteger, UploadState) {
    UploadStateUploading,    // 上传中
    UploadStateUploadFailed, // 上传失败
    UploadStateUploadComplete, // 上传完成
    UploadStateUploadCancel // 退出上传
};

// 上传进度回调
typedef void(^UploadStateBlock)(UploadState state, NSString * filePath);

// totalByteSent 已上传总长度
// totalBytesExpectedToSend 剩余上传总长度
// isVideo 是否是视频 视频才会计算长度
typedef void(^UploadProgressBlock)(int64_t totalByteSent,int64_t totalBytesExpectedToSend,BOOL isVideo);

@interface KKUploadInfoModel : NSObject

// 用户输入的标题
@property (nonatomic,strong) NSString * userTitle;

// 用户选择的tags标签
@property (nonatomic,strong) NSMutableArray * tags;

// 视频大小
@property (nonatomic,assign) UInt64 videoSize;

// 视频图片的宽高(宽:高)
@property (nonatomic,strong) NSString * videoOrCoverWidthHeight;

// 需要上传的图片二进制
@property (nonatomic,strong) NSData * imageData;

// 图片名称
@property (nonatomic,strong) NSString * imageName;

// 第一帧图片
@property (nonatomic,strong) NSData * firstImageData;

// 第一帧图片名称
@property (nonatomic,strong) NSString * firstImageName;

// 需要上传视频的地址
@property (nonatomic,strong) NSString * videoPath;

// 需要上传视频的名称
@property (nonatomic,strong) NSString * videoName;

@property (nonatomic,strong) UIImage * UploadImage;

@property (nonatomic,assign) BOOL isImage; // 是否是图片，S3中上传图片和视频所传的类型不一样

@property (nonatomic,assign) BOOL isAllImage; // 当前上传批次是否全是图片，如果包含视频，则以视频上传进度显示。

@property (nonatomic,strong) NSMutableArray <UploadOSSDataModel*>* soucreArray; // OSS数据源

// @@@@@@@@@@@@@@@@@@@@@@@@@@@ 上传状态

// 上传进度
@property (atomic, copy) UploadProgressBlock uploadProgressBlock;

// 上传状态
@property (atomic, copy) UploadStateBlock uploadStateBlock;

// 包含所有的文件名称
@property (nonatomic,strong) NSMutableArray * fileNameArray;


@end


@interface UploadOSSDataModel : NSObject

@property (nonatomic,assign) BOOL isImage; // 是否是图片

@property (nonatomic,strong) NSString * videoOrCoverWidthHeight;

@property (nonatomic,strong) UIImage * image; // 图片数据

@property (nonatomic,strong) UIImage * firstImage; // 首帧图片

@property (nonatomic,assign) BOOL isFirstImage;

@property (nonatomic,strong) NSString * objectName; // 文件名字

@property (nonatomic,strong) NSString * videoFilePath; // 视频文件路径

@property (nonatomic,assign) uint64_t videoSize;

@property (nonatomic,assign) BOOL isThumbImage; // 是否缩略图

@end

NS_ASSUME_NONNULL_END
