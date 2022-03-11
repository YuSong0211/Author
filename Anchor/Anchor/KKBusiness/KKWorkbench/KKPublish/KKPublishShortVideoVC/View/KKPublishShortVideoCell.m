//
//  KKPublishShortVideoCell.m
//  KK
//
//  Created by ProgramMa on 2021/7/9.
//
#import "KKPublishShortVideoCell.h"

@interface KKPublishShortVideoCell ()
@property (nonatomic,strong) UIView *line;
@end
@implementation KKPublishShortVideoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.contentView.layer.cornerRadius = 30 / 2;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = KKRGBA(56, 58, 68, 1);
    [self.contentView addSubview:self.line];
    [self.line addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(1);
        make.right.mas_equalTo(self.line).offset(-1);
        make.top.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
    }];
    [KKGeneralGradientColor KK_createByCAGradientLayer:@[(id)[KKColor getColor:colorPrimary].CGColor,(id)[KKColor getColor:colorPrimaryDark].CGColor] direction:GradientTypeLeftToRightCenter layerView:self.line isConstraint:YES];
}
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.layer.cornerRadius = 34 / 2;
        _line.layer.masksToBounds = YES;
    }
    return _line;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor =  [KKColor getColor:appMainTextColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.cornerRadius = 32 / 2;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    }
    return _titleLabel;
}


@end
