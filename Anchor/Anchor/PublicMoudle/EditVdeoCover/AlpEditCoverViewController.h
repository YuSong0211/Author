//
//  AlpEditCoverViewController.h
//  Alpface
//
//  Created by xiaoyuan on 2018/9/27.
//  Copyright © 2018 alpface. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKSecondBaseVC.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AlpEditCoverViewControllerDelegate;

@interface AlpEditCoverViewController : KKSecondBaseVC

@property (nonatomic, weak) id<AlpEditCoverViewControllerDelegate> delegate;

@property(nonatomic, copy) NSURL *videoURL;
@property(nonatomic, copy) void (^releseButtonBlock) (UIImage *selectImage,CGFloat time,CGFloat thumbLocation);
@property (nonatomic, assign) CGFloat clipTime;  // 选取封面的时间
@property (nonatomic, strong) UIImage *clipSelectImage;  // 选取封面的图片
@property (nonatomic, assign) CGFloat thumbLocation; // 选取封面后 进度条上滑块的位置
@end

NS_ASSUME_NONNULL_END

@protocol AlpEditCoverViewControllerDelegate <NSObject>

@optional

/// 用户选择封面的回调
/// @param controller AlpEditCoverViewController
/// @param start 封面的起始时间 单位为秒
/// @param end 封面的结束时间 单位为秒
- (void)editCoverViewController:(nullable AlpEditCoverViewController *)controller didChangeCoverWithStartTime:(CGFloat)start endTime:(CGFloat)end;

@end
