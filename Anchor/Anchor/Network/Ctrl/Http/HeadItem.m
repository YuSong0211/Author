//
//  HeadItem.m
//  KK
//
//  Created by hk on 2021/8/3.
//

#import "HeadItem.h"

@implementation HeadItem
    
    
//head item 头
- (HeadItem *)initWithDataKey:(NSString *)key value:(NSString *)value type:(HeadType)type{
    self.headType = type;
    self.key = key;
    self.value = value;
    return self;
}

@end
