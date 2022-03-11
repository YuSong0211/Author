//
//  KKBase.m
//  KK
//
//  Created by hk on 2021/8/9.
//

#import "KKBase.h"

@implementation KKBase

    
//网络是否可用
- (BOOL)networkIsAvailable{
    return [[NetWrokStatesCtrl getInstance] networkIsAvailable];
}

@end
