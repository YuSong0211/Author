//
//  AvatarPlayer.m
//  KK
//
//  Created by hk on 2021/6/23.
//

#import "AvatarPlayer.h"

//单例
static AvatarPlayer* instance = NULL;
//用户类操作
@implementation AvatarPlayer
    

//单例操作
+(AvatarPlayer*)init{
    if(instance == NULL){
        instance = [[AvatarPlayer alloc] init];
    }
    [instance initToken];
    return instance;
}

//初始化token
-(void)initToken{
    self.tokenCtrl = [[TokenCtrl alloc] init];
    [self.tokenCtrl initToken];
}

//获取token 控制类
- (TokenCtrl *)getTokenCtrl{
    return self.tokenCtrl;
}


    
@end
