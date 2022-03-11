#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvH5ApiPaid.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvVip.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiPaidApiwalletRechargeWalletRechargeRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiPaidApiwalletRechargeWalletRechargeRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiWalletRechargeRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiWalletRechargeResponse*  respose;


@end

NS_ASSUME_NONNULL_END