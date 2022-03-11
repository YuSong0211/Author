//
//  AppTimeSysMgr.h
//  KK
//
//  Created by hk on 2021/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppTimeSysMgr : NSObject
/// 单例持有
+(AppTimeSysMgr*)shareMgr;

@property(nonatomic,assign)BOOL isInit;
/// 初始化系统时间
/// @param date 系统时间
-(void)initSysTime:(NSString*)date;


/// 获取系统当前时间
+(NSDate*)getNowTime;

/// 获取当前时间戳
+(long)getNowTimeStamp;

+(void)initGcdReloadTime;
+(void)reloadDta;

@end

NS_ASSUME_NONNULL_END
