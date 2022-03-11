//
//  KKSytemShock.m
//  TestLoadingDemo
//
//  Created by 小草 on 2021/7/7.
//

#import "KKSytemShock.h"
#import <UIKit/UIKit.h>

@implementation KKSytemShock

// Light
+(void)openShockLight{
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [feedBackGenertor impactOccurred];
}

// Medium
+(void)openShockMedium{
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    [feedBackGenertor impactOccurred];
}

// Heavy
+(void)openShockHeavy{
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    [feedBackGenertor impactOccurred];
}

// Soft
+(void)openShockSoft{
    if (@available(iOS 13.0, *)) {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft];
        [feedBackGenertor impactOccurred];
    } else {
        // Fallback on earlier versions
    }
}

// Rigid
+(void)openShockRigid{
    if (@available(iOS 13.0, *)) {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleRigid];
        [feedBackGenertor impactOccurred];
    } else {
        // Fallback on earlier versions
    }
}

@end
