//
//  EventCtrl.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "EventCtrl.h"

static EventCtrl* instance;
@implementation EventCtrl
    
+ (EventCtrl *)getInstance{
    if(instance == NULL){
        instance = [[EventCtrl alloc] init];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (EventModel *)addEvent:(EventType)eventType :(EventCallBack)callback{
    EventCollec* collec = [self getItemList:eventType];
    if(collec==nil){
        collec = [EventCollec initWithTypes:eventType];
    }
    EventModel*result = [collec.eventItem addEvent:callback];
    [self.eventList addObject:collec];
    return result;
}

- (void)removeEvent:(EventType)eventType{
    [self removeEvent:eventType];
}


- (void)removeEvent:(EventType)eventType :(EventModel *)eventModel{
    EventCollec* collec = [self getItemList:eventType];
    if(collec!=nil){
        [collec.eventItem removeEvent:eventModel.eventId];
    }
}

- (void)sendEvent:(EventType)eventType :(id)param{
    EventCollec* collec = [self getItemList:eventType];
    if(collec==nil){
        return;
    }
    for(EventModel* model in collec.eventItem.eventList){
        model.eventCall(param);
    }
}

- (void)sendEvent:(EventType)eventType :(NSInteger)eventId :(id)param{
    EventCollec* collec = [self getItemList:eventType];
    if(collec==nil){
        return;
    }
    for(EventModel* model in collec.eventItem.eventList){
        if(model.eventId == eventId){
            model.eventCall(param);
        }
    }
}

- (void)clear{
    [self.eventList removeAllObjects];
}

    
//获取事件集合
-(EventCollec*) getItemList:(EventType)eventType{
    for(EventCollec* collec in self.eventList){
        if(collec.eventType == eventType){
            return collec;
        }
    }
    return nil;
}

//移除事件
-(void)removeItem:(EventType)eventType{
    for(EventCollec* collec in self.eventList){
        if(collec.eventType == eventType){
            [self.eventList removeObject:collec];
            break;
        }
    }
}

@end
