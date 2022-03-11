#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiPay.pbobjc.h"
#import "UcBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucPaymentAppleApiverifyReceiptPaymentAppleVerifyReceiptRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucPaymentAppleApiverifyReceiptPaymentAppleVerifyReceiptRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucPaymentAppleVerifyReceiptRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucPaymentAppleVerifyReceiptResponse*  respose;


@end

NS_ASSUME_NONNULL_END