//
//  KKPublishVC.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKPublishVC.h"
#import "KKPublishShortVideoVC.h"
#import "KKNavVC.h"
#import "KKPubTagVCModel.h"
#import "KKPublishCommuityVC.h"
@interface KKPublishVC ()<UIGestureRecognizerDelegate,SGPageTitleViewDelegate,SGPageContentScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSMutableArray * titlesArray;
@property (nonatomic ,assign) BOOL starPoin;
@property (nonatomic,strong) SGPageContentScrollView *pageContentView;
@property (nonatomic,strong) NSMutableArray *childArray;
@property (nonatomic,strong) SGPageTitleView *titleView;


@end

@implementation KKPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布";
    self.view.backgroundColor = KKMainColor;
    self.childArray = [[NSMutableArray alloc] init];
    
    // 初始化发布短视频控制器
    KKPublishShortVideoVC *vc = [[KKPublishShortVideoVC alloc] init];
    vc.selectPageIndex = 0;
    [self.childArray addObject:vc];

    // 初始化发布社区控制器
    KKPublishCommuityVC *vc1 = [[KKPublishCommuityVC alloc] init];
    [self.childArray addObject:vc1];
    
    // 页面内容器
    [self.view addSubview:self.pageContentView];
    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];

    // 标题视图
    [self.view addSubview:self.titleView];
    self.titleView.selectedIndex = 0;
}

- (void)backVC:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
    KKNavVC *nav =(KKNavVC *) self.navigationController;
    nav.isForbiddenFullPopGestureRecognizer = NO;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}
- (SGPageTitleViewConfigure *)config {
    SGPageTitleViewConfigure *config = [[SGPageTitleViewConfigure alloc] init];
    config.isStaticStyle = YES;
    config.bottomSeparatorColor = [UIColor clearColor];
    config.titleSelectedColor = [KKColor getColor:colorVideoTabSelectedText];
    config.titleFont = [UIFont mediumWithSize:16];
    config.titleColor = [KKColor getColor:colorVideoTabUnSelectedText];
    config.titleSelectedFont = [UIFont mediumWithSize:16];
    config.indicatorColor = [KKColor getColor:colorPrimary];
    config.indicatorToBottomDistance = 2;
    config.indicatorStyle = SGIndicatorStyleDynamic;
    config.indicatorDynamicWidth = 20;
    config.indicatorCornerRadius = 3;
    config.indicatorHeight = 3;
    return config;
}

- (SGPageTitleView *)titleView {
    if (!_titleView) {
        //CGFloat w = 300;
        //CGFloat x = (KK_SCREEN_WIDTH - w) / 2;
        _titleView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, 44) delegate:self titleNames:@[@"短视频",@"社区帖子"] configure:[self config]];
        _titleView.backgroundColor = KKMainColor;
        _titleView.scrollView.scrollEnabled = NO;
    }
    return _titleView;
}

- (SGPageContentScrollView *)pageContentView {
    if (!_pageContentView) {
        _pageContentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT) parentVC:self childVCs:self.childArray];
        _pageContentView.delegatePageContentScrollView = self;
    }
    return _pageContentView;
}

#pragma mark - SGPageTitleViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentScrollViewCurrentIndex:selectedIndex];
}

#pragma mark - SGPageContentScrollViewDelegate
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    KKNavVC *nav =(KKNavVC *) self.navigationController;
//    if (targetIndex == 0) {
//        nav.isForbiddenFullPopGestureRecognizer = NO;
//    }else {
//        nav.isForbiddenFullPopGestureRecognizer = YES;
//    }
    [self.titleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    for (int i = 0; i < [KKPubTagVCModel shareToolGetManager].tagArr.count; i++) {
        KKPubTagVCDataModel *selectDataModel = [KKPubTagVCModel shareToolGetManager].tagArr[i];
        [KKPubTagVCModel shareToolGetManager].tagArr[selectDataModel.indexPathRow].isSelect = 1;
    }
    
    for (int i = 0; i < [KKPubTagVCModel shareToolGetManager].communityTagList.count; i++) {
        KKPubTagVCDataModel *selectDataModel = [KKPubTagVCModel shareToolGetManager].communityTagList[i];
        [KKPubTagVCModel shareToolGetManager].communityTagList[selectDataModel.indexPathRow].isSelect = 1;
    }
    
}
@end
