#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiRecaptcha.pbobjc.h"
#import "UcBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucReCaptchaApivalidCaptchaCaptchaValid : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucReCaptchaApivalidCaptchaCaptchaValid*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucCaptchaValid*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucReCaptchaValidResponse*  respose;


@end

NS_ASSUME_NONNULL_END