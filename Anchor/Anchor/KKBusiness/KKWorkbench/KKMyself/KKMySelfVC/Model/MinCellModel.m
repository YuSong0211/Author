//
//  MinCellModel.m
//  KK
//
//  Created by 小草 on 2021/6/27.
//

#import "MinCellModel.h"

@implementation MinCellModel

// 包含
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"dataSource" : [MinCellModelDataSource class],
    };
}

@end

@implementation MinCellModelDataSource

@end
