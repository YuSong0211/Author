//
//  AppDelegate.h
//  KK
//
//  Created by hk on 2021/6/22.
//

#import <UIKit/UIKit.h>

 

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,strong) UIWindow * window;
@property (nonatomic, assign) BOOL isgo;//是否切换后台
@property (nonatomic, assign) BOOL isback;//是否返回
@property (nonatomic, assign) BOOL rotateDirection;
-(void)setTingWindow;
@end

