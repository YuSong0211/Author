//
//  EventModel.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//回调bloack
typedef void(^EventCallBack)(id message);

typedef enum {
    none,
    follow, //关注事件
    event_im_newmessage,
    service_handler,
    eve_collec,
    eve_like,
    eve_comment,
    eve_application_comeactive, //程序进入后台入口事件
    
}EventType;

@interface EventModel : NSObject

//初始化
+(EventModel*)initWithParam:(NSInteger)eventId
                           :(EventCallBack)eventCall;

//子事件ID
@property (nonatomic,assign) NSInteger eventId;

//boack 回调
@property (nonatomic,strong)EventCallBack eventCall;

@end

NS_ASSUME_NONNULL_END
