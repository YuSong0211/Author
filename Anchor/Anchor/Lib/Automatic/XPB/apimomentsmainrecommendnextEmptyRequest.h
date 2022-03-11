#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "Moments.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface apimomentsmainrecommendnextEmptyRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(apimomentsmainrecommendnextEmptyRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) apimomentsEmptyRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) apimomentsPublishRespose*  respose;


@end

NS_ASSUME_NONNULL_END