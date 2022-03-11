#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "AppvPrimaryApiAd.pbobjc.h"
#import "AppvBasic.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface appvapiAdvertisementStatisticsApirecordAdvertisementRecordAdvertisementRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(appvapiAdvertisementStatisticsApirecordAdvertisementRecordAdvertisementRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) appvapiRecordAdvertisementRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) appvapiEmptyResponse*  respose;


@end

NS_ASSUME_NONNULL_END