//
//  KKMineGetLikeAlerterView.m
//  KK
//
//  Created by ProgramMa on 2021/7/29.
//

#import "KKMineGetLikeAlerterView.h"
@interface KKMineGetLikeAlerterView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *topIcon;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *commint;
@property (nonatomic, strong) NSTimer *timer;
// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;
@end
@implementation KKMineGetLikeAlerterView

- (void)showInView:(appvapiUserInfoBasic *)basic {
    self.frame = CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT);
    self.backgroundColor = KKRGBA(0, 0, 0, 0.2);
    [KK_GET_WINDOWS addSubview:self];
   
    self.backView.transform = CGAffineTransformMakeTranslation(0, 20);
    self.backView.alpha = 0;
    
    self.basic = basic;
    [self addSubview:self.backView];
    [self.backView addSubview:self.topIcon];
    [self.backView addSubview:self.titleL];
    [self.backView addSubview:self.line];
    [self.backView addSubview:self.commint];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
//        make.height.mas_equalTo(230);
        make.centerY.mas_equalTo(0);
        make.bottom.mas_equalTo(self.commint.mas_bottom).offset(3);
    }];
    [self.topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).offset(0);
        make.height.mas_equalTo(130);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).offset(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.topIcon.mas_bottom).offset(20);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).offset(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.titleL.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
    }];
    [self.commint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).offset(0);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.line.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
    }];
    _titleL.text = [NSString stringWithFormat:@"'%@'共获得%llu个赞",basic.nickname,basic.userSocial.likes];
    
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backView.transform = CGAffineTransformIdentity;
        self.backView.alpha = 1;
    } completion:^(BOOL finished) {}];
}
// 消失
- (void)dissmisView {
    [self removeFromSuperview];
}

// 点击确定
- (void)didsCanCelButton {
    [self dissmisView];
}
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 3;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)topIcon {
    if (!_topIcon) {
        _topIcon = [[UIImageView alloc] init];
        _topIcon.image = kImage(@"header_ic");
//        _topIcon.backgroundColor = [UIColor redColor];
    }
    return _topIcon;
}
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.font = [UIFont regularWithSize:13];
        _titleL.textColor = [UIColor grayColor];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.numberOfLines = 0;
    }
    return _titleL;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = KKRGBA(240, 240, 240, 1);
    }
    return _line;
}
- (UIButton *)commint {
    if (!_commint) {
        _commint = [[UIButton alloc] init];
        [_commint setTitle:@"确定" forState:UIControlStateNormal];
        [_commint setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commint.titleLabel.font = [UIFont mediumWithSize:14];
        _commint.backgroundColor = [UIColor whiteColor];
        [_commint addTarget:self action:@selector(didsCanCelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commint;
}

@end
