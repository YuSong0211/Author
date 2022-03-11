//
//  KKPollingCheckManger.h
//  mt
//
//  Created by 小草 on 2021/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKPollingCheckManger : NSObject

// 单例管理者
+(instancetype)sharManger;

// 商品id数组
@property (nonatomic,strong)NSMutableArray * commodityIdArray;

/// 开始轮询查询，间隔X秒执行一次，总共检查多少次
/// @param time 间隔时间
/// @param checkCount 检查次数
-(void)startPollingCheckTime:(CGFloat)time checkCount:(CGFloat)checkCount;

@end

NS_ASSUME_NONNULL_END
