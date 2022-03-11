//
//  KKRefreshHeader.m
//  KK
//
//  Created by Gwynne on 2021/7/7.
//

#import "KKRefreshHeader.h"
#import "KKLoadingView.h"
#import "KKSytemShock.h"

@interface KKRefreshHeader()

@property (nonatomic,strong) KKLoadingView *loadingView;

@end

@implementation KKRefreshHeader

- (void)prepare {
    [super prepare];
    // 关闭下拉后的回弹动画
    [self setAnimationDisabled];
    self.loadingView = [[KKLoadingView alloc] init];
    [self addSubview:self.loadingView];
}

- (void)placeSubviews {
    [super placeSubviews];
    self.loadingView.frame = self.bounds;
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state == MJRefreshStateIdle) {
        // 当前滑动的值
        CGPoint offsetPoint = [change[@"new"] CGPointValue];
        // 头部控件刚好出现的offsetY
        CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
        
        // 取绝对值 offsetPoint 给的是负数
        if (fabs(offsetPoint.y)>= self.loadingView.ballShowHeight && fabs(offsetPoint.y)<= fabs(normal2pullingOffsetY)) {
            // 判断 normal2pullingOffsetY 与 小球的高度 相差多少
            CGFloat margin = (fabs(normal2pullingOffsetY) - self.loadingView.ballShowHeight)/10;
            // 得到 2 - 7.5 数值
            CGFloat offsetSpeed =  fabs(offsetPoint.y) / 10 - (self.loadingView.ballShowHeight)/10;
            // 小球移动的距离最多的15像素
            self.loadingView.refeshSpeed = offsetSpeed*(self.loadingView.ballCenterMargin/margin);
        }
    }else if (self.state == MJRefreshStatePulling){
        // 传成13没有问题，这是取的初始化时第二个小球的center.x
        self.loadingView.refeshSpeed = 13;
    }
}

//- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
//{
//    [super scrollViewContentOffsetDidChange:change];
//
//    // 当前滑动的值
//    CGPoint offsetPoint = [change[@"new"] CGPointValue];
//    // 取绝对值 offsetPoint 给的是负数
//    if (fabs(offsetPoint.y)>=30 && fabs(offsetPoint.y)<= 60) {
//        // 得到 2 - 7.5 数值
//        CGFloat offsetSpeed =  fabs(offsetPoint.y) / 10 - 3;
//        // 小球移动的距离最多的15像素
//        self.loadingView.refeshSpeed = offsetSpeed*(self.loadingView.ballCenterMargin/3.f);
//    }
//}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
//    NSLog(@"%@",change);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            [self.loadingView stopLoading];
//            NSLog(@"MJRefreshStateIdle - 闲置");
            break;
        case MJRefreshStatePulling:
            [KKSytemShock openShockLight];
            self.footer.state = MJRefreshStateIdle;
//            NSLog(@"MJRefreshStatePulling - 下拉 震动反馈");
            break;
        case MJRefreshStateRefreshing:
//            NSLog(@"MJRefreshStateRefreshing - 刷新中 - 执行动画");
            [self.loadingView startLoading];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}

@end




@interface KKRefreshFooter()

@property (nonatomic,strong) KKLoadingView *loadingView;



@end

@implementation KKRefreshFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    self.loadingView = [[KKLoadingView alloc] init];
    [self addSubview:self.loadingView];
    
    self.noMoreDataLab = [[UILabel alloc]init];
    self.noMoreDataLab.text = @"暂时没有更多了";
    self.noMoreDataLab.font = [UIFont regularWithSize:15];
    self.noMoreDataLab.textColor = [KKColor getColor:appHintTextColor];
    self.noMoreDataLab.textAlignment = NSTextAlignmentCenter;
    self.noMoreDataLab.hidden = YES;
    [self addSubview:self.noMoreDataLab];
    
}


-(void)hiddenLab{
    self.noMoreDataLab.hidden = YES;
}
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.loadingView.frame = self.bounds;
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
    }];

    [self.noMoreDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(25);
    }];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loadingView stopLoading];
            self.loadingView.hidden = YES;
            self.noMoreDataLab.hidden = YES;
            break;
        case MJRefreshStateRefreshing:
            self.noMoreDataLab.hidden = YES;
            self.loadingView.hidden = NO;
            [self.loadingView startLoading];
            break;
        case MJRefreshStateNoMoreData:
            self.loadingView.hidden = YES;
            self.noMoreDataLab.hidden = NO;
            [self.loadingView stopLoading];
            break;
        default:
            break;
    }
}


-(void)removeLoadingView{
}
@end
