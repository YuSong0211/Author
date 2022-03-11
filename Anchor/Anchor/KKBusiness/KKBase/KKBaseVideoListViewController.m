//
//  KKBaseVideoListViewController.m
//  KK
//
//  Created by Gwynne on 2021/8/6.
//

#import "KKBaseVideoListViewController.h"
@interface KKBaseVideoListViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)NSArray *cellIndexArray;
@property (nonatomic, assign)BOOL imageIsLoad;  //图片是否加载完成
@property (nonatomic, assign)BOOL scrollerisend; //滚动是否停止
@property (nonatomic, assign)BOOL reloadEnd; //relpoad 是否完成
@property (nonatomic,strong)NSMutableArray *loadImageArr;
@end

@implementation KKBaseVideoListViewController

- (BaseVideoListViewModel *)baseViewModel {
    if (!_baseViewModel) {
        _baseViewModel = [[BaseVideoListViewModel alloc] init];
        _baseViewModel.delegate = self;
    }
    return _baseViewModel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self configLayout]];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [KKColor getColor:appBgColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [KKColor getColor:appBgColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 15.0, *)) {
            _tableView.prefetchingEnabled = NO;
        }
    }
    return _tableView;
}

- (UICollectionViewFlowLayout *)configLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 8;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
    return flowLayout;
}
-(NSMutableArray *)videoRankList{
    if (!_videoRankList) {
        _videoRankList = [NSMutableArray array];
    }
    return _videoRankList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    [self createUI];
    [self addNetWorkChangenotification];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.markIndex) {
        return;
    }
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.markIndex];
    if (![[self.collectionView visibleCells] containsObject:cell]) {
        
        if (self.isRank) {
            if (self.markIndex.row <self.videoRankList.count) {
                [self.collectionView scrollToItemAtIndexPath:self.markIndex atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
            }
        }else{
            [self.collectionView scrollToItemAtIndexPath:self.markIndex atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.markIndex = nil;
//    [KKAVPreviewPlayer stopPreviewplayer];
    [self setExclusiveTouchForButtons:self.view];
}

- (void)addNetWorkChangenotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChangeAction:) name:@"NetWorkChangenotification" object:nil];
}

- (void)netWorkChangeAction:(NSNotification *)sender {
    if (sender.userInfo) {
        NSDictionary *dict = sender.userInfo;
        if ([dict objectForKey:@"key"]) {
            NSInteger state = [dict[@"key"] integerValue];
            if (state != 0) {
                [self.collectionView reloadData];
                [self.tableView reloadData];
            }
        }
    }
}

- (void)createUI {
    //to do
    //子类重写
}

//配置tableView
//一些基础设置
//下拉刷新上拉加载
- (void)configTableViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefresh {
    //注册cell
    for (NSString *identifier in identifiers) {
        [self.tableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    }
    if (isConfigRefresh) {
        [self configRefresh:self.tableView];
    }
}

//配置collectionView
//一些基础设置
//下拉刷新上拉加载
- (void)configCollectionViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefresh {
    //注册cell
    for (NSString *identifier in identifiers) {
        [self.collectionView registerClass:NSClassFromString(identifier) forCellWithReuseIdentifier:identifier];
    }
    if (isConfigRefresh) {
        [self configRefresh:self.collectionView];
    }
}

- (void)configRefresh:(UIScrollView *)view  {
    //刷新控件
    KKRefreshHeader *header = [KKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    view.mj_header = header;
    [self firstLoadData];
    KKRefreshFooter *footer = [KKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    view.mj_footer = footer;
    
    // 让KKRefreshHeader 持有 footer
    header.footer = footer;
}

- (void)addTableViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefresh {
    [self.view addSubview:self.tableView];
    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:[KKTool getCurrentVC].navigationController.interactivePopGestureRecognizer];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self configTableViewWithIdentifiers:identifiers isConfigRefresh:isConfigRefresh];
}

- (void)addCollectionViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefresh {
    [self.view addSubview:self.collectionView];
    [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:[KKTool getCurrentVC].navigationController.interactivePopGestureRecognizer];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [self configCollectionViewWithIdentifiers:identifiers isConfigRefresh:isConfigRefresh];
    
}

- (void)firstLoadData {
    
    [KKLoadingView showInView:self.view withFrame:CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height/2-100, 50, 50)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refresh];
    });
}

- (void)refresh {
    [KKNodateView disMissWithLoadFailViewWithShowView:self.tableView];
    [KKNodateView disMissWithLoadFailViewWithShowView:self.collectionView];
    [self.baseViewModel requestWithIsRefresh:YES withLastId:nil];
}
- (void)loadMore {
    [self.baseViewModel requestWithIsRefresh:NO withLastId:[self.baseViewModel getLastId]];
}

