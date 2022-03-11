//
//  AlpEditCoverViewController.m
//  Alpface
//
//  Created by xiaoyuan on 2018/9/27.
//  Copyright © 2018 alpface. All rights reserved.
//

#import "AlpEditCoverViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AlpVideoCameraUtils.h"
#import "AlpVideoCameraCoverSlider.h"
#import "AlpEditVideoNavigationBar.h"
#import "AlpVideoSliderTimeClip.h"
#import "AppDelegate.h"
#import "KKNavVC.h"

// 距离self.view的左右间距
#define COLLECTION_VIEW_LEFT 15

@interface AlpVideoCameraCoverPlayerView : UIView

@end

@interface AlpCoverImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end

@interface AlpEditCoverViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong)AlpVideoCameraCoverPlayerView *coverPlayerView;
@property(nonatomic,strong)UIImageView *defaultCoverBackGroundImageView;
@property(nonatomic,strong)UICollectionView *coverImageCollectionView;
@property(nonatomic,strong)UIScrollView *coverImageScrollView;
@property (nonatomic, strong) NSMutableArray<AlpVideoCameraCover *> *photoArrays;
@property (nonatomic, strong) AlpVideoCameraCoverSlider *slider;
@property (nonatomic, assign) CMTime coverTime;
@property (nonatomic, assign) CMTime videoTime;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *thumbPlayer;
@property (nonatomic, strong) AVPlayerItem *thumbPlayerItem;
@property (nonatomic, strong) AVPlayerItemVideoOutput * videoOutPut;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) AlpEditVideoNavigationBar *navigationBar;
@property (nonatomic, strong) UIView *releaseButtonBgView;
@property (nonatomic, strong) UIButton *releaseButton;
@property (nonatomic, assign) CMTime currentTime;
@property (nonatomic, strong) UIPanGestureRecognizer * pan;
@end


@implementation AlpEditCoverViewController
#pragma mark- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    return [self isInResponseToGesturesWith:point];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self.view];
    return [self isInResponseToGesturesWith:point];
}

//是否响应手势
- (BOOL)isInResponseToGesturesWith:(CGPoint)point {
    CGFloat y = self.coverImageCollectionView.frame.origin.y;
    CGFloat height = self.coverImageCollectionView.frame.size.height;
    if (point.y >= y && point.y <= y + height) {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择封面";
    self.photoArrays = [[NSMutableArray alloc] init];
    // 获取视频中帧数据图片
    [self getVideoTotalValueAndScale];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //次页面特殊需要总屏蔽全屏返回手势
    [self isProhibitFullScreenPopGestureRecognizer:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
    [_thumbPlayer pause];
    _thumbPlayer = nil;
    [self stopReplayTimer];
}

// 创建UI
- (void)setupUI {
    // 选定的封面
    _coverPlayerView = [[AlpVideoCameraCoverPlayerView alloc] init];
    _coverPlayerView.clipsToBounds  = YES;
    _coverPlayerView.layer.cornerRadius = 5;
    _coverPlayerView.layer.masksToBounds = YES;
    [self.view addSubview:_coverPlayerView];
    [self.view addSubview:self.coverImageScrollView];
    _coverPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:_coverPlayerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:50].active = YES;
    [NSLayoutConstraint constraintWithItem:_coverPlayerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_coverPlayerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:15.0].active = YES;
    [self.view addSubview:self.coverImageCollectionView];
    _coverImageCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint constraintWithItem:self.coverImageCollectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:COLLECTION_VIEW_LEFT].active = YES;
    [NSLayoutConstraint constraintWithItem:self.coverImageCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_coverPlayerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15.0].active = YES;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint constraintWithItem:self.coverImageCollectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-100].active = YES;
    } else {
        [NSLayoutConstraint constraintWithItem:self.coverImageCollectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-100].active = YES;
    }
    [NSLayoutConstraint constraintWithItem:self.coverImageCollectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-COLLECTION_VIEW_LEFT].active = YES;
    [NSLayoutConstraint constraintWithItem:self.coverImageCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.5].active = YES;
    
    // 滑动说明
    UILabel *label = [[UILabel alloc] init];
    label.text = @"滑动上方滑块选择封面";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont regularWithSize:13];
    label.textColor = [KKColor getColor:appHintTextColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_coverImageCollectionView.mas_bottom).offset(15);
    }];
    
    [self.view addSubview:self.releaseButtonBgView];
    [self.releaseButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(label.mas_bottom).offset(15);
    }];
    [KKGeneralGradientColor KK_createByCAGradientLayer:@[(id)[KKColor getColor:colorPrimary].CGColor,(id)[KKColor getColor:colorPrimaryDark].CGColor] direction:GradientTypeLeftToRightCenter layerView:self.releaseButtonBgView isConstraint:YES];
    [self.releaseButtonBgView addSubview:self.releaseButton];
    [self.releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.releaseButtonBgView).offset(-15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(label.mas_bottom).offset(15);
    }];
}

