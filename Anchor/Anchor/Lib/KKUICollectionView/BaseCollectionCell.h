//
//  BaseCollectionCell.h
//  KK
//
//  Created by hk on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionCell : UICollectionViewCell

//model
@property (strong,nonatomic) id cellModel;

- (void)setModel:(id)model;

- (void)initSubViews;

@end

NS_ASSUME_NONNULL_END
