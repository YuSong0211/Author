#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiCustomer.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvCustomer.pbobjc.h"
#import "AppvOss.pbobjc.h"
#import "AppvUser.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiWorkOrderApilistMyWorkOrderIdEncode : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiWorkOrderApilistMyWorkOrderIdEncode*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiIdEncode*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiListMyWorkOrderResponse*  respose;


@end

NS_ASSUME_NONNULL_END