// 创建进度条
-(void)createSlider{
    // 初始化进度条
    AlpVideoCameraCoverSlider *slider = [[AlpVideoCameraCoverSlider alloc] init];
    WEAK_REF(self);
    // 进度条拖动结束调用
    [slider setEndTrackingWithTouchBlock:^{
        STRONG_REF(self);
        [self.thumbPlayer pause];
        // 拖动结束后 精确跳转
        [self chooseWithTime:self.clipTime];
    }];
    [self.view addSubview:slider];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.coverImageCollectionView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.coverImageCollectionView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.coverImageCollectionView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.coverImageCollectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0].active = YES;
    
    _slider = slider;
    [slider addTarget:self action:@selector(slidValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [self setupPlayer];
}

// 初始化播放器
- (void)setupPlayer {
    // 获取当前播放器最大时间
    AVURLAsset * asset = [AVURLAsset assetWithURL:_videoURL];
    self.currentTime = [asset duration];
    
    _thumbPlayer = [[AVPlayer alloc] init];
    self.videoOutPut = [[AVPlayerItemVideoOutput alloc]init];
    _thumbPlayerItem = [[AVPlayerItem alloc] initWithURL:_videoURL];
    [_thumbPlayerItem addOutput:self.videoOutPut];
    [_thumbPlayer  replaceCurrentItemWithPlayerItem:_thumbPlayerItem];
    _thumbPlayer.volume = 0; // 静音
   
    AVPlayerLayer *thumbPlayerLayer = (id)_slider.rangeThumbView.layer;
    thumbPlayerLayer.player = _thumbPlayer;
    thumbPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_thumbPlayer pause];
    [self play];
    
    
    // 共用一个AVPlayer 初始化两个layer
    AVPlayerLayer *playerLayer = (id)_coverPlayerView.layer;
    playerLayer.player = _thumbPlayer;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - 获取展示的所有相册
////////////////////////////////////////////////////////////////////////

- (void)getVideoTotalValueAndScale {
    [self.view addSubview:self.defaultCoverBackGroundImageView];
    
    [self.defaultCoverBackGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.top.mas_equalTo(self.view).offset(15);
        make.bottom.mas_equalTo(-(150 + (IS_iPhoneX ? 39.5 : 5.5)));
    }];
    
    self.defaultCoverBackGroundImageView.image = self.clipSelectImage;
    
    // 创建瀑布流
    [self setupUI];
    
    WS
    // 创建UI
    [AlpVideoCameraUtils getCoverByVideoURL:self.videoURL photoCount:[self theViewWidth:KK_SCREEN_WIDTH - 30] callBack:^(CMTime time, AlpVideoCameraCover * _Nonnull image, NSError * _Nonnull error) {
        SS
        [self.photoArrays addObject:image];
        NSLog(@"-------接受图片的个数---    %ld   %ld",self.photoArrays.count,[self theViewWidth:KK_SCREEN_WIDTH - 30]);
        if (self.photoArrays.count == [self theViewWidth:KK_SCREEN_WIDTH - 30]) {
            [self createSlider];
            self.slider.timeScale = time.timescale;
        }
        [self.coverImageCollectionView reloadData];
    }];
    
}

- (void)setupVideoCover {
    // 初始化videoTime，选择默认的cover
    if (self.videoTime.value == 0) {
        // 将总的time转换为当前player的timescale相同的time
        CMTime time = self.currentTime;
        CMTimeScale scale = self.currentTime.timescale;
        CMTime newTime = CMTimeConvertScale(time, scale, kCMTimeRoundingMethod_RoundTowardZero);
        self.videoTime = newTime;
        self.coverTime = CMTimeMake(0, scale);
        
        AlpVideoCameraCoverSliderRange range = AlpVideoCameraCoverSliderMakeRange(self.thumbLocation>0?self.thumbLocation:0, self.videoTime.value/self.photoArrays.count);
        self.slider.maximumValue = self.videoTime.value;
        self.slider.range = range;
        // 根据上次记录的时间点 跳过去
        if (self.clipTime > 0 && self.clipTime <= self.currentTime.value) {
            [self chooseWithTime:self.clipTime];
        }else{
            
            // 默认选择第一帧
            [self chooseWithTime:0];
        }
    }
}

// 播放
- (void)play {
    //[_mainPlayer play];
    [self startReplayTimer];
}

