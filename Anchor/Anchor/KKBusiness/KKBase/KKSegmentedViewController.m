//
//  KKSegmentedViewController.m
//  KK
//
//  Created by Gwynne on 2021/8/6.
//

#import "KKSegmentedViewController.h"

@interface KKSegmentedViewController ()

@end

@implementation KKSegmentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.pageContentView];
    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            // Fallback on earlier versions
            make.bottom.equalTo(self.view);
        }
    }];
}

- (BOOL)isCenterShow {
    return YES;
}

- (NSArray<UIViewController *> *)childViewControllerArray {
    return nil;
}

- (NSArray <NSString *>*)titleArray {
    return nil;
}

- (SGPageTitleView *)titleView {
    if (!_titleView) {
        CGFloat offset = 10;
        CGFloat w = self.isCenterShow ? KK_SCREEN_WIDTH : KK_SCREEN_WIDTH - offset;
        CGFloat x = self.isCenterShow ? 0 : offset;
        _titleView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(x, 0, w, 40) delegate:self titleNames:[self titleArray] configure:[self configTitleViewConfigur]];
        _titleView.backgroundColor = [KKColor getColor:appBgColor];
        _titleView.scrollView.scrollEnabled = NO;
    }
    return _titleView;
}

- (SGPageContentScrollView *)pageContentView {
    if (!_pageContentView) {
        _pageContentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT) parentVC:self childVCs:[self childViewControllerArray]];
        _pageContentView.delegatePageContentScrollView = self;
    }
    return _pageContentView;
}


- (SGPageTitleViewConfigure *)configTitleViewConfigur {
    return [KKTool getPageTitleViewConfigureisCenter:self.isCenterShow];
}

#pragma mark - SGPageTitleViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentScrollViewCurrentIndex:selectedIndex];
}

#pragma mark - SGPageContentScrollViewDelegate
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.titleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end
