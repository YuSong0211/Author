//
//  UIBaseController.m
//  KK
//
//  Created by hk on 2021/6/23.
//

#import "UIBaseController.h"

@implementation UIBaseController

- (void)viewDidLoad{
    
    [super viewDidLoad];
}


//初始化导航栏颜色
- (void)initNavbar:(UIColor *)barcolor :(UIBarStyle)barstyle :(UIStatusBarStyle)statusbarstyle{
    
    self.navigationController.navigationBar.barStyle = barstyle;
    self.navigationController.navigationBar.barTintColor = barcolor;
    [UIApplication sharedApplication].statusBarStyle = statusbarstyle;
}



@end
