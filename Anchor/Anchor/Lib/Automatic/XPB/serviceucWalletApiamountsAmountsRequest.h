#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiWallet.pbobjc.h"
#import "UcWallet.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucWalletApiamountsAmountsRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucWalletApiamountsAmountsRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucAmountsRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucAmountsResponse*  respose;


@end

NS_ASSUME_NONNULL_END