#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiPassport.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"
#import "AppvUser.pbobjc.h"
#import "AppvVip.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiPassportApigetNoticeEmptyRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiPassportApigetNoticeEmptyRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiEmptyRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiGetNoticeResponse*  respose;


@end

NS_ASSUME_NONNULL_END