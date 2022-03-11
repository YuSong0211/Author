//
//  AppVersionMgr.h
//  KK
//
//  Created by hk on 2021/8/31.
//

#import <Foundation/Foundation.h>
#import "AppLinkDomainMgr.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppVersionMgr : NSObject


/// 单例持有
+(AppVersionMgr*)shareMgr;
@property (nonatomic, strong)NSArray<serviceapplinkAdvertisement*> *appADArray;///app启动页广告数组
@property (nonatomic, strong) AFURLSessionManager *manager ;
-(void)start:(OnBoolComplete)complete;

/**
 是否需要更新
 */
@property(nonatomic,assign)BOOL isNeedUpdate;


/// 获取app版本号，或者更新的版本号
/// @param newVersion true 为更新版本号，false为当前版本号
-(NSString*)getVersion:(BOOL)newVersion;

@property (nonatomic,assign)BOOL isNewVersion;

//更新重试
-(void)retry;

+(void)checkHybridgeVersion:(NSString *)hyBirdVersion; 
@end

NS_ASSUME_NONNULL_END
