//
//  AppDelegate.m
//  KK
//
//  Created by hk on 2021/6/22.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>
#import "ViewController.h"
#import "KKTabbarVC.h"
#import "KKAppStartVC.h"
#import "NetWrokStatesCtrl.h"
#import "SupportedInterfaceOrientations.h"

#define licenceURLStr @"https://license.vod2.myqcloud.com/license/v2/1310084171_1/v_cube.license"
#define licenceKeyStr @"57577ac4ac46c84b11bc8941bd0e1652"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setTingWindow];
    return YES;
}


-(void)setTingWindow {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    KKAppStartVC *KKStarVC = [[KKAppStartVC alloc] init];
    self.window.rootViewController = KKStarVC;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [KKColor getColor: appBgColor];
    [self initLiveInfo];
}
-(void)initLiveInfo{
    
    NSString * const licenceURL =licenceURLStr ;
    NSString * const licenceKey =licenceKeyStr ;
       //TXLiveBase 位于 "TXLiveBase.h" 头文件中
    [TXLiveBase setLicenceURL:licenceURL key:licenceKey];
       NSLog(@"SDK Version = %@", [TXLiveBase getSDKVersionStr]);
    
}

- (void)applicationWillResignActive:(UIApplication *)application{
    self.isgo = YES;
    self.isback = NO;
 
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    self.isgo = NO;
    self.isback = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isgo = NO;
        self.isback = NO;
    });
    
}
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.rotateDirection) {//如果设置了allowRotation属性，支持全屏
       return UIInterfaceOrientationMaskLandscapeRight;
}
    return UIInterfaceOrientationMaskPortrait;//默认全局不支持横屏
}


@end

