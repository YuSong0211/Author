//
//  MCTabBarController.m
//  MCTabBarController
//
//  Created by caohouhong on 2018/12/7.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  github:https://github.com/Ccalary/MCTabBarController

#import "MCTabBarController.h"
#import "KKPublishVC.h"
#import "KKNavVC.h"
@interface MCTabBarController ()<UITabBarControllerDelegate>
@end

@implementation MCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mcTabbar = [[MCTabBar alloc] init];
    //[_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 重写选中事件， 处理中间按钮选中问题
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
   // _mcTabbar.centerBtn.selected = (tabBarController.selectedIndex == self.viewControllers.count/2);

    if (self.mcDelegate){
        [self.mcDelegate mcTabBarController:tabBarController didSelectViewController:viewController];
    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    return YES;
    
}
- (void)buttonAction:(UIButton *)button{
//    KKNavVC *navVc = (KKNavVC*)self.viewControllers[self.selectedIndex];
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.2f;
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromTop;
//    [navVc.view.layer addAnimation:transition forKey:kCATransition];
//    [navVc pushViewController:[[KKPublishVC alloc]init] animated:NO];
}

@end
