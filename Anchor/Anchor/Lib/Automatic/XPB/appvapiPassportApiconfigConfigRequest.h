#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiPassport.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"
#import "AppvUser.pbobjc.h"
#import "AppvVip.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiPassportApiconfigConfigRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiPassportApiconfigConfigRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiConfigRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiConfigResponse*  respose;


@end

NS_ASSUME_NONNULL_END