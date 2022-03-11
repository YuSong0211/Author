//
//  KKSegmentedViewController.h
//  KK
//
//  Created by Gwynne on 2021/8/6.
//

#import "KKSecondBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKSegmentedViewController : KKSecondBaseVC<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>

@property (nonatomic,strong) SGPageContentScrollView *pageContentView;

@property (nonatomic,strong) SGPageTitleView *titleView;

- (SGPageTitleViewConfigure *)configTitleViewConfigur;

- (NSArray <UIViewController *>*)childViewControllerArray;

- (NSArray <NSString *>*)titleArray;

@property (nonatomic,assign) BOOL isCenterShow;

@end

NS_ASSUME_NONNULL_END