-(void)beginRefreshing{
    [KKLoadingView showInView:self.view];
    if (self.tableView.mj_header) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)setIsShowHeader:(BOOL)isShowHeader{
    _isShowHeader = isShowHeader;
    if (self.tableView.mj_header) {
        self.tableView.mj_header.hidden = !isShowHeader;
    }
    if (self.collectionView.mj_header) {
        self.collectionView.mj_header.hidden = !isShowHeader;
    }
}

- (void)noData {
    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    KKRefreshFooter *tableviewfooter = (KKRefreshFooter *)self.tableView.mj_footer;
    tableviewfooter.noMoreDataLab.text = @"暂时没有更多了";
    
    self.collectionView.mj_footer.state = MJRefreshStateNoMoreData;
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    KKRefreshFooter *footer = (KKRefreshFooter *)self.collectionView.mj_footer;
    footer.noMoreDataLab.text = @"暂时没有更多了" ;
}

//停止刷新
- (void)endRefreshing {
    [KKLoadingView hideInView:self.view];
    if (self.tableView.mj_header) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshing];
    }
    if (self.collectionView.mj_header) {
        [self.collectionView.mj_header endRefreshing];
    }
    if (self.collectionView.mj_footer) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

//是否隐藏上拉加载
- (void)isHiddenFooter:(BOOL)isHidden {
    if (self.tableView.mj_footer) {
        self.tableView.mj_footer.hidden = isHidden;
    }
    if (self.collectionView.mj_footer) {
        self.collectionView.mj_footer.hidden = isHidden;
    }
}

#pragma mark -- UICollectionViewDelegate （子类按需重写）
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KK_SCREEN_WIDTH-38)/2, 225);
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.baseViewModel.videoList.count;
}


// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.baseViewModel startLevelVideo:indexPath.row];
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
    return cell;
}

#pragma mark -- UITableViewDelegate （子类按需重写）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.baseViewModel.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
}

//短视频列表回调
- (void)didReceiveEvent:(videoEventType)eventType dataSource:(id)dataSource {
    [self commonMethods:dataSource];
    
    if (eventType == location) {
        NSIndexPath *idx = [NSIndexPath indexPathForRow:self.baseViewModel.startIndex inSection:0];
        self.markIndex = idx;
    }
    
    if (eventType == requestError) {
        if (kArrayIsEmpty(self.baseViewModel.videoList)) {
            [KKNodateView showMTLoadFailViewWithLoadState:KKLoadFail withShowView:self.collectionView withAssignLoadBlock:^{
                [self refresh];
            }];
            
            [KKNodateView showMTLoadFailViewWithLoadState:KKLoadFail withShowView:self.tableView withAssignLoadBlock:^{
                [self refresh];
            }];
        }
    }else{
        //展示空数据
        if (kArrayIsEmpty(self.baseViewModel.videoList)) {
            [KKNodateView showMTLoadFailViewWithLoadState:self.pageType withShowView:self.collectionView withAssignLoadBlock:nil];
            
            [KKNodateView showMTLoadFailViewWithLoadState:self.pageType withShowView:self.tableView withAssignLoadBlock:nil];
        }else {
            [KKNodateView disMissWithLoadFailViewWithShowView:self.collectionView];
            
            [KKNodateView disMissWithLoadFailViewWithShowView:self.tableView];
        }
    }
}



//通用方法
- (void)commonMethods:(id)dataSource {
    [self endRefreshing];
    [self.tableView reloadData];
    [self.collectionView reloadData];
    [self setScrollViewNoData:dataSource];
    
}

////停止预览
//-(void)stopPreviewPlayer{
//    [KKAVPreviewPlayer stopPreviewplayer];
//}

//空数据占位
- (void)setScrollViewNoData:(id)item {
    if ([item isKindOfClass:[NSString class]]) {
        return;
    }
    NSArray *array = [NSArray array];
    if ([item isKindOfClass:[NSArray class]]) {
        array = (NSArray *)item;
    }
    if (kArrayIsEmpty(array)) {
        [self noData];
    }

}


-(void)setExclusiveTouchForButtons:(UIView *)myView
{
    for (UIView * v in [myView subviews]) {
        if([v isKindOfClass:[UIButton class]])
            [((UIButton *)v) setExclusiveTouch:YES];
        else if ([v isKindOfClass:[UIView class]]){
            [self setExclusiveTouchForButtons:v];
        }
    }
}



@end
