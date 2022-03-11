#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiResms.pbobjc.h"
#import "UcAccount.pbobjc.h"
#import "UcBasic.pbobjc.h"
#import "UcSms.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucReSmsApicheckVerificationCodeSmsValid : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucReSmsApicheckVerificationCodeSmsValid*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucSmsValid*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucEmptyResponse*  respose;


@end

NS_ASSUME_NONNULL_END