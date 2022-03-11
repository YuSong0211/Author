//
//  KKTabbarVC.h
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "MCTabBarController.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKTabbarVC : MCTabBarController

- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
