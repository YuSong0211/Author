//
//  AppLinkDomainMgr.h
//  KK
//
//  Created by hk on 2021/8/31.
//

#import <Foundation/Foundation.h>
#import "AppLinkDomainItem.h"
//#import "richers.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppLinkDomainMgr : NSObject
/// 单例持有
+(AppLinkDomainMgr*)shareMgr;


@property(nonatomic,strong)AppLinkDomainItem* appLinkDomainItem;

/// 根据请求类型获取对应请求地址
/// @param domainType 域名类型
-(NSString*)getUrlByRequestType:(OC_DomainType)domainType; 


/// 根据域名获取数据
/// @param domainType 域名类型
//-(AppLinkDomainModel*)getDomainModelByType:(AppLinkDomainType)domainType;


/// 检测域名
/// @param domainType 域名类型
/// @param complete 检测回调
-(void)checkItem:(OC_DomainType)domainType complete:(OnBoolComplete)complete;


/// 根据包名，获取请求地址
/// @param packageName 包名
-(OC_DomainType)getUrlByPackageName:(NSString*)packageName;

/// 读取并解析本地数据
-(void)runInit;

///更新本地缓存
-(void)refehCache;
@end

NS_ASSUME_NONNULL_END
