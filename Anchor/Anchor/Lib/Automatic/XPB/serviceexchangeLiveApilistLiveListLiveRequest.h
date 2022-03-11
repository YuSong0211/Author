#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiLive.pbobjc.h"
#import "ExchangeBasic.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeLiveApilistLiveListLiveRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeLiveApilistLiveListLiveRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeListLiveRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeListLiveResponse*  respose;


@end

NS_ASSUME_NONNULL_END