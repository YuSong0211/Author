#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiClients.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucClientsApiuuidUuidRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucClientsApiuuidUuidRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucUuidRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucUuidResponse*  respose;


@end

NS_ASSUME_NONNULL_END