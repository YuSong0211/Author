//
//  KKSecondBaseVC.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKSecondBaseVC.h"
#import "KKNavVC.h"
#import "CustomWebViewController.h"
#import "UIDevice+XJDevice.h"
#import "AppDelegate.h"
@interface KKSecondBaseVC ()

@property (nonatomic,strong) UIButton *rightNavButton;

@end

@implementation KKSecondBaseVC


- (UIStatusBarStyle)preferredStatusBarStyle {
    return [KKTool statusBarStyleWith:[KKColor getColor:appBgColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    //是否显示返回按钮 默认一级不显示，此外都显示返回按钮
    [self setIsShowLeftBack:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //设置返回手势优先级（返回手势 > 所有滚动试图的）
    [self setPopGestureRecognizerPriority];
    //是否禁用返回手势
    [self isProhibitPopGestureRecognizer:NO];
    //此处要判断是否是根式图，以免造成页面假死的状态
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.navigationController.viewControllers.count > 1);
    //是否禁用返回手势(全屏)
    [self isProhibitFullScreenPopGestureRecognizer:YES];
    //是否展示键盘toolbar
    [self keyboardEnableAutoToolbar:NO];
    if (![self isKindOfClass:[CustomWebViewController class]]) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.rotateDirection = NO;
        [UIDevice setOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

//是否显示返回按钮
- (void)setIsShowLeftBack:(BOOL)isShowLeftBack {
    _isShowLeftBack = isShowLeftBack;
    NSInteger viewControllersCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLeftBack && (viewControllersCount > 1 || self.navigationController.presentingViewController != nil)) {
        [self createNavLeftItem:@"icon_back"];
        
    } else {
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
    }
}

//创建返回按钮
- (void)createNavLeftItem:(NSString *)image {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 10, 24, 24)];
    imageView.image = [KKTool decodeResourceFileImageName:image];
    [view addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [view addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

- (void)backAction {
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)isProhibitFullScreenPopGestureRecognizer:(BOOL)isProhibit {
    KKNavVC *nav = (KKNavVC *)self.navigationController;
    nav.isForbiddenFullPopGestureRecognizer = isProhibit;
}

//是否禁用返回手势
- (void)isProhibitPopGestureRecognizer:(BOOL)isProhibit {
    if (isProhibit) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else {
        //可以手势返回
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

//设置返回手势优先级（返回手势 > 所有滚动试图的）
- (void)setPopGestureRecognizerPriority {
    //通过两层for去寻找子视图，此处应该有更优秀的写法，目前暂时这样写。
    for (UIView * objc in self.view.subviews) {
        [self requireGestureRecognizer:objc];
        for (UIView *item in objc.subviews) {
            [self requireGestureRecognizer:item];
        }
    }
}

- (void)requireGestureRecognizer:(UIView *)objc {
    if ([objc isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scr = (UIScrollView *)objc;
        [scr.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
}

- (void)addRightButtonItemWith:(NSString *)title {

    self.rightNavButton = [[UIButton alloc] init];
    [self.rightNavButton addTarget:self action:@selector(rightButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rightNavButton setTitle:title forState:UIControlStateNormal];
    [self.rightNavButton setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
    self.rightNavButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavButton];
}

/// 隐藏右按钮
-(void)hiddenRightButton{
    self.rightNavButton.hidden = YES;
}

- (void)rightButtonItemAction {
    
}

- (void)keyboardEnableAutoToolbar:(BOOL)enableAutoToolbar {
    [IQKeyboardManager sharedManager].enableAutoToolbar = enableAutoToolbar;
}

-(void)dealloc{
 
}
@end
