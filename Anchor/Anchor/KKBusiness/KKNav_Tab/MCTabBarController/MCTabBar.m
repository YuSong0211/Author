//
//  MCTabBar.m
//  MCTabBarDemo
//
//  Created by chh on 2017/12/18.
//  Copyright © 2017年 Mr.C. All rights reserved.
//  github:https://github.com/Ccalary/MCTabBarController

#import "MCTabBar.h"

#define MCTabBarItemHeight    49.0f

@interface MCTabBar()
@end
@implementation MCTabBar
- (instancetype)init{
    if (self = [super init]){
        [self initView];
        [self setUpLabel];
    }
    return self;
}
- (void)initView{
    _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //去除选择时高亮
    _centerBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_centerBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.position) {
        case MCTabBarCenterButtonPositionCenter:
            _centerBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - KK_SCREEN_WIDTH/5)/2.0, (MCTabBarItemHeight - 48)/2.0 + self.centerOffsetY, KK_SCREEN_WIDTH/2, 48);
            break;
        case MCTabBarCenterButtonPositionBulge:
             _centerBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - _centerWidth)/2.0, -_centerHeight/2.0 + self.centerOffsetY+14, _centerWidth, _centerHeight);
            break;
        default:
            break;
    }
}

- (void)setCenterImage:(UIImage *)centerImage {
    _centerImage = centerImage;
//    // 如果设置了宽高则使用设置的大小
//    if (self.centerWidth <= 0 && self.centerHeight <= 0){
//        //根据图片调整button的位置(默认居中，如果图片中心在tabbar的中间最上部，这个时候由于按钮是有一部分超出tabbar的，所以点击无效，要进行处理)
//        _centerWidth = centerImage.size.width;
//        _centerHeight = centerImage.size.height;
//    }
//    [_centerBtn setImage:centerImage forState:UIControlStateNormal];
}

- (void)setCenterSelectedImage:(UIImage *)centerSelectedImage {
//    _centerSelectedImage = centerSelectedImage;
//    [_centerBtn setImage:centerSelectedImage forState:UIControlStateSelected];
}
-(void)setUpLabel{
    self.centerlabelArray = [NSMutableArray array];
    CGFloat width = KK_SCREEN_WIDTH/2;
    for (int i = 0; i<5; i++) {
        UIButton* centerlabel = [[UIButton alloc] init];
        [centerlabel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [centerlabel setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        [centerlabel setFrame:CGRectMake(width*i,0, width, 48)];
        [centerlabel.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self addSubview:centerlabel];
        [self.centerlabelArray  addObject:centerlabel];
    }
    
    self.badgeLabel = [[UILabel alloc] init];
    self.badgeLabel.backgroundColor = KKRGBA(250, 61, 88, 1);
    self.badgeLabel.layer.cornerRadius = 9;
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.font = [UIFont systemFontOfSize:12];
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.layer.masksToBounds = YES;
    [self addSubview:self.badgeLabel];
    self.badgeLabel.hidden = YES;
    UIButton *temp = self.centerlabelArray[4];
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(temp).offset(2);
        make.centerX.equalTo(temp).offset(17);
        make.height.width.equalTo(@18);
    }];
}



- (void)setStyleWithIsShowCount:(BOOL)isShowCount count:(NSInteger)count {
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat top = 0;
    if (isShowCount) { //显示大红点
        self.badgeLabel.text = count > 99 ? @"99+" : [NSString stringWithFormat:@"%ld",count];
        height = 18;
        top = 2;
        if (count <= 9) {
            width = 18;
        }else if (count > 9 && count <= 99) {
            width = 22;
        }else if (count > 99) {
            width = 27;
        }
    }else { //显示小红点
        self.badgeLabel.text = @"";
        width = 10;
        height = 10;
        top = 8;
    }
    UIButton *temp = self.centerlabelArray[4];
    [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(temp).offset(top);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    self.badgeLabel.layer.cornerRadius = height / 2;
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    return [super hitTest:point withEvent:event];
    
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
            //返回按钮
            return _centerBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}
-(void)changeBtnTtileColorWithISDark:(BOOL)isDark{
    for (int i = 0; i<self.centerlabelArray.count; i++) {
        UIButton* centerlabel = self.centerlabelArray[i];
        if (isDark) {
            [centerlabel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [centerlabel setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        }
        else{
            [centerlabel setTitleColor:[KKColor getColor:appTabUnActiveColor] forState:UIControlStateNormal];
            [centerlabel setTitleColor:[KKColor getColor:appTabActiveColor] forState:UIControlStateSelected];
        }
    }
}
@end
