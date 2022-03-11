//
//  BaseCollectionView.h
//  KK
//
//  Created by hk on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionView : NSObject

//collectionView view
@property (nonatomic,strong) UICollectionView * collectionView;

//class
@property(nonatomic,strong)NSString* identifier;

//数据源
@property(nonatomic,strong)NSMutableArray* arrayList;


//创建view
-(void)createCollectionViewWithFream:(CGRect)fream
                                    :(Class)cellClass;


//创建view
-(void)createCollectionViewWithFlowLayout:(UICollectionViewFlowLayout*)flowLayout
                                         :(CGRect)fream;

//获取cell 大小重载
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


 
//返回数据
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
