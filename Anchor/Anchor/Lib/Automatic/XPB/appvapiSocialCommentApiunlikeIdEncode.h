#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiSocial.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvComment.pbobjc.h"
#import "AppvPrimaryBasic.pbobjc.h"
#import "AppvUser.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiSocialCommentApiunlikeIdEncode : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiSocialCommentApiunlikeIdEncode*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiIdEncode*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiEmptyResponse*  respose;


@end

NS_ASSUME_NONNULL_END