//
//  KKMyLikeCollectionCell.h
//  KK
//
//  Created by 小草 on 2021/6/28.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface KKMyLikeCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * icon;
@property (nonatomic,strong) AvModel *model;
@property (nonatomic,strong) NSString *cellImageUrl;
@property (nonatomic,assign) NSInteger cellIndex;
@property (nonatomic,strong) UILabel *timeLab;
- (void)isShowsuspendView:(BOOL)isShow;
@property (nonatomic,copy) void(^imageConmendBlock)(NSString *imageUrl);

@property (nonatomic,strong) serviceexchangeLiveRoom * liveModel; // 直播数据

@end

NS_ASSUME_NONNULL_END
