#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiGroup.pbobjc.h"
#import "ExchangePrimaryMsg.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeGroupApilistChatGroupListChatGroupRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeGroupApilistChatGroupListChatGroupRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeListChatGroupRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeListChatGroupResponse*  respose;


@end

NS_ASSUME_NONNULL_END