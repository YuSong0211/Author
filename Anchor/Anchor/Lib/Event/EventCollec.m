//
//  EventCollec.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "EventCollec.h"

@implementation EventCollec

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventType = none;
        self.eventItem = [[EventList alloc] init];
    }
    return self;
}


+ (EventCollec *)initWithTypes:(EventType)eventType{
    EventCollec* collec = [[EventCollec alloc] init];
    collec.eventType = eventType;
    return collec;
}

@end
