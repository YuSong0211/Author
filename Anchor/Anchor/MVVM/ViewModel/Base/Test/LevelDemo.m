//
//  LevelDemo.m
//  KK
//
//  Created by hk on 2021/8/5.
//

#import "LevelDemo.h"

@interface LevelDemo()<mVideoLevelDelegate>

@property (strong,nonatomic) LevelVideoCtrl* levelVideoCtrl;

@end

@implementation LevelDemo

    
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.levelId = 1;
        [self start];
    }
    return self;
}


-(void)start{
    self.levelVideoCtrl = [[LevelVideoDriverCtrl getInstance] getLevelCtrlByLevelId:self.levelId];
    if(self.levelVideoCtrl!=NULL){
        self.levelVideoCtrl.videoLeveldelegate = self;
    }
    
}

-(void)testgetMore{
    if(self.levelVideoCtrl!=NULL && self.levelVideoCtrl.videoListdelegate!=NULL){
//        [self.levelVideoCtrl.videoListdelegate getLevelMoreVideo:@"你的视频id"];
    }
}



- (void)onReveiveNewVideoListCompltte:(NSMutableArray<AvModel *> *)videoList{
    NSLog(@"%@,哈哈，新视频来了",videoList);
}


@end
