#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiUser.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvOss.pbobjc.h"
#import "AppvUser.pbobjc.h"
#import "UtilBasic.pbobjc.h"
#import "AppvVip.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiUserInviteApireceiveInviteReceiveInviteRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiUserInviteApireceiveInviteReceiveInviteRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiReceiveInviteRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiEmptyResponse*  respose;


@end

NS_ASSUME_NONNULL_END