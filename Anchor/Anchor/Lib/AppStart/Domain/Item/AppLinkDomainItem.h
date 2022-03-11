//
//  AppLinkDomainItem.h
//  KK
//
//  Created by hk on 2021/8/31.
//

#import <Foundation/Foundation.h>
#import "DoMainUrlItem.h"
#import "AppLinkDomainModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface AppLinkDomainItem : NSObject



/// 默认选择的域名
@property(nonatomic,strong)NSString* selectDomainIndex;


/// 域名列表相关
@property(nonatomic,strong)DoMainUrlItem* domainList;


/// 设置选中的地址
/// @param domainType 域名类型
/// @param index 下标
-(void)setItemUseByType:(AppLinkDomainType)domainType index:(int)index;


/// 通过域名枚举获取缓存信息
/// @param domainType 域名类型
-(AppLinkDomainModel*)getItemByDomainModelByType:(AppLinkDomainType)domainType;


 
@end

NS_ASSUME_NONNULL_END
