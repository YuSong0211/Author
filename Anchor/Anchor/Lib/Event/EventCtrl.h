//
//  EventCtrl.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "EventCollec.h"
NS_ASSUME_NONNULL_BEGIN

//列表事件分发
@interface EventCtrl : NSObject

//所有事件集合
@property (strong,nonatomic) NSMutableArray<EventCollec*>* eventList;

//单例
+(EventCtrl*)getInstance;

//添加事件
-(EventModel*)addEvent:(EventType)eventType
                      :(EventCallBack)callback;

//移除列表所有事件
-(void)removeEvent:(EventType)eventType;

//根据事件类型，model类型移除事件
-(void)removeEvent:(EventType)eventType
                  :(EventModel*)eventModel;

//发送事件
-(void)sendEvent:(EventType)eventType
                :(id)param;

//发送某个子事件
-(void)sendEvent:(EventType)eventType
                :(NSInteger)eventId
                :(id)param;

//清理事件
-(void)clear;

@end

NS_ASSUME_NONNULL_END
