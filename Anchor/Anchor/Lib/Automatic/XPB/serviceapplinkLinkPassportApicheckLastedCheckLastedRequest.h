#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ApplinkPrimaryApiPassport.pbobjc.h"
#import "ApplinkVersion.pbobjc.h"
#import "ApplinkPrimaryNotice.pbobjc.h"
#import "ApplinkPrimaryAdvertisement.pbobjc.h"
#import "ApplinkPrimaryTime.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceapplinkLinkPassportApicheckLastedCheckLastedRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceapplinkLinkPassportApicheckLastedCheckLastedRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceapplinkCheckLastedRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceapplinkCheckLastedResponse*  respose;


@end

NS_ASSUME_NONNULL_END