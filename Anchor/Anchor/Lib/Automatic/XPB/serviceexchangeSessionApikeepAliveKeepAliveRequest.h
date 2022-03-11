#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiSession.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeSessionApikeepAliveKeepAliveRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeSessionApikeepAliveKeepAliveRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeKeepAliveRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeKeepAliveResponse*  respose;


@end

NS_ASSUME_NONNULL_END