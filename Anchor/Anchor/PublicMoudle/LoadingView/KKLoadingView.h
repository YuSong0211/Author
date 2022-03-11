//
//  KKLoadingView.h
//  TestLoadingDemo
//
//  Created by 小草 on 2021/7/7.
//

#import <UIKit/UIKit.h>


@interface KKLoadingView : UIView

// 显示
+(instancetype)showInView:(UIView *)view;
// 显示
+(instancetype)showInView:(UIView *)view withFrame:(CGRect)frame;
// 隐藏
+(BOOL)hideInView:(UIView *)view;


// 全屏（window全屏）
+ (instancetype)showFullScreen;

// 本视图只占两个小球的大小
+ (instancetype)showView;

// 隐藏
+(void)hidden;

// 初始化
-(void)resetLoadingView;

// 开始动画
-(void)startLoading;

// 结束动画
-(void)stopLoading;

// 开始动画
- (void)startAnimated;

// 结束
- (void)stopAnimated;

// 用户刷新没松手前，把offset.y 赋值给ballSpeed
@property (nonatomic,assign) CGFloat ballSpeed;

// 刷新时的拖拽数据
@property (nonatomic,assign) CGFloat refeshSpeed;

// 两个小球center的间距
@property (nonatomic,assign) CGFloat ballCenterMargin;

// 从底部往上计算，小球什么时候能完全露出，（此参数适用于下拉刷新）
@property (nonatomic,assign) CGFloat ballShowHeight;

// 显示
+(instancetype)showInCommunityDetailView:(UIView *)view;

@end

// 调用示例

// 显示
// [KKLoadingView showInView:self.view];
// 隐藏
// [KKLoadingView hideInView:self.view];
