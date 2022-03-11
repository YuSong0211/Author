#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiPassport.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"
#import "AppvUser.pbobjc.h"
#import "AppvVip.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiPassportApienterEnterRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiPassportApienterEnterRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiEnterRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiEnterResponse*  respose;


@end

NS_ASSUME_NONNULL_END