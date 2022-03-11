//
//  AvatarPlayer.h
//  KK
//
//  Created by hk on 2021/6/23.
//

#import <Foundation/Foundation.h>
#import "TokenCtrl.h"
#import "HeadsConfig.h"
NS_ASSUME_NONNULL_BEGIN

//用户类
@interface AvatarPlayer : NSObject

+(AvatarPlayer*)init;

@property (strong,nonatomic) TokenCtrl* tokenCtrl;

-(TokenCtrl*)getTokenCtrl;



//用户ID
@property (assign,nonatomic) long uid;


@end

NS_ASSUME_NONNULL_END
