//
//  KKBase.h
//  KK
//
//  Created by hk on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "NetWrokStatesCtrl.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKBase : NSObject

//获取网络状态
-(BOOL)networkIsAvailable;

@end

NS_ASSUME_NONNULL_END
