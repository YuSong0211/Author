//
//  KKPushSelectMediaCell.h
//  mt
//
//  Created by 小草 on 2021/9/14.
// 选择图片视频的cell

#import <UIKit/UIKit.h>
#import "KKPublishSelectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKPushSelectMediaCell : UICollectionViewCell

@property (nonatomic,strong) KKPublishSelectModel * model;

@property (nonatomic,assign) NSInteger mediaCount; // 媒体个数

@end

NS_ASSUME_NONNULL_END
