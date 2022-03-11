//
//  EventCollec.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "EventList.h"
NS_ASSUME_NONNULL_BEGIN

@interface EventCollec : NSObject

/**
 构造
 */
+(EventCollec*)initWithTypes:(EventType)eventType;
    
//子事件类型
@property (nonatomic,assign) EventType eventType;

//事件集合
@property(nonatomic,strong) EventList* eventItem;

@end

NS_ASSUME_NONNULL_END
