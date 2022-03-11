//
//  KKModelBase.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKModelBase.h"

@implementation KKModelBase
+ (NSDictionary *)modelCustomPropertyMapper {
   // 将personId映射到key为id的数据字段
    return @{@"ID":@"id",@"video_url":@"videoURL"};
   //  return @{@"personId":@[@"id",@"uid",@"ID"]};
}
@end
