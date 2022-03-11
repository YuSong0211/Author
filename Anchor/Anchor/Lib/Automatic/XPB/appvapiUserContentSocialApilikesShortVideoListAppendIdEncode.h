#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiContent.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvOss.pbobjc.h"
#import "AppvPrimaryBasic.pbobjc.h"
#import "AppvPrimaryContent.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiUserContentSocialApilikesShortVideoListAppendIdEncode : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiUserContentSocialApilikesShortVideoListAppendIdEncode*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiAppendIdEncode*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiLikesShortVideoListResponse*  respose;


@end

NS_ASSUME_NONNULL_END