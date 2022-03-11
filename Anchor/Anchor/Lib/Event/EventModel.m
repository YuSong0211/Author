//
//  EventModel.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "EventModel.h"

@implementation EventModel
    
+ (EventModel *)initWithParam:(NSInteger)eventId :(EventCallBack)eventCall{
    EventModel* model = [[EventModel alloc] init];
    model.eventId = eventId;
    model.eventCall = eventCall;
    return model;
}

@end
