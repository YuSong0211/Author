//
//  KKTabbarVC.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKTabbarVC.h"
#import "KKMySelfVC.h"
#import "KKNavVC.h"
#import "CustomWebViewController.h"
#import "ViewController.h"
@interface KKTabbarVC ()<MCTabBarControllerDelegate>
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) NSInteger nowIndex;
@property (nonatomic,strong) UIButton *selectBtn;
@end

@implementation KKTabbarVC

- (void)viewDidLoad {

    [super viewDidLoad];
    self.index = 0;
    self.nowIndex = 0;
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        appearance.shadowColor = [UIColor clearColor];
        appearance.backgroundColor = KKPlayerMainColor;
        UITabBarItemStateAppearance *normal = appearance.stackedLayoutAppearance.normal;
            if (normal) {
                normal.titlePositionAdjustment = UIOffsetMake(0, -15);
            }
        self.tabBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            self.tabBar.scrollEdgeAppearance = appearance;
        }
    }else{
        //去掉top线
        self.tabBar.shadowImage = [UIImage new];
        self.tabBar.backgroundImage = [UIImage new];
        self.tabBar.backgroundColor = [KKColor getColor:appTabBgColor];
    }

    self.mcTabbar.position = MCTabBarCenterButtonPositionCenter;

    self.mcTabbar.centerImage = [KKTool decodeResourceFileImageName:@"icon_tab_publish"];
    self.mcTabbar.translucent = NO;
    self.mcDelegate = self;
    [self addChildViewControllers];
    self.selectBtn = self.mcTabbar.centerlabelArray[0];
    [self.selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //单例储存 横屏用
    [KKConfig share].isFullScreen = KK_STATUS_BAR_HEIGHT == 20 ? NO : YES;
    //主tabbar
    [KKConfig share].mainTabbatViewController = self;
    
}

//添加子控制器
- (void)addChildViewControllers{
   
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"首页" andImageName:@"" andSlectImage:@""];
    [self addChildrenViewController:[[KKMySelfVC alloc] init] andTitle:@"我的" andImageName:@"" andSlectImage:@""];
    
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSlectImage:(NSString *)selectImagename{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];

    // 选中的颜色由tabbar的tintColor决定
    self.tabBar.tintColor = [UIColor colorWithRed:31/255.0 green:170/255.0 blue:139/255.0 alpha:1.0];
    self.tabBar.tintColor = [KKColor getColor:appTabBgColor];
    [childVC.tabBarItem setImage:[UIImage imageNamed:imageName]];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectImagename];
    KKNavVC *baseNav = [[KKNavVC alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
    UIButton * cenLabel = self.mcTabbar.centerlabelArray[_index];
    [cenLabel setTitle:title forState:UIControlStateNormal];
    self.index++;
}



// 使用MCTabBarController 自定义的 选中代理
- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
   
    UIButton *btn =self.mcTabbar.centerlabelArray[tabBarController.selectedIndex];
    self.nowIndex = self.selectedIndex;
    if ([btn isEqual:self.selectBtn]) {

    }
    else{
        btn.selected = YES;
        self.selectBtn.selected = NO;
        self.selectBtn  = btn;
    }
    if (tabBarController.selectedIndex == 1){
        [self.mcTabbar.centerBtn.layer removeAllAnimations];
    }
    NSNotification *notification = [NSNotification notificationWithName:@"changebackScrollernotification"object:nil userInfo:@{@"key":[NSNumber numberWithInteger:self.selectedIndex]}];
     [[NSNotificationCenter defaultCenter] postNotification:notification];
 
}
-(void)settabrBgColorWithBool:(BOOL)isBlack{
    if (@available(iOS 13.0, *)) {
        if (isBlack) {
            if (@available(iOS 15.0, *)) {
                self.tabBar.scrollEdgeAppearance.backgroundColor = KKPlayerMainColor;
            }
            self.tabBar.standardAppearance.backgroundColor = KKPlayerMainColor;
            self.tabBar.backgroundColor = KKPlayerMainColor;
        }
        else{
            if (@available(iOS 15.0, *)) {
                self.tabBar.scrollEdgeAppearance.backgroundColor = [KKColor getColor:appBgColor];
            }
            self.tabBar.standardAppearance.backgroundColor = [KKColor getColor:appBgColor];
            self.tabBar.backgroundColor  = [KKColor getColor:appBgColor];
        }
    }else{
        if (isBlack) {
            self.tabBar.backgroundColor = KKPlayerMainColor;
        }
        else{
            self.tabBar.backgroundColor  = [KKColor getColor:appBgColor];
        }
       
    }
}

@end
