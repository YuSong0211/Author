//
//  GProtoBufferMessage.h
//  KK
//
//  Created by hk on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import "GPBBootstrap.h"
NS_ASSUME_NONNULL_BEGIN

@interface GProtoBufferMessage : NSObject
    
    //service api 接口名称
    @property(strong,nonatomic) NSString*  apiName;
    //pb 请求实例
    @property(strong,nonatomic) GPBMessage* pb_request;
    //pb返回实例
    @property(strong,nonatomic) GPBMessage* pb_respose;
    //grpc 包名
    @property(strong,nonatomic) NSString*  packageName;

    //定义请求头head，消息自定义head
    @property(strong,nonatomic)NSMutableDictionary* requestHeads;

    //服务器返回的head
    @property(strong,nonatomic)NSMutableDictionary* resposeHeads;

@end

NS_ASSUME_NONNULL_END
