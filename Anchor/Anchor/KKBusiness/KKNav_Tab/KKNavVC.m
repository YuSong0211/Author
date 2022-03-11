//
//  KKNavVC.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKNavVC.h"

@interface KKNavVC ()<UIGestureRecognizerDelegate>

@end

@implementation KKNavVC

- (void)viewDidLoad {

    [super viewDidLoad];
    
    NSDictionary *dic = @{NSForegroundColorAttributeName : [KKColor getColor:appMainTextColor],
                          NSFontAttributeName : [UIFont mediumWithSize:16]};
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundColor = [KKColor getColor:appBgColor];
        barApp.shadowColor = [KKColor getColor:appBgColor];
        barApp.titleTextAttributes = dic;
        self.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationBar.standardAppearance = barApp;
    }else{

        self.navigationBar.barTintColor = [KKColor getColor:appBgColor];
        self.navigationBar.titleTextAttributes = dic;
    }
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [KKColor getColor:appMainTextColor];
    
    
    
//    self.navigationBar.translucent = NO;
//    self.navigationBar.tintColor = [KKColor getColor:appMainTextColor];
//    self.navigationBar.barTintColor = [KKColor getColor:appBgColor];
//    [self.navigationBar setTitleTextAttributes:
//         @{NSFontAttributeName:[UIFont mediumWithSize:16],
//           NSForegroundColorAttributeName:[KKColor getColor:appMainTextColor]}];
    //去掉导航下面的黑线
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 添加全局滑动返回手势
    [self addFullScreenSwipeGesturBack];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
    //处理了push后隐藏底部UITabBar的情况，并解决了iPhonX上push时UITabBar上移的问题。
    CGRect rect = self.tabBarController.tabBar.frame;
    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    self.tabBarController.tabBar.frame = rect;
}

//添加全局滑动返回
- (void)addFullScreenSwipeGesturBack {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)sender {
    //可不实现
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (self.isForbiddenFullPopGestureRecognizer) {
        return NO;
    }else {
        if (self.childViewControllers.count > 1) {
            return YES;
        }else {
            return NO;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//     UIWindow *window = [UIApplication sharedApplication].keyWindow;
//     if (window) {
//        [window endEditing:YES];
//     }
//     return YES ;
        UIViewController *vc = [self topViewController];
        if (vc.navigationController.viewControllers.count > 1){
            return YES;
        }else{
            //是根根视图控制器，不使用返回手势
            return NO;
        }
}


////是否可以旋转
//  - (BOOL)shouldAutorotate
// {
//    return false;
// }
//  //支持的方向
//  -(UIInterfaceOrientationMask)supportedInterfaceOrientations
//  {
//     return UIInterfaceOrientationMaskPortrait;
// }
@end
