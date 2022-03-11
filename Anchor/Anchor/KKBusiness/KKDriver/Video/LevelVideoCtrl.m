//
//  LevelVideoCtrl.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "LevelVideoCtrl.h"

@implementation LevelVideoCtrl
        
+ (LevelVideoCtrl *)initWithLevelId:(NSInteger)levelId{
    LevelVideoCtrl* level = [[LevelVideoCtrl alloc] init];
    level.levelId = levelId;
    return level;
}


//这个方法也可以被干掉的
- (void)releaseVideo{
    //释放一些数据。用这个方法就可以。
}

//启动二级界面
- (void)startLevelVideo:(NSInteger)startIndex{
    
   // self.levelId;
   //  startIndex;
}



@end
