//
//  AvExtraBean.m
//  lmtest
//
//  Created by hk on 2021/11/10.
//

#import "AvExtraBean.h"

@implementation AvExtraBean
+ (AvExtraBean *)createExtraWithData:(int)type data:(NSString *)data{
    AvExtraBean* bean = [[AvExtraBean alloc] init];
    bean.type = type;
    bean.data = data;
    return bean;
}

+ (NSMutableArray *)createArrayExtraWithData:(int)type data:(NSString *)data{
    AvExtraBean* bean = [AvExtraBean createExtraWithData:type data:data];
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObject:bean];
    return array;
}

@end
