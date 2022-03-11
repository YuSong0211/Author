//
//  BRAddressModel.m
//  BRPickerViewDemo
//
//  Created by 任波 on 2017/8/11.
//  Copyright © 2017年 renb. All rights reserved.
//

#import "BRAddressModel.h"

// 省
@implementation BRProvinceModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"value",
             @"city": @"city"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"city": [BRCityModel class]
             };
}

@end

// 市区
@implementation BRCityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"value",
             @"town": @"county"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"town": [BRTownModel class]
             };
}

@end


// 县城
@implementation BRTownModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"value"
             };
}

@end
