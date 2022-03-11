#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiContentCommunity.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvOss.pbobjc.h"
#import "AppvPrimaryCommunity.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiContentCommunityApipublishingCommunityPostContentPublishingCommunityPostContentRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiPublishingCommunityPostContentRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiIdEncode*  respose;


@end

NS_ASSUME_NONNULL_END