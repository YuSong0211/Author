#import <Foundation/Foundation.h>
#import "GProtoBufferMessage.h"
#import "ExchangePrimaryApiAnnouncement.pbobjc.h"
#import "UtilBasicIdentity.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface serviceexchangeAnnouncementApilistAnnouncementListAnnouncementRequest : GProtoBufferMessage

    //创建pb对象,构建数据
    +(serviceexchangeAnnouncementApilistAnnouncementListAnnouncementRequest*)createRequest;

    //定义pb请求结构
    @property(strong,nonatomic) serviceexchangeListAnnouncementRequest*  request;

    //定义pb返回结构
    @property(strong,nonatomic) serviceexchangeListAnnouncementResponse*  respose;


@end

NS_ASSUME_NONNULL_END