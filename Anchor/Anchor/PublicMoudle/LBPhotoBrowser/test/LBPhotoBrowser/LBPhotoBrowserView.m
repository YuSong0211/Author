//
//  LBPhotoBrowserView.m
//  test
//
//  Created by dengweihao on 2017/8/2.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import "LBPhotoBrowserConst.h"
#import "LBPhotoBrowserManager.h"
#import "LBPhotoBrowserView.h"
#import "LBZoomScrollView.h"
#import "UIImage+LBDecoder.h"

#if __has_include(<SDWebImage/SDWebImageManager.h>)
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCacheConfig.h>
#import <SDWebImage/UIImage+MultiFormat.h>
#else
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "SDImageCacheConfig.h"
#import "UIImage+MultiFormat.h"
#endif

static CGFloat const itemSpace = 20.0;

@interface LBPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic , weak)LBZoomScrollView *zoomScrollView;

@property (nonatomic , strong)LBScrollViewStatusModel *model;

- (void)startPopAnimationWithModel:(LBScrollViewStatusModel *)model completionBlock:(void(^)(void))completion;

@property (nonatomic,copy) void(^panAction)(NSInteger count);
@end

@interface LBPhotoBrowserView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , weak)UICollectionView *collectionView;

@property (nonatomic , strong)NSMutableArray *dataArr;

@property (nonatomic , strong)NSMutableArray *models;

@property (nonatomic , assign)BOOL isShowing;

@property (nonatomic , assign)CGPoint startPoint;

@property (nonatomic , assign)CGFloat zoomScale;

@property (nonatomic , assign)CGPoint startCenter;

@property (nonatomic , strong)NSMutableDictionary *loadingImageModelDic;
@property (nonatomic , strong)NSMutableDictionary *preloadingModelDic;
//GCD中的对象在6.0之前是不参与ARC的，而6.0之后 在ARC下使用GCD也不用关心释放问题
@property (strong, nonatomic) dispatch_queue_t preloadingQueue;

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,assign) BOOL isHideNavView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation LBScrollViewStatusModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scale = @1;
        self.contentOffset = CGPointMake(0, 0);
    }
    return self;
}


- (void)loadImageWithCompletedBlock:(void (^)(LBScrollViewStatusModel *, UIImage *, NSData *, NSError *, BOOL, NSURL *))completedBlock {
    _loadImageCompletedBlock = completedBlock;
    [self loadImage];
}

- (void)loadImage {
    weak_self;
    if (self.opreation) {
        return;
    }
    //Code=-999 "已取消"
    self.opreation = [[SDWebImageManager sharedManager] loadImageWithURL:self.url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
//        LBPhotoBrowserLog(@"LBScrollViewStatusModel:( %d ) line %d log: %d -- %d",self.index,__LINE__,(int)receivedSize ,(int)expectedSize);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
       __block UIImage *downloadedImage = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            wself.opreation = nil;
            if (wself.loadImageCompletedBlock) {
            
                wself.loadImageCompletedBlock(wself, downloadedImage, data, error, finished, imageURL);
            }else {
                if (error) {
                    NSString *imageUrl1 = [NSString stringWithFormat:@"%@",self.easyUrl];
                    NSString *keyStr1 = [KKTool stringInterceptionConversion:imageUrl1];
                    SDImageCache* cache1 = [SDImageCache sharedImageCache];
                    //此方法会先从memory中取。
                    UIImage *image1 =[cache1 imageFromCacheForKey:keyStr1];
                    if (image1== nil) {
                        downloadedImage = [KKTool decodeResourceFileImageName:@"icon_community_photo"];
                    }else{
                        downloadedImage = image1;
                    }
                    
//                    downloadedImage = [LBPhotoBrowserManager defaultManager].errorImage;
                    LBPhotoBrowserLog(@"%@",error);
                }
                if (image) {
                    wself.isFinish = YES;
                }else{
                    wself.isFinish = NO;
                }
                wself.currentPageImage  = downloadedImage;
                if (downloadedImage.images.count > 0) {
                    wself.currentPageImage = [LBPhotoBrowserManager defaultManager].lowGifMemory ? downloadedImage : [UIImage sdOverdue_animatedGIFWithData:data];
                }
            }
        });
    }];
}

