//
//  AppLinkDomainItem.m
//  KK
//
//  Created by hk on 2021/8/31.
//

#import "AppLinkDomainItem.h"


@interface AppLinkDomainItem()

/**
 存放默认下标
 */
@property (nonatomic,strong)NSMutableArray* arrayIndexList;

@end

@implementation AppLinkDomainItem
    
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.domainList = [[DoMainUrlItem alloc] init];
        self.selectDomainIndex = @"";
        self.arrayIndexList = [[NSMutableArray alloc] init];
        for(int i=0;i<10;i++){
            [self.arrayIndexList addObject:[NSNumber numberWithInt:i-1]];
        }
    }
    return self;
}
 


/// 通过域名枚举获取缓存信息
/// @param domainType 域名类型
-(AppLinkDomainModel*)getItemByDomainModelByType:(AppLinkDomainType)domainType{
    
    if([self getIndexDataByIndex:0] == -1){
        [self fillArray];
    }
    int v = 0;
    switch (domainType) {
        case DomainTypeUpdate:
            v = [[self.arrayIndexList objectAtIndex:0] intValue];
            return [AppLinkDomainModel initWithDomainMessage:self.domainList.updateList :v :domainType];
        case DomainTypeUc:
            v = [[self.arrayIndexList objectAtIndex:1] intValue];
            return [AppLinkDomainModel initWithDomainMessage:self.domainList.ucList :v :domainType];
        case DomainTypeApi:
            v = [[self.arrayIndexList objectAtIndex:2] intValue];
            return [AppLinkDomainModel initWithDomainMessage:self.domainList.apiList :v :domainType];
        case DomainTypeShare:
            v = [[self.arrayIndexList objectAtIndex:3] intValue];
            return [AppLinkDomainModel initWithDomainMessage:self.domainList.appVlink :v :domainType];
        case DomainTypeNoticeResource:
            v = [[self.arrayIndexList objectAtIndex:4] intValue];
            return [AppLinkDomainModel initWithDomainMessage:self.domainList.noticeResource :v :domainType];
        case DomainTypeGray:
            v = [[self.arrayIndexList objectAtIndex:5] intValue];
            return [AppLinkDomainModel initWithDomainMessage:self.domainList.appvGrayscaleLink :v :domainType];
        default:
            break;
    }
//    v = [[self.arrayIndexList objectAtIndex:3] intValue];
    return  [AppLinkDomainModel initWithDomainMessage:self.domainList.apiList :v :domainType];
}

/**
 填充数组
 */
-(void)fillArray{
    NSArray* array = [self.selectDomainIndex componentsSeparatedByString:@","];
    for(int i=0;i<array.count;i++){
        NSString* val = array[i];
        [self.arrayIndexList setObject:[NSNumber numberWithInt:[val intValue]] atIndexedSubscript:i];
    }
}

/// 数组取出类型转换
/// @param index 取出的类型
-(int)getIndexDataByIndex:(int)index{
    return [[self.arrayIndexList objectAtIndex:index] intValue];
}


/// 设置选中的地址
/// @param domainType 域名类型
/// @param index 下标
-(void)setItemUseByType:(AppLinkDomainType)domainType index:(int)index{
    switch (domainType) {
        case DomainTypeUpdate:
            [self.arrayIndexList setObject:[NSNumber numberWithInt:index] atIndexedSubscript:0];
            break;
        case DomainTypeUc:
            [self.arrayIndexList setObject:[NSNumber numberWithInt:index] atIndexedSubscript:1];
            break;
        case DomainTypeApi:
            [self.arrayIndexList setObject:[NSNumber numberWithInt:index] atIndexedSubscript:2];
            break;
        case DomainTypeShare:
            [self.arrayIndexList setObject:[NSNumber numberWithInt:index] atIndexedSubscript:3];
            break;
        case DomainTypeNoticeResource:
            [self.arrayIndexList setObject:[NSNumber numberWithInt:index] atIndexedSubscript:4];
            break;
        case DomainTypeGray:
            [self.arrayIndexList setObject:[NSNumber numberWithInt:index] atIndexedSubscript:5];
            break;
        default:
            break;
    }
}

@end
