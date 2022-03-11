//
//  KKSytemShock.h
//  TestLoadingDemo
//
//  Created by 小草 on 2021/7/7.
//

#import <Foundation/Foundation.h>

@interface KKSytemShock : NSObject

// 震动Light  （抖音首页下拉刷新用的这个，弱弱的手感很好）
+(void)openShockLight;

// 震动Medium  较强
+(void)openShockMedium;

// 震动Heavy   很明显
+(void)openShockHeavy;

// ----- iOS 13 后才有

// 震动Soft
+(void)openShockSoft;

// 震动Soft
+(void)openShockRigid;

@end
// 调用示例
// [KKSytemShock openShockLight];
