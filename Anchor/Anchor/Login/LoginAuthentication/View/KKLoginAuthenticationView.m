//
//  KKLoginAuthenticationView.m
//  KK
//
//  Created by 小草 on 2021/7/5.
//

#import "KKLoginAuthenticationView.h"
#import "KKLoginAuthenticationCollectionCell.h"


static NSString * identifier = @"KKLoginAuthenticationCollectionCell";
@interface KKLoginAuthenticationView ()<UICollectionViewDelegate,UICollectionViewDataSource>

// 背景
@property (nonatomic,strong) UIView * backView;

// 提示文字
@property (nonatomic,strong) UILabel * titleLab;

// 瀑布流
@property (nonatomic,strong) UICollectionView * collectionView;

// 刷新
@property (nonatomic,strong) CoustomButton * reloadButton;

// 确定按钮
@property (nonatomic,strong) UIButton * confirButton;

// 确定渐变阴影
@property (nonatomic,strong) CAGradientLayer * confirButtonLayer;

@end

@implementation KKLoginAuthenticationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.titleLab];
        [self.backView addSubview:self.collectionView];
        [self.backView addSubview:self.reloadButton];
        [self.backView addSubview:self.confirButton];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 背景
    self.backView.frame = CGRectMake(15, KK_NAV_BAR_HEIGHT + 80, self.frame.size.width - 30, 301);
    // 标题
    self.titleLab.frame = CGRectMake(0, 20, self.backView.frame.size.width, 22);
    // 瀑布流
    self.collectionView.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame)+15, self.backView.frame.size.width - 30, 184);
    // 刷新
    self.reloadButton.frame = CGRectMake(18, CGRectGetMaxY(self.collectionView.frame)+4, 56, 55);
    self.reloadButton.yc_buttonStyle = YcButtonStyleTextRightImageLeftType;
    // 确认按钮
    self.confirButton.frame = CGRectMake(self.backView.frame.size.width - 16 - 80, CGRectGetMaxY(self.collectionView.frame)+15, 80, 30);
    
}

#pragma mark -- UICollectionViewDelegate && UICollectionViewDataSource
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.backView.frame.size.width-39)/2, 87);
    
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self changeConfirmButton:YES];
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKLoginAuthenticationCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

#pragma mark -- 创建缩放动画
// 出现
-(void)show{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backView.layer.transform = CATransform3DMakeScale(1, 1, 0.5);
    } completion:^(BOOL finished) {
        
    }];
}

// 消失
-(void)hidden:(BOOL)isAnimate{
    self.backView.layer.transform = CATransform3DIdentity;
    if (isAnimate == YES) {
        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backView.layer.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.5);
        } completion:^(BOOL finished) {
        }];
    }else{
        self.backView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.5);
    }
}

/// 改变按钮状态
/// @param isEnable YES 可点击 NO不可点击
-(void)changeConfirmButton:(BOOL)isEnable{
    self.confirButton.enabled = isEnable;
    if (isEnable == YES) {
        // 可点击
        // 改变文字颜色
        [self.confirButton setTitleColor:[KKColor getColor:appBgColor] forState:UIControlStateNormal];
        
        // 移除 之前可能创建好的内容
        [self.confirButtonLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.confirButtonLayer removeFromSuperlayer];
        self.confirButtonLayer = nil;
        
        // 按钮渐变
        self.confirButtonLayer = [CAGradientLayer layer];
        self.confirButtonLayer.frame = self.confirButton.bounds;
        self.confirButtonLayer.startPoint = CGPointMake(0, 0.5);
        self.confirButtonLayer.endPoint = CGPointMake(1, 0.5);
        self.confirButtonLayer.colors = @[(id)[KKColor getColor:colorPrimary].CGColor,(id)[KKColor getColor:colorPrimaryDark].CGColor];
        self.confirButtonLayer.locations = @[@(0),@(1.0f)];
        self.confirButtonLayer.cornerRadius = 15;
        [self.confirButton.layer insertSublayer:self.confirButtonLayer atIndex:0];//注意添加顺序
    }else{
        // 移除
        [self.confirButtonLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.confirButtonLayer removeFromSuperlayer];
        self.confirButtonLayer = nil;
        // 不可点击
        [self.confirButton setTitleColor:KKRGBA(143, 143, 143, 1) forState:UIControlStateNormal];
        self.confirButton.backgroundColor = KKRGBA(56, 58, 68, 1);
    }
}

// 点击确认按钮
-(void)clickConfirmButton{
    if ([self.delegate respondsToSelector:@selector(clickConfirmAuthenticationIds:)]) {
        [self.delegate clickConfirmAuthenticationIds:nil];
    }
}

// 背景
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = KKRGBA(37, 39, 47, 1);
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

// 标题
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"请选择下图中的所有“汽车”";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont mediumWithSize:16];
        _titleLab.textColor =  [KKColor getColor:appMainTextColor];
    }
    return _titleLab;
}

// 瀑布流
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 8;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
        [_collectionView registerClass :[KKLoginAuthenticationCollectionCell class] forCellWithReuseIdentifier :identifier];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = NO;
    }
    return _collectionView;
}

// 刷新按钮
-(CoustomButton *)reloadButton{
    if (!_reloadButton) {
        _reloadButton = [[CoustomButton alloc]init];
        _reloadButton.yc_buttonImageNameChangeTheme = @"login_authenction_code_reload_ic";
        _reloadButton.yc_controlMargin = 10;
        _reloadButton.yc_buttonimagesize = CGSizeMake(16.5, 15.5);
        _reloadButton.yc_buttontitle = @"刷新";
        _reloadButton.yc_titleFont = [UIFont regularWithSize:14];
        _reloadButton.yc_titleColor = [KKColor getColor:appHintTextColor];
    }
    return _reloadButton;
}

// 确认
-(UIButton *)confirButton{
    if (!_confirButton) {
        _confirButton = [[UIButton alloc]init];
        [_confirButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirButton.titleLabel.font = [UIFont mediumWithSize:14];
        _confirButton.layer.cornerRadius = 15;
        [self changeConfirmButton:NO];
        [_confirButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirButton;
}
@end
