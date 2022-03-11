#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvH5ApiPaid.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvVip.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiPaidApilistWalletRechargeProductsListWalletRechargeProductsRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiPaidApilistWalletRechargeProductsListWalletRechargeProductsRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiListWalletRechargeProductsRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiListWalletRechargeProductsResponse*  respose;


@end

NS_ASSUME_NONNULL_END