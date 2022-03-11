#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiTemplateMsg.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeTemplateMsgApireadTemplateReadTemplateRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeTemplateMsgApireadTemplateReadTemplateRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeReadTemplateRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeReadTemplateResponse*  respose;


@end

NS_ASSUME_NONNULL_END