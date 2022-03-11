//
//  KKLoadingView.m
//  TestLoadingDemo
//
//  Created by 小草 on 2021/7/7.
//

#import "KKLoadingView.h"

// 球宽
static CGFloat BallWidth = 12.0f;
// 球缩放比例
static CGFloat BallZoomScale = 0.25;
// 暂停时间 s
static CGFloat PauseSecond = 1.0;

//球的运动方向，以绿球向右、红球向左运动为正向，
typedef NS_ENUM(NSInteger, BallMoveDirection) {
    //正向
    BallMoveDirectionPositive = 1,
    //逆向
    BallMoveDirectionNegative = -1,
};

@interface KKLoadingView ()

// 球的容器
@property (nonatomic, strong) UIView *ballContainer;
// 绿球
@property (nonatomic, strong) UIView *greenBall;
// 红球
@property (nonatomic, strong) UIView *redBall;
// 黑球
@property (nonatomic, strong) UIView *blackBall;
// 刷新器
@property (nonatomic, strong) CADisplayLink *displayLink;
//移动方向
@property (nonatomic, assign) BallMoveDirection ballMoveDirection;

@end

@implementation KKLoadingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.ballSpeed = 0.9;
        [self createUI];
    }
    return self;
}

// 创建UI
-(void)createUI{
    self.ballContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.1*BallWidth, 2*BallWidth)];
    self.ballContainer.center = [self center];
    [self addSubview:self.ballContainer];
    [self.ballContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.height.equalTo(@(2*BallWidth));
        make.width.equalTo(@(2.1*BallWidth));
    }];
    
    self.greenBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BallWidth, BallWidth)];
    self.greenBall.center = CGPointMake(BallWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    self.greenBall.layer.cornerRadius = BallWidth/2.0f;
    self.greenBall.layer.masksToBounds = true;
    //self.greenBall.backgroundColor = KKRGBA(62, 144, 246, 1);
    self.greenBall.backgroundColor = [KKColor getColor:colorLoadingRight];
    [self.ballContainer addSubview:self.greenBall];
    
    self.redBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BallWidth, BallWidth)];
    self.redBall.center = CGPointMake(self.ballContainer.bounds.size.width - BallWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    self.redBall.layer.cornerRadius = BallWidth/2.0f;
    self.redBall.layer.masksToBounds = true;
    //self.redBall.backgroundColor = KKRGBA(114, 238, 193, 1);
    self.redBall.backgroundColor = [KKColor getColor:colorLoadingLeft];
    [self.ballContainer addSubview:self.redBall];
    
    //第一次动画是正向，绿球在上，红球在下，阴影会显示在绿球上
    self.blackBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BallWidth, BallWidth)];
    self.blackBall.backgroundColor = [UIColor colorWithRed:12/255.0f green:11/255.0f blue:17/255.0f alpha:1];
    self.blackBall.layer.cornerRadius = BallWidth/2.0f;
    self.blackBall.layer.masksToBounds = true;
    self.blackBall.hidden = YES;
    [self.greenBall addSubview:self.blackBall];
    
    //初始化方向是正向
    self.ballMoveDirection = BallMoveDirectionPositive;
    
    // 记录两个小球中间的间距
    self.ballCenterMargin = self.redBall.center.x - self.greenBall.center.x;
    
    // 小球完全显示的出来后的数值 从下往上计算的
    //self.ballShowHeight = self.ballContainer.frame.size.height/2 + (BallWidth/2);
    self.ballShowHeight = 2*BallWidth;
}

// 显示
+(instancetype)showInView:(UIView *)view{
    KKLoadingView * loadingView = [[KKLoadingView alloc]initWithFrame:view.bounds];
    [view addSubview:loadingView];
    [loadingView startLoading];
    return loadingView;
}

// 显示
+(instancetype)showInView:(UIView *)view withFrame:(CGRect)frame{
    KKLoadingView * loadingView = [[KKLoadingView alloc]initWithFrame:frame];
    loadingView.tag = 99001;
    [view addSubview:loadingView];
    [loadingView startLoading];
    return loadingView;
}

// 显示
+(instancetype)showInCommunityDetailView:(UIView *)view{
    KKLoadingView * loadingView = [[KKLoadingView alloc]init];
    loadingView.tag = 99001;
    [view addSubview:loadingView];
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.bottom.equalTo(view.mas_bottom).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [loadingView startLoading];
    return loadingView;
}

