#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiPay.pbobjc.h"
#import "UcBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucPaymentDirectorApilistSupportTypeListSupportTypeRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucPaymentDirectorApilistSupportTypeListSupportTypeRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucListSupportTypeRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucListSupportTypeResponse*  respose;


@end

NS_ASSUME_NONNULL_END