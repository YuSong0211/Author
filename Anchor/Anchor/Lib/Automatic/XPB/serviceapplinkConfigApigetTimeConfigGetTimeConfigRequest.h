#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ApplinkPrimaryApiConfig.pbobjc.h"
#import "ApplinkPrimaryTime.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceapplinkGetTimeConfigRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceapplinkServerTime*  respose;


@end

NS_ASSUME_NONNULL_END