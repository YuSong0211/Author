//
//  CollectionViewTools.h
//  KK
//
//  Created by hk on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//列表通用控制器
@interface CollectionViewTools : NSObject
    
//容器
@property (strong,nonatomic)UICollectionViewFlowLayout* flowLayout;

//view
@property(strong,nonatomic)UICollectionView *collectionView;


-(void)createViewWithFream;

@end

NS_ASSUME_NONNULL_END