// 显示
+(instancetype)showInViewTop:(UIView *)view{
    KKLoadingView * loadingView = [[KKLoadingView alloc]initWithFrame:view.bounds];
    [view addSubview:loadingView];
    [loadingView startLoading];
    return loadingView;
}

// 隐藏
+(BOOL)hideInView:(UIView *)view{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            KKLoadingView *loading = (KKLoadingView *)subview;
            [loading stopLoading];
            [loading removeFromSuperview];
            return YES;
        }
    }
    return NO;
}

// 全屏（window全屏）
+ (instancetype)showFullScreen{
    KKLoadingView * loadingView = [[KKLoadingView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    loadingView.tag = 99001;
    [KK_GET_WINDOWS addSubview:loadingView];
    [loadingView startLoading];
    return loadingView;
}

// 本视图只占两个小球的大小
+ (instancetype)showView{
    CGFloat widthHeight = 60;
    KKLoadingView * loadingView = [[KKLoadingView alloc]initWithFrame:CGRectMake((KK_SCREEN_WIDTH-widthHeight)/2, (KK_SCREEN_HEIGHT - widthHeight)/2, widthHeight, widthHeight)];
    loadingView.tag = 99001;
    [KK_GET_WINDOWS addSubview:loadingView];
    [loadingView startLoading];
    return loadingView;
}

// 隐藏
+(void)hidden{
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        KKLoadingView * loadingView = [window viewWithTag:99001];
        if (loadingView) {
            [loadingView stopLoading];
            [loadingView removeFromSuperview];
//            break;
        }
    }
}



-(void)setRefeshSpeed:(CGFloat)refeshSpeed{
    _refeshSpeed = refeshSpeed;
    self.blackBall.hidden = NO;
    // 更新红球位置
    CGPoint greenCenter = CGPointMake(6 + refeshSpeed, self.ballContainer.bounds.size.height/2.0f);
    self.greenBall.center = greenCenter;
    
    // 更新绿球位置
    CGPoint redCenter = CGPointMake(19 - refeshSpeed, self.ballContainer.bounds.size.height/2.0f);
    self.redBall.center = redCenter;
    
    //缩放动画,绿球放大 红球变小
    self.greenBall.transform = [self ballLargerTransformOfCenterX:greenCenter.x==self.ballContainer.center.x?redCenter.x:greenCenter.x];
    self.redBall.transform = [self ballSmallerTransformOfCenterX:redCenter.x];
    
    // 更新黑球位置
    CGRect blackBallFrame = [self.redBall convertRect:self.redBall.bounds toCoordinateSpace:self.greenBall];
    self.blackBall.frame = blackBallFrame;
    self.blackBall.layer.cornerRadius = self.blackBall.bounds.size.width/2.0f;
    
    // 判断红绿两球是否有了交集
    
    //if (greenCenter.x == self.ballContainer.center.x) {
    //}
    //if (CGRectGetMinX(self.redBall.frame) <= 0) {
    [self.ballContainer bringSubviewToFront:self.greenBall];
    [self.greenBall addSubview:self.blackBall];
    self.ballMoveDirection = BallMoveDirectionNegative;
    //}else{
    //        self.ballMoveDirection = BallMoveDirectionPositive;
    //    }
}

// 初始化
-(void)resetLoadingView{
    // 复原
     self.blackBall.hidden = YES;
    self.greenBall.center = CGPointMake(BallWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    self.redBall.center = CGPointMake(self.ballContainer.bounds.size.width - BallWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    // 清除缩放
    self.blackBall.transform =  CGAffineTransformIdentity;
    self.redBall.transform =   CGAffineTransformIdentity;
    self.ballMoveDirection = BallMoveDirectionPositive;
    
    //正向运动时，绿球在上，红球在下
    [self.ballContainer bringSubviewToFront:self.greenBall];
    //黑球放在绿球上面
    [self.greenBall addSubview:self.blackBall];
}

// 开始动画
-(void)startLoading{
    [self.displayLink invalidate];
    self.displayLink = nil;
    //初始化刷新方法
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateBallAnimations)];
    [self startAnimated];
}

// 结束动画
-(void)stopLoading{
    [self.displayLink invalidate];
    self.displayLink = nil;
    [self resetLoadingView];
}

// 开始动画
- (void)startAnimated {
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.displayLink.paused = NO;
}

// 结束
- (void)stopAnimated {
    if (self.displayLink) {
        [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }

}

// 暂停
- (void)pauseAnimated {
    [self stopAnimated];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(PauseSecond*NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self startAnimated];
    });
}

