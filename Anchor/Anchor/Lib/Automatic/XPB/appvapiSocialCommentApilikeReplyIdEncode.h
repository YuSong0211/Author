#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiSocial.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvComment.pbobjc.h"
#import "AppvPrimaryBasic.pbobjc.h"
#import "AppvUser.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiSocialCommentApilikeReplyIdEncode : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiSocialCommentApilikeReplyIdEncode*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiIdEncode*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiIdEncode*  respose;


@end

NS_ASSUME_NONNULL_END