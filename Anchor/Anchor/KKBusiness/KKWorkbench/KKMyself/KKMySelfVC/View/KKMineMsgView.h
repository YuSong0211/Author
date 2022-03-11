//
//  KKMineMsgView.h
//  KK
//
//  Created by 小草 on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKMineMsgView : UIView

@property (nonatomic,assign) NSInteger unReadTotalCount;

@property (nonatomic,assign) BOOL isShowCount; // 是否显示个数，NO显示红点

@end

NS_ASSUME_NONNULL_END
