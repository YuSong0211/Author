//
//  EventList.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "EventList.h"

@implementation EventList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventId = 1;
        self.eventList = [[NSMutableArray alloc] init];
    }
    return self;
}
    
- (EventModel *)addEvent:(EventCallBack)callback{
    @synchronized (self.eventList) {
        self.eventId +=1;
        EventModel* model = [EventModel initWithParam:self.eventId :callback];
        [self.eventList addObject:model];
        return model;
    }
}

- (void)removeEvent:(NSInteger)eventId{
    for(EventModel* model in self.eventList){
        if(model.eventId == eventId){
            [self.eventList removeObject:model];
            break;
        }
    }
}


- (EventModel *)getChild:(NSInteger)eventId{
    for(EventModel* model in self.eventList){
        if(model.eventId == eventId){
            return model;
        }
    }
    return nil;
}

@end
