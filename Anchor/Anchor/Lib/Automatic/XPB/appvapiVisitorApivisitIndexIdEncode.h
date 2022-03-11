#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiVisitor.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvPrimaryBasic.pbobjc.h"
#import "AppvPrimaryCommunity.pbobjc.h"
#import "AppvUser.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiVisitorApivisitIndexIdEncode : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiVisitorApivisitIndexIdEncode*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiIdEncode*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiVisitUserInfoResponse*  respose;


@end

NS_ASSUME_NONNULL_END