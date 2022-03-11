#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiOss.pbobjc.h"
#import "AppvBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiOssApiuploadCallbackCallbackMessageReq : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiOssApiuploadCallbackCallbackMessageReq*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiCallbackMessageReq*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiUploadCallbackResp*  respose;


@end

NS_ASSUME_NONNULL_END