@end

@implementation LBPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChangeAction:) name:@"NetWorkChangenotification" object:nil];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self createUI];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self addGestureRecognizer:tap];
        [[LBPhotoBrowserManager defaultManager].tapArray addObject:tap];
        [self addGestureRecognizer:doubleTap];
        [tap requireGestureRecognizerToFail:doubleTap];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAction:) name:@"LBPhotoCollectionViewCellDismiss" object:nil];
    }
    return self;
}

- (void)dismissAction:(NSNotification *)sender {
    if (sender.object) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender.object;
        [self didTap:tap];
    }
}

- (void)createUI {
    LBZoomScrollView *zoomScrollView =[[LBZoomScrollView alloc]init];
    [self.contentView addSubview:zoomScrollView];
    _zoomScrollView = zoomScrollView;
}
-(void)netWorkChangeAction:(NSNotification *)notifition{
    if ([[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
        
        [self setModel:self.model];
    }
    
}
- (void)setModel:(LBScrollViewStatusModel *)model {
    _model = model;
    _zoomScrollView.model = model;
}
- (void)startPopAnimationWithModel:(LBScrollViewStatusModel *)model completionBlock:(void(^)(void))completion {
    [_zoomScrollView startPopAnimationWithModel:model completionBlock:completion];
}

- (void)didTap:(UITapGestureRecognizer *)tap {
    if ([LBPhotoBrowserManager defaultManager].isPublishPreview) {
        if (self.panAction) {
            self.panAction(1);
        }
    }else {
        CGPoint point = [tap locationInView:(UIView *)_zoomScrollView.imageView];
        [_zoomScrollView handlesingleTap:point];
    }
}
- (void)didDoubleTap:(UITapGestureRecognizer *)tap {
    if (self.panAction) {
        self.panAction(2);
    }
    CGPoint point = [tap locationInView:(UIView *)_zoomScrollView.imageView];
    if (!CGRectContainsPoint(_zoomScrollView.imageView.bounds, point)) {
        return;
    }
    [_zoomScrollView handleDoubleTap:point];
}

@end

@implementation LBPhotoBrowserView

- (void)updateTitle {
    self.titleLabel.text = self.dataArr.count == 1 ? @"" : [NSString stringWithFormat:@"%ld/%lu",(long)([LBPhotoBrowserManager defaultManager].currentPage + 1),self.dataArr.count];
    self.pageControl.numberOfPages = self.dataArr.count;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    }
    return _titleLabel;
}


- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = [UIColor blackColor];
    }
    return _navView;
}

- (void)setIsHideNavView:(BOOL)isHideNavView {
    _isHideNavView = isHideNavView;
    self.navView.hidden = isHideNavView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (NSMutableArray *)models {
    if (!_models) {
        _models = [[NSMutableArray alloc]init];
    }
    return _models;
}
- (NSMutableDictionary *)preloadingModelDic {
    if (!_preloadingModelDic) {
        _preloadingModelDic = [[NSMutableDictionary alloc]init];
    }
    return _preloadingModelDic;
}

- (NSMutableDictionary *)loadingImageModelDic {
    if (!_loadingImageModelDic) {
        _loadingImageModelDic = [[NSMutableDictionary alloc]init];
    }
    return _loadingImageModelDic;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.numberOfPages = self.dataArr.count;
        pageControl.currentPage = [LBPhotoBrowserManager defaultManager].currentPage;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        // there page sapce is equal to 20
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(-itemSpace / 2.0, 0, SCREEN_WIDTH + itemSpace, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        [self addSubview:collectionView];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.alwaysBounceVertical = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [self collectionViewRegisterCellWithCollectionView:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (void)collectionViewRegisterCellWithCollectionView:(UICollectionView *)collentionView {
    NSString *ID = NSStringFromClass([LBPhotoCollectionViewCell class]);
    [collentionView registerClass:[LBPhotoCollectionViewCell class] forCellWithReuseIdentifier:ID];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.PictureThumbnailsArray = [NSMutableArray array];
        self.windowLevel = UIWindowLevelAlert;
        self.hidden = NO;
        self.backgroundColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollViewDidScroll:) name:LBGifImageDownloadFinishedNot object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removePageControl) name:LBImageViewWillDismissNot object:nil];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
        [self addGestureRecognizer:pan];
        [LBPhotoBrowserManager defaultManager].currentCollectionView = self.collectionView;
        _preloadingQueue = dispatch_queue_create("lb.photoBrowser", DISPATCH_QUEUE_SERIAL);
        _isShowing = NO;
        self.navView.frame = CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_STATUS_BAR_HEIGHT + 44);
        [self addSubview:self.navView];
        self.isHideNavView = YES;
        KKClearButton *btn = [[KKClearButton alloc] init];
        [btn setImage:[KKTool decodeResourceFileImageName:@"icon_back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@25);
            make.top.equalTo(self.navView).offset(KK_STATUS_BAR_HEIGHT+10);
            make.left.equalTo(self.navView).offset(20);
        }];
        KKClearButton *deleteBtn = [[KKClearButton alloc] init];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@44);
            make.top.equalTo(self.navView).offset(KK_STATUS_BAR_HEIGHT);
            make.right.equalTo(self.navView).inset(10);
        }];
        [self.navView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerY.equalTo(deleteBtn);
            make.centerX.equalTo(self.navView);
            make.height.equalTo(@44);
        }];
    }
    return self;
}

