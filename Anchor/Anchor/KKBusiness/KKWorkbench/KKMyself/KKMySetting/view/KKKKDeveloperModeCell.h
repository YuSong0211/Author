//
//  KKKKDeveloperModeCell.h
//  mt
//
//  Created by Gwynne on 2021/10/19.
//

#import "KKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKKKDeveloperModeCell : KKBaseTableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *valueLabel;
@property (nonatomic,strong) UIImageView *arrowsView;

@end

NS_ASSUME_NONNULL_END
