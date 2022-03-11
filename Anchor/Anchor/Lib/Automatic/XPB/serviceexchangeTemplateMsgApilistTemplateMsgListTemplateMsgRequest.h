#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiTemplateMsg.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeTemplateMsgApilistTemplateMsgListTemplateMsgRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeTemplateMsgApilistTemplateMsgListTemplateMsgRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeListTemplateMsgRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeListTemplateMsgResponse*  respose;


@end

NS_ASSUME_NONNULL_END