- (void)backAction {
    [LBPhotoBrowserManager defaultManager].isPublishPreview = NO;
    UITapGestureRecognizer *tap = [LBPhotoBrowserManager defaultManager].tapArray[0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LBPhotoCollectionViewCellDismiss" object:tap];
}

- (void)deleteAction {
    [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([LBPhotoBrowserManager defaultManager].currentPage == idx) {
            [self.dataArr removeObjectAtIndex:idx];
            [self removeReloadImages:self.dataArr andSeletedIndex:(int)idx];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bigImageVideDelete" object:@(idx)];
            *stop = YES;
            return;
        }
    }];
}

- (void)didPan:(UIPanGestureRecognizer *)pan {
    self.isHideNavView = YES;
    CGPoint location = [pan locationInView:self];
    CGPoint point = [pan translationInView:self];
    LBPhotoCollectionViewCell *cell = (LBPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.pageControl.currentPage inSection:0]];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _startPoint = location;
            self.tag = 0;
            _zoomScale = cell.zoomScrollView.zoomScale;
            _startCenter = cell.zoomScrollView.imageView.center;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (location.y - _startPoint.y < 0 && self.tag == 0) {
                return;
            }
            cell.zoomScrollView.imageViewIsMoving = YES;
            double percent = 1 - fabs(point.y) / self.frame.size.height;// 移动距离 / 整个屏幕
            double scalePercent = MAX(percent, 0.3);
            if (location.y - _startPoint.y < 0) {
                scalePercent = 1.0 * _zoomScale;
            }else {
                scalePercent = _zoomScale * scalePercent;
            }
            CGAffineTransform scale = CGAffineTransformMakeScale(scalePercent, scalePercent);
            cell.zoomScrollView.imageView.transform = scale;
            cell.zoomScrollView.imageView.center = CGPointMake(self.startCenter.x + point.x, self.startCenter.y + point.y);
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:scalePercent / _zoomScale];
            self.tag = 1;
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (point.y > 100 ) {
                [self dismissFromCell:cell];
            }else {
                [self cancelFromCell:cell];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)dismissFromCell:(LBPhotoCollectionViewCell *)cell {
    [cell.zoomScrollView handlesingleTap:CGPointZero];
}

- (void)cancelFromCell:(LBPhotoCollectionViewCell *)cell {
    weak_self;
    CGAffineTransform scale = CGAffineTransformMakeScale(_zoomScale , _zoomScale);
    [UIView animateWithDuration:0.25 animations:^{
        cell.zoomScrollView.imageView.transform = scale;
        wself.backgroundColor = [UIColor blackColor];
        cell.zoomScrollView.imageView.center = wself.startCenter;
    }completion:^(BOOL finished) {
        cell.zoomScrollView.imageViewIsMoving = NO;
        [cell.zoomScrollView layoutSubviews];

    }];
}

#pragma mark - 监听通知

