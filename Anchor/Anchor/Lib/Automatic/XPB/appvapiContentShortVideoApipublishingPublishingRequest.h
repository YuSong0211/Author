#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiContent.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvOss.pbobjc.h"
#import "AppvPrimaryBasic.pbobjc.h"
#import "AppvPrimaryContent.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiContentShortVideoApipublishingPublishingRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiContentShortVideoApipublishingPublishingRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiPublishingRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiOssEvents*  respose;


@end

NS_ASSUME_NONNULL_END