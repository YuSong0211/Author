#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiLive.pbobjc.h"
#import "ExchangeBasic.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeLiveUserApigetLiveAudienceInfoGetLiveAudienceInfoRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeLiveUserApigetLiveAudienceInfoGetLiveAudienceInfoRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeGetLiveAudienceInfoRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeGetLiveUserInfoResponse*  respose;


@end

NS_ASSUME_NONNULL_END