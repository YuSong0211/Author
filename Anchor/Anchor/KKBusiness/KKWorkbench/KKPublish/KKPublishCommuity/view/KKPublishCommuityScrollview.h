//
//  KKPublishCommuityScrollview.h
//  mt
//
//  Created by 小草 on 2021/9/14.
//

#import <UIKit/UIKit.h>
#import "KKPublishShortVideoViewDelegate.h"
#import "UITextView+Placeholder.h" // 输入框的扩展
#import "UICollectionViewLeftAlignedLayout.h" // Layout
#import "KKPushMidiaCollectionViewCell.h" // 显示媒体资源
#import "KKPushSelectMediaCell.h" // 显示选择icon
#import "KKPublishSelectModel.h" // 选择model
#import "AlpVideoSliderTimeClip.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKPublishCommuityScrollview : UIView

@property (nonatomic,strong) UIScrollView * scrollview; // 滚动视图

@property (nonatomic,strong) UITextView * contentInputView; // 文本输入框

@property (nonatomic,strong) UILabel * selectMediaLab; // 选择媒体标签

@property (nonatomic,strong) UIButton * deleteAll; // 全部删除按钮

@property (nonatomic,strong) UICollectionView * collectionView; // 瀑布流

@property (nonatomic,strong) NSMutableArray * mediaArray; // 数据源

@property (nonatomic,strong) KKPublishSelectModel * selectImageModel; // 选择图片model
@property (nonatomic,strong) KKPublishSelectModel * selectVideoModel; // 选择视频model

@property (nonatomic,assign) NSInteger mediaCount; // 媒体个数
@property (nonatomic,strong) NSString * videoPath; // 视频地址

@property (nonatomic,strong) UIButton * releaseButton; // 发布按钮
@property (nonatomic,strong) NSMutableArray *tagsArr;

@property (nonatomic, weak) id<KKPublishShortVideoViewDelegate>delegate; // 代理

@end

NS_ASSUME_NONNULL_END
