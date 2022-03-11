//
//  LevelVideoDriverCtrl.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "LevelVideoDriverCtrl.h"
static LevelVideoDriverCtrl* instance;
@implementation LevelVideoDriverCtrl

+ (LevelVideoDriverCtrl *)getInstance{
    if(instance == NULL){
        instance = [[LevelVideoDriverCtrl alloc] init];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.levelId = 1;
        self.levelInstanceList = [[NSMutableArray alloc] init];
    }
    return self;
}


//创建一个控制器
- (LevelVideoCtrl *)createLevelCtrl{
    @synchronized (self.levelInstanceList) {
        self.levelId+=1;
        LevelVideoCtrl* level = [LevelVideoCtrl initWithLevelId:self.levelId];
        [self.levelInstanceList addObject:level];
        return level;
    }
}

 
 

- (LevelVideoCtrl *)getLevelCtrlByLevelId:(NSInteger)levelId{
    for(LevelVideoCtrl* level in self.levelInstanceList){
        if(level.levelId == levelId){
            return level;
        }
    }
    return nil;
}


//删除某个实例
- (void)killCtrl:(NSInteger)levelId{
    for(LevelVideoCtrl* level in self.levelInstanceList){
        if(level.levelId == levelId){
            [level releaseVideo];
            [self.levelInstanceList removeObject:level];
            break;
        }
    }
}


- (void)clear{
    for(LevelVideoCtrl* level in self.levelInstanceList){
        [level releaseVideo];
    }
    [self.levelInstanceList removeAllObjects];
}


@end
