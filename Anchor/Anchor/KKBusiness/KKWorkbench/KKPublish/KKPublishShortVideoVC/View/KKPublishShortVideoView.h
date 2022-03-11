//
//  KKPublishView.h
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "KKPublishShortVideoViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface KKPublishShortVideoView : UIView
@property (nonatomic, strong) NSMutableArray *tagDataArray;
@property (nonatomic,copy) void (^selectTagBlock)(NSMutableArray *selecteArray);
@property (nonatomic,copy) void (^selectVideoBlock)(UIButton *btn);
@property (nonatomic,copy) void (^didsKeepTitleBlock)(void);
@property (nonatomic, strong) UIButton *selectVideoBtn;
@property (nonatomic, copy) NSString *videoPath;
@property (nonatomic, strong)UIImage *selectImage;
@property (nonatomic, strong)UIImage *firstselectImage;
@property (nonatomic, assign) BOOL isSelectVideo;
@property (nonatomic, assign)NSInteger selectPageIndex;
@property (nonatomic, strong) UIScrollView *shortBackGroundView;
@property (nonatomic, weak) id<KKPublishShortVideoViewDelegate>delegate; // 代理
@property (nonatomic,assign) CGFloat currentUploadProgress;

-(void)dismisView;

-(void)dismissProgressView;

@end

NS_ASSUME_NONNULL_END
