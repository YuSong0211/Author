#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiLive.pbobjc.h"
#import "ExchangeBasic.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeLiveApilistLiveByTagListLiveByTagRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeLiveApilistLiveByTagListLiveByTagRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeListLiveByTagRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeListLiveByTagResponse*  respose;


@end

NS_ASSUME_NONNULL_END