#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiPay.pbobjc.h"
#import "UcBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucPaymentMyh5ApicreatePrepayPaymentMyh5CreatePrepayRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucPaymentMyh5CreatePrepayRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucPaymentMyh5CreatePrepayResponse*  respose;


@end

NS_ASSUME_NONNULL_END