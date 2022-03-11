//
//  KKBaseVideoListViewController.h
//  KK
//
//  Created by Gwynne on 2021/8/6.
//

#import "KKSecondBaseVC.h"
#import "BaseVideoListViewModel.h"
#import "KKNodateView.h"
typedef NS_ENUM(NSUInteger, KKMainPageListType) {
    KKMainPageListShortVideoType, //短视频
    KKMainPageListShortCommunityType, //社区帖子
    KKMainPageListLiveType // 直播
};

NS_ASSUME_NONNULL_BEGIN

@interface KKBaseVideoListViewController : KKSecondBaseVC<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,BaseVideoListViewModelDelegate>

@property (nonatomic,assign) KKLoadFailState pageType;

///viewModel
@property (nonatomic,strong) BaseVideoListViewModel *baseViewModel;

///记录index
@property (nonatomic,strong) NSIndexPath *markIndex;

///类型
@property (nonatomic,assign) KKMainPageListType vcType;

///collectionView
@property (nonatomic,strong) UICollectionView *collectionView;

///tableView
@property (nonatomic,strong) UITableView *tableView;

///是否展示上拉加载刷新
//@property (nonatomic,assign) BOOL isShowFooter;

///是否展示下拉加载刷新
@property (nonatomic,assign) BOOL isShowHeader;
///是否正在刷新
@property (nonatomic,assign) BOOL isReloadIng;
//是否需要预播放
@property (nonatomic,assign) BOOL isFirstPlayVideo;
//排行
@property(nonatomic,assign)BOOL isRank;
@property (nonatomic,copy)NSMutableArray *videoRankList;
///配置UICollectionViewFlowLayout
- (UICollectionViewFlowLayout *)configLayout;

///首次加载数据
- (void)firstLoadData;

///下拉刷新
- (void)refresh;

///上拉加载
- (void)loadMore;

///停止刷新
- (void)endRefreshing;

///创建UI
- (void)createUI;

///添加TableView
/// @param identifiers 复用标识符
/// @param isConfigRefresh 是否配置刷新
- (void)addTableViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefresh;

///添加CollectionView
/// @param identifiers 复用标识符
/// @param isConfigRefresh 是否配置刷新
- (void)addCollectionViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefresh;

- (void)configTableViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefre;

- (void)configCollectionViewWithIdentifiers:(NSArray<NSString *> *)identifiers isConfigRefresh:(BOOL)isConfigRefresh;

-(void)beginRefreshing;
-(void)imageLoadEndWithIndex:(NSInteger)index andImageUrl:(NSString *)imageUrl;

- (void)isHiddenFooter:(BOOL)isHidden;

- (void)commonMethods:(id)dataSource;

@end

NS_ASSUME_NONNULL_END
