//
//  BaseCollectionView.m
//  KK
//
//  Created by hk on 2021/8/5.
//

#import "BaseCollectionView.h"


@interface BaseCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
    
//cell 基类
@property(nonatomic,strong) Class cellClass ;
    

@end

//操作的实现collectionview
@implementation BaseCollectionView
    

//创建baseView
-(void)createCollectionViewWithFream:(CGRect)fream
                                    :(Class)cellClass{
    self.cellClass = cellClass;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 8;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self createCollectionViewWithFlowLayout:flowLayout:fream];
}

//创建baseview
-(void)createCollectionViewWithFlowLayout:(UICollectionViewFlowLayout*)flowLayout
                                         :(CGRect)fream{
    self.collectionView = [[UICollectionView alloc]initWithFrame:fream collectionViewLayout:flowLayout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = KKMainColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource=self;
    self.identifier =NSStringFromClass(self.cellClass);
    [self.collectionView registerClass:self.cellClass forCellWithReuseIdentifier:self.identifier];
    KKRefreshHeader *header = [KKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.collectionView.mj_header = header;
    [header beginRefreshing];
    KKRefreshFooter *footer = [KKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer = footer;
}
 

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KK_SCREEN_WIDTH-38)/2, 225);
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

 

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