// 更新动画
- (void)updateBallAnimations {
    self.blackBall.hidden = NO;
    
    
    if (self.ballMoveDirection == BallMoveDirectionPositive) {//正向运动
        //更新绿球位置
        CGPoint center = self.greenBall.center;
        //center.x += self.ballSpeed;
        center.x += self.ballSpeed;
        self.greenBall.center = center;
        
        //更新红球位置
        center = self.redBall.center;
        center.x -= self.ballSpeed;
        self.redBall.center = center;
        
        //缩放动画,绿球放大 红球变小
        self.greenBall.transform = [self ballLargerTransformOfCenterX:center.x];
        self.redBall.transform = [self ballSmallerTransformOfCenterX:center.x];
        
        //更新黑球位置
        CGRect blackBallFrame = [self.redBall convertRect:self.redBall.bounds toCoordinateSpace:self.greenBall];
        self.blackBall.frame = blackBallFrame;
        self.blackBall.layer.cornerRadius = self.blackBall.bounds.size.width/2.0f;
        
        //更新方向+改变三个球的相对位置
        if (CGRectGetMaxX(self.greenBall.frame) >= self.ballContainer.bounds.size.width || CGRectGetMinX(self.redBall.frame) <= 0) {
            //切换为反向
            self.ballMoveDirection = BallMoveDirectionNegative;
            //反向运动时，红球在上，绿球在下
            [self.ballContainer bringSubviewToFront:self.redBall];
            //黑球放在红球上面
            [self.redBall addSubview:self.blackBall];
            //暂停一下
            [self pauseAnimated];
        }
    }else if (self.ballMoveDirection == BallMoveDirectionNegative) {//反向运动
        //更新绿球位置
        CGPoint center = self.greenBall.center;
        center.x -= self.ballSpeed;
        self.greenBall.center = center;
        
        //更新红球位置
        center = self.redBall.center;
        center.x += self.ballSpeed;
        self.redBall.center = center;
        
        //缩放动画,红球放大 绿/黑球变小
        self.redBall.transform = [self ballLargerTransformOfCenterX:center.x];
        self.greenBall.transform = [self ballSmallerTransformOfCenterX:center.x];
        
        //更新黑球位置
        CGRect blackBallFrame = [self.greenBall convertRect:self.greenBall.bounds toCoordinateSpace:self.redBall];
        self.blackBall.frame = blackBallFrame;
        self.blackBall.layer.cornerRadius = self.blackBall.bounds.size.width/2.0f;
        
        //更新方向+改变三个球的相对位置
        if (CGRectGetMinX(self.greenBall.frame) <= 0 || CGRectGetMaxX(self.redBall.frame) >= self.ballContainer.bounds.size.width) {
            //切换为正向
            self.ballMoveDirection = BallMoveDirectionPositive;
            //正向运动时，绿球在上，红球在下
            [self.ballContainer bringSubviewToFront:self.greenBall];
            //黑球放在绿球上面
            [self.greenBall addSubview:self.blackBall];
            //暂停动画
            if (self.displayLink !=nil) {
                [self pauseAnimated];
            }
            
        }
    }
    
}

//放大动画
- (CGAffineTransform)ballLargerTransformOfCenterX:(CGFloat)centerX {
    CGFloat cosValue = [self cosValueOfCenterX:centerX];
    return CGAffineTransformMakeScale(1 + cosValue*BallZoomScale, 1 + cosValue*BallZoomScale);
}

//缩小动画
- (CGAffineTransform)ballSmallerTransformOfCenterX:(CGFloat)centerX {
    CGFloat cosValue = [self cosValueOfCenterX:centerX];
    return CGAffineTransformMakeScale(1 - cosValue*BallZoomScale, 1 - cosValue*BallZoomScale);
}

//根据余弦函数获取变化区间 变化范围是0~1~0
- (CGFloat)cosValueOfCenterX:(CGFloat)centerX {
    CGFloat apart = centerX - self.ballContainer.bounds.size.width/2.0f;
    //最大距离(球心距离Container中心距离)
    CGFloat maxAppart = (self.ballContainer.bounds.size.width - BallWidth)/2.0f;
    //移动距离和最大距离的比例
    CGFloat angle = apart/maxAppart*M_PI_2;
    //获取比例对应余弦曲线的Y值
    return cos(angle);
}
@end
