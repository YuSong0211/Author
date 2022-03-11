#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiRecaptcha.pbobjc.h"
#import "UcBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucReCaptchaApivalidAliyunReCaptchaValidAliyunRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucReCaptchaValidAliyunRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucReCaptchaValidResponse*  respose;


@end

NS_ASSUME_NONNULL_END