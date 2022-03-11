//
//  LevelVideoDriverCtrl.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "LevelVideoCtrl.h"
NS_ASSUME_NONNULL_BEGIN

//二级播放器与视频列表控制器
//二级播放器需要多个实例，
//以此类作为桥接，数据源
//实例与数据分离

//真正的控制
@interface LevelVideoDriverCtrl : NSObject


//单例
+(LevelVideoDriverCtrl*)getInstance;

//实例id
@property(nonatomic,assign)NSInteger levelId;


//存放数据源
@property(nonatomic,strong)NSMutableArray<LevelVideoCtrl*>* levelInstanceList;


//创建一个控制器
-(LevelVideoCtrl*)createLevelCtrl;


//通过Id 获取控制器对象
-(LevelVideoCtrl*)getLevelCtrlByLevelId:(NSInteger)levelId;

//销毁某个控制器
-(void)killCtrl:(NSInteger)levelId;

//清空所有控制器
-(void)clear;

@end






NS_ASSUME_NONNULL_END
