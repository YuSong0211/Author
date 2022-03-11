#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiSearch.pbobjc.h"
#import "AppvBasic.pbobjc.h"
#import "AppvPrimaryCommunity.pbobjc.h"
#import "AppvPrimaryContent.pbobjc.h"
#import "AppvUser.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiSearchApisearchUserSearchUserRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiSearchApisearchUserSearchUserRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiSearchUserRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiSearchUserResponse*  respose;


@end

NS_ASSUME_NONNULL_END