// 暂停
- (void)pause {
    //[_mainPlayer pause];
    [self stopReplayTimer];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Notification methods
////////////////////////////////////////////////////////////////////////

- (void)onApplicationWillResignActive {
    [self pause];
}

- (void)onApplicationDidBecomeActive {
    if (self.navigationController.topViewController == self) {
        [self pause];
    }
}


////////////////////////////////////////////////////////////////////////
#pragma mark - 视频播放时间的检测
////////////////////////////////////////////////////////////////////////
- (void)stopReplayTimer {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)startReplayTimer {
    [self stopReplayTimer]; // 停止检测
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onReplayTimer)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)onReplayTimer {
    if (self.currentTime.value <= 0) {
        return;
    }
    [self pause];
    [self setupVideoCover];
    CGFloat replayPosition = CMTimeGetSeconds(self.currentTime);
    CGFloat startSeconds = CMTimeGetSeconds(self.coverTime);
    CMTime stopTime = CMTimeMake(AlpVideoCameraCoverSliderMaxRange(self.slider.range), self.coverTime.timescale);
    CGFloat stopSeconds = CMTimeGetSeconds(stopTime);
    // 当视频播放完后，重置开始时间
    if (replayPosition >= stopSeconds) {
        [self seekVideoToPos:startSeconds];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Actions
////////////////////////////////////////////////////////////////////////
// 滑动
- (void)slidValueChange:(AlpVideoCameraCoverSlider *)slider {
    // 当前进度条拖动的进度
    CGFloat timeValue = slider.range.location;
    self.clipTime = [AlpVideoSliderTimeClip conversionTheTimeValue:timeValue totalTime:slider.maximumValue thumbWidth:30.7 timeScale:self.slider.timeScale];
    [self chooseWithTime:self.clipTime];
}

// 根据视频时间选择指定帧
- (void)chooseWithTime:(CMTimeValue)value{
    CMTime coverTime = CMTimeMake(value, self.videoTime.timescale);
    self.coverTime = coverTime;
    CGFloat start = CMTimeGetSeconds(coverTime);
    [self seekVideoToPos:start];
}

// 跳转到指定的精确时间点
- (void)seekVideoToPos:(CGFloat)pos {
    CMTime time = CMTimeMakeWithSeconds(pos, self.coverTime.timescale);
    if (time.value > 0) {
        [self.thumbPlayer seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
}

// 点击发布
- (void)didsReleseButton:(UIButton *)releseBtn {
    
    // 发布成功
    if (self.releseButtonBlock) {
        self.clipSelectImage = [self getPlayerBufferImage];
        self.releseButtonBlock(self.clipSelectImage, self.clipTime, self.slider.range.location);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didClickNextButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickBackButton {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

// 获取视频封面
- (UIImage *)getPlayerBufferImage {
    return [AlpVideoSliderTimeClip timeClipVideoImage:CMTimeMake(self.clipTime, self.coverTime.timescale) videoPath:self.videoURL];
}

#pragma mark-collectionview

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _photoArrays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlpCoverImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlpCoverImageCollectionViewCell" forIndexPath:indexPath];
    
    cell.imageView.image = _photoArrays[indexPath.item].firstFrameImage;
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KK_SCREEN_WIDTH - 30)/[self theViewWidth:KK_SCREEN_WIDTH - 30], 40.5);
}


// 根据控件的宽度，计算当前显示图片的个数
-(NSInteger)theViewWidth:(CGFloat)viewWidth{
    NSInteger count = viewWidth / 30.7;
    if (count > viewWidth / 30.7) {
        return count;
    }else{
        return count +=1;
    }
    return 0;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Getter
////////////////////////////////////////////////////////////////////////

- (UICollectionView *)coverImageCollectionView {
    if (!_coverImageCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0,0 ,0 );
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _coverImageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _coverImageCollectionView.backgroundColor = [UIColor blackColor];
        _coverImageCollectionView.showsVerticalScrollIndicator = NO;
        _coverImageCollectionView.showsHorizontalScrollIndicator = NO;
        [_coverImageCollectionView registerClass:[AlpCoverImageCollectionViewCell class] forCellWithReuseIdentifier:@"AlpCoverImageCollectionViewCell"];
        _coverImageCollectionView.delegate = self;
        _coverImageCollectionView.dataSource = self;
        [self.navigationController.interactivePopGestureRecognizer requireGestureRecognizerToFail:_coverImageCollectionView.panGestureRecognizer];
        
    }
    return _coverImageCollectionView;
}
- (UIView *)releaseButtonBgView {
    if (!_releaseButtonBgView) {
        _releaseButtonBgView = [[UIView alloc] init];
        _releaseButtonBgView.layer.cornerRadius = 23;
        _releaseButtonBgView.layer.masksToBounds = YES;
    }
    return _releaseButtonBgView;
}

- (UIButton *)releaseButton {
    if (!_releaseButton) {
        _releaseButton = [[UIButton alloc] init];
        [_releaseButton setTitle:@"确定" forState:UIControlStateNormal];
        _releaseButton.backgroundColor = [UIColor clearColor];
        [_releaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _releaseButton.titleLabel.font = [UIFont mediumWithSize:16];
        _releaseButton.layer.cornerRadius = 23;
        _releaseButton.layer.masksToBounds = YES;
        [_releaseButton addTarget:self action:@selector(didsReleseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseButton;
}
- (UIImageView *)defaultCoverBackGroundImageView {
    if (!_defaultCoverBackGroundImageView) {
        _defaultCoverBackGroundImageView = [[UIImageView alloc] init];
        _defaultCoverBackGroundImageView.hidden = NO;
        _defaultCoverBackGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _defaultCoverBackGroundImageView;
}
@end

@implementation AlpCoverImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.clipsToBounds  = YES;
        [self.contentView addSubview:_imageView];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0].active = YES;
        [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0].active = YES;
        [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0].active = YES;
        [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0].active = YES;
        [self.imageView.layer setMasksToBounds:YES];
        self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

@end

@implementation AlpVideoCameraCoverPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}
@end