- (void)removePageControl {
    [UIView animateWithDuration:0.25 animations:^{
        self.pageControl.alpha = 0;
    }completion:^(BOOL finished) {
        [self.pageControl removeFromSuperview];
    }];
    if (![LBPhotoBrowserManager defaultManager].needPreloading) {
        return;
    }
    [self.loadingImageModelDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LBScrollViewStatusModel *model = (LBScrollViewStatusModel *)obj;
        if (model.opreation) {
            [model.opreation cancel];
        }
    }];
}

- (void)showImageViewsWithURLs:(LBUrlsMutableArray *)urls andSelectedIndex:(int)index{
    _dataArr = urls;
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
    self.pageControl.bottom = SCREEN_HEIGHT - 50;
    self.pageControl.hidden = urls.count == 1? YES:NO;
    [self.models removeAllObjects];
    for (int i = 0 ; i < _dataArr.count; i++) {
        LBScrollViewStatusModel *model = [[LBScrollViewStatusModel alloc]init];
        model.showPopAnimation = i == index ? YES:NO;
        model.isShowing = i == index ? YES:NO;
        model.url = _dataArr[i];
        model.index = i;
        if (self.PictureThumbnailsArray.count>0) {
            model.easyUrl = self.PictureThumbnailsArray[i];
        }
       
        [self.models addObject:model];
    }
    self.collectionView.alwaysBounceHorizontal = urls.count == 1? NO : YES;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)showImageViewsWithImages:(LBImagesMutableArray *)images andSeletedIndex:(int)index {
    _dataArr = images;
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
    self.pageControl.bottom = SCREEN_HEIGHT - 50;
    self.pageControl.hidden = images.count == 1? YES:NO;
    [self.models removeAllObjects];
    for (int i = 0 ; i < images.count; i++) {
        LBScrollViewStatusModel *model = [[LBScrollViewStatusModel alloc]init];
        model.showPopAnimation = i == index ? YES:NO;
        model.isShowing = i == index ? YES:NO;
        model.currentPageImage = images[i];
        model.index = i;
        model.isLocalImage = YES;
        [self.models addObject:model];
    }
    self.collectionView.alwaysBounceHorizontal = images.count == 1? NO : YES;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self updateTitle];
}

- (void)removeReloadImages:(LBImagesMutableArray *)images andSeletedIndex:(int)index {
    if (images.count == 0) {
        [self backAction];
        return;
    }
    _dataArr = images;
    self.pageControl.hidden = images.count == 1? YES:NO;
    [self.models removeAllObjects];
    for (int i = 0 ; i < images.count; i++) {
        LBScrollViewStatusModel *model = [[LBScrollViewStatusModel alloc]init];
        model.showPopAnimation = NO;
        model.isShowing = i == index ? YES:NO;
        model.currentPageImage = images[i];
        model.index = i;
        model.isLocalImage = YES;
        [self.models addObject:model];
    }
    self.collectionView.alwaysBounceHorizontal = images.count == 1? NO : YES;
    [self.collectionView reloadData];
    if (index > 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [self updateTitle];
}

#pragma mark - collectionView的数据源&代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_dataArr) {
        return _dataArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = NSStringFromClass([LBPhotoCollectionViewCell class]);
    LBPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.panAction = ^(NSInteger count) {
        if (count == 1) {
            self.isHideNavView = !self.isHideNavView;
        }else {
            
        }
    };
    return cell;
}
#pragma mark - 代理方法

