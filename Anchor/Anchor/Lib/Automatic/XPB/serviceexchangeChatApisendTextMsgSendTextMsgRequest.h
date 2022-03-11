#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiChat.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeChatApisendTextMsgSendTextMsgRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeChatApisendTextMsgSendTextMsgRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeSendTextMsgRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeSendTextMsgResponse*  respose;


@end

NS_ASSUME_NONNULL_END