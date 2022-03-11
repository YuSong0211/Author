//
//  MineHeaderView.h
//  KK
//
//  Created by 小草 on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "MineHeaderMsgView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView : UIView

// 头部icon
@property (nonatomic,strong) UIImageView * headerIcon;

// 头部信息视图
@property (nonatomic,strong) MineHeaderMsgView * headerMsgView;

// 底部背景
@property (nonatomic,strong) UIView * bottomView;

-(void)resetFrame;

@end

NS_ASSUME_NONNULL_END
