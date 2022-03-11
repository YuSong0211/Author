#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "UcPrimaryApiSign.pbobjc.h"
#import "UcAccount.pbobjc.h"
#import "UcSms.pbobjc.h"
#import "UcBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceucSignInApitelephoneTelephoneSignInRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceucSignInApitelephoneTelephoneSignInRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceucTelephoneSignInRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceucAccountAccessResponse*  respose;


@end

NS_ASSUME_NONNULL_END