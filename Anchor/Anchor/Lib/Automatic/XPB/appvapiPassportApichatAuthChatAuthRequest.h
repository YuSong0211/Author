#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiPassport.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvPrimaryTag.pbobjc.h"
#import "AppvUser.pbobjc.h"
#import "AppvVip.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiPassportApichatAuthChatAuthRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiPassportApichatAuthChatAuthRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiChatAuthRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiChatAuthResponse*  respose;


@end

NS_ASSUME_NONNULL_END