// 新版的SDWebImage不知支持Gif 故采用了老版Gif的方式 但是这样加载太多Gif内存容易升高 在收到内存警告的时候 可以通过这个来清理内存 [[SDImageCache sharedImageCache] clearMemory];

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH + itemSpace, SCREEN_HEIGHT);
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    weak_self;
    LBPhotoCollectionViewCell *currentCell = (LBPhotoCollectionViewCell *)cell;
    LBScrollViewStatusModel *model = self.models[indexPath.item];
    model.currentPageImage = model.currentPageImage ?:[self getCacheImageForModel:model];
    // 需要展示动画的话 展示动画
    if (model.showPopAnimation) {
        [currentCell startPopAnimationWithModel:model completionBlock:^{
            wself.isShowing = YES;
            model.showPopAnimation = NO;
            [wself collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
        }];
    }
//    if (_isShowing == NO) return;
    currentCell.model = model;
    if (model.currentPageImage && model.currentPageImage.images.count >0) {
        [self scrollViewDidScroll:collectionView];
    }
    if ([self.dataArr.firstObject isKindOfClass:[UIImage class]]) return;
    
    if (![LBPhotoBrowserManager defaultManager].needPreloading) return;
    
    dispatch_async(wself.preloadingQueue, ^{
        int leftCellIndex = model.index - 1 >= 0 ?model.index - 1:0;
        int rightCellIndex = model.index + 1 < wself.models.count? model.index + 1 : (int)wself.models.count -1;
        //wself.loadingImageModels 新计算出的需要加载的 -- > 如果个原来的没有重合的 --> 取消
        [wself.preloadingModelDic removeAllObjects];
        NSMutableDictionary *indexDic = wself.preloadingModelDic; // 采用全局的字典 减少快速切换时 重复创建消耗性能的问题
        indexDic[[NSString stringWithFormat:@"%d",leftCellIndex]] = @1;
        indexDic[[NSString stringWithFormat:@"%d",model.index]] = @1;
        indexDic[[NSString stringWithFormat:@"%d",rightCellIndex]] = @1;

        for (NSString *indexStr in wself.loadingImageModelDic.allKeys) {
            if (indexDic[indexStr]) continue;
            LBScrollViewStatusModel *loadingModel = wself.loadingImageModelDic[indexStr];
            if (loadingModel.opreation) {
                [loadingModel.opreation cancel];
                loadingModel.opreation = nil;
            }
        }
        [wself.loadingImageModelDic removeAllObjects];
        for (int i = leftCellIndex; i <= rightCellIndex; i++) {
            LBScrollViewStatusModel *loadingModel = wself.models[i];
            NSString *indexStr = [NSString stringWithFormat:@"%d",i];
            wself.loadingImageModelDic[indexStr] = loadingModel;
            if (model.index == i) continue;
            LBScrollViewStatusModel *preloadingModel = wself.models[i];
            preloadingModel.currentPageImage = preloadingModel.currentPageImage ?:[wself getCacheImageForModel:preloadingModel];
            if (preloadingModel.currentPageImage) continue;
            [preloadingModel loadImage];
        }
    });

}


#pragma mark - 处理cell中图片的显示

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.collectionView.width;
    int page = floor((self.collectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self refreshStatusWithPage:page];
    self.pageControl.currentPage = page;
    [LBPhotoBrowserManager defaultManager].currentPage = page;
    LBPhotoCollectionViewCell *cell = (LBPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0]];
    if (![scrollView isKindOfClass:[UIScrollView class]]) {
        LBPhotoBrowserManager.defaultManager.currentShowImageView = nil;
    }
    LBPhotoBrowserManager.defaultManager.currentShowImageView = cell.zoomScrollView.imageView;
    
    [self updateTitle];
    self.isHideNavView = YES;
}

- (void)refreshStatusWithPage:(int)page {
    if (page == self.pageControl.currentPage ) {
        return;
    }
    [self changeModelOfCellInRow:page];
    
}

#pragma mark - 获取URL的缓存图片

- (UIImage *)getCacheImageForModel:(LBScrollViewStatusModel *)model {
    __block UIImage *localImage = nil;
    LBPhotoBrowserManager *mgr = [LBPhotoBrowserManager defaultManager];
    NSString *address = model.url.absoluteString;
    localImage =  [[SDImageCache sharedImageCache] imageFromCacheForKey:address];
    
    if (localImage && localImage.images.count > 0) {//gif 图片
        if (mgr.lowGifMemory == YES) {
            return localImage;
        }else{
            [[SDImageCache sharedImageCache] queryCacheOperationForKey: model.url.absoluteString done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
                localImage = [UIImage sdOverdue_animatedGIFWithData:data];
            }];
            return localImage;
        }
    }else if (localImage) { // 图片存在
        return localImage;
    }
    return nil;
}

#pragma mark - 修改cell子控件的状态 的状态

- (void)changeModelOfCellInRow:(int)row {
    for (LBScrollViewStatusModel *model in self.models) {
        model.isShowing = NO;
    }
    if (row >= 0 && row < self.models.count) {
        LBScrollViewStatusModel *model = self.models[row];
        model.isShowing = YES;
    }
}
@end

