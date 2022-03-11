//
//  KKMysettingListView.h
//  KK
//
//  Created by 小草 on 2021/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKMysettingListView : UIView
@property (nonatomic,copy) void(^KKMysettingSwitchACcountBlock)(void);

@property (nonatomic,copy) void(^KKVersionBlock)(void);


@property (nonatomic,copy) void(^KKMysettingShareCodeBlock)(void);

@end

NS_ASSUME_NONNULL_END
