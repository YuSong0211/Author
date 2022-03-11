//
//  KKPushMidiaCollectionViewCell.h
//  mt
//
//  Created by 小草 on 2021/9/14.
//  展示选择的媒介样式

#import <UIKit/UIKit.h>
#import "KKPublishSelectModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^clickDeleteImage)(void);
typedef void(^clickDeleteVideo)(void);

@interface KKPushMidiaCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) KKPublishSelectModel * model;

@property (nonatomic,copy) clickDeleteImage deleteImageBlock; // 点击删除图片block
@property (nonatomic,copy) clickDeleteVideo deleteVideoBlock; // 点击删除视频block

@end

NS_ASSUME_NONNULL_END
