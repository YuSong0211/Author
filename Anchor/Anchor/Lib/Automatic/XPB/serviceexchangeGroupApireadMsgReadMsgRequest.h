#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiGroup.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeGroupApireadMsgReadMsgRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeGroupApireadMsgReadMsgRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeReadMsgRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeReadMsgResponse*  respose;


@end

NS_ASSUME_NONNULL_END