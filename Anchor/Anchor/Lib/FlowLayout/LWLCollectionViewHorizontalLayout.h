//
//  DDCollectionViewHorizontalLayout.h
//  TestCollectionView
//
//  Created by 刘卫林 on 15/08/27.

#import <UIKit/UIKit.h>

@interface LWLCollectionViewHorizontalLayout : UICollectionViewFlowLayout
// 一页显示多少行
@property (nonatomic) NSUInteger itemCountPerRow;
// 显示几行
@property (nonatomic) NSUInteger rowCount;
//
@property (nonatomic) CGFloat collectionViewContentWidth;

@property (strong, nonatomic) NSMutableArray *allAttributes;

@end
