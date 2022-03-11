//
//  EventList.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "EventModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EventList : NSObject

//存放所有事件
@property (nonatomic,strong) NSMutableArray<EventModel*>* eventList;

//子事件ID
@property (nonatomic,assign) NSInteger eventId;

//添加事件
-(EventModel*)addEvent:(EventCallBack)callback;

//移除事件
-(void)removeEvent:(NSInteger)eventId;

//获取某一个事件
-(EventModel*)getChild:(NSInteger)eventId;
 
@end

NS_ASSUME_NONNULL_END
