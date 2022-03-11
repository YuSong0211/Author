//
//  MineTableviewCell.h
//  KK
//
//  Created by 小草 on 2021/6/25.
//

#import <UIKit/UIKit.h>
#import "MinCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineTableviewCell : UITableViewCell

@property (nonatomic,strong) MinCellModelDataSource * dataModel;

@end

NS_ASSUME_NONNULL_END
