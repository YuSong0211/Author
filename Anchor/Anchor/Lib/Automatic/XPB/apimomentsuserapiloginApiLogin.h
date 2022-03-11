#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "Moments.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface apimomentsuserapiloginApiLogin : GProtoBufferMessage

    //创建pb对象,构建数据
    +(apimomentsuserapiloginApiLogin*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) apimomentsApiLogin*  request;

    //定义pb返回结构
    @property(strong,nonatomic) apimomentsEmptyResponse*  respose;


@end

NS_ASSUME_NONNULL_END