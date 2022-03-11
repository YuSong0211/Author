//
//  KKMineShareCell.m
//  KK
//
//  Created by Gwynne on 2021/8/10.
//

#import "KKMineShareCell.h"

@interface KKMineShareCell()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UIImageView * arrowIcon;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UIView *layerView;

@end

@implementation KKMineShareCell


- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [[UIView alloc] init];
        _layerView.backgroundColor = [KKColor getColor:appMainCardBgColor];
        _layerView.layer.cornerRadius = 15;
        _layerView.layer.masksToBounds = YES;
    }
    return _layerView;
}
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
//        _iconView.image = KKImage(@"icon_mine_share");
        UIImage *img=[KKTool decodeResourceFileImageName:@"icon_mine_share"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _iconView.image =img;
        [_iconView setTintColor:[KKColor getColor:appMainTextColor]];
    }
    return _iconView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [KKColor getColor:appMainTextColor];
        _titleLab.font = [UIFont mediumWithSize:14];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.text = @"分享推广";
    }
    return _titleLab;
}

-(UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc]init];
        UIImage *img=[UIImage imageNamed:@"mine_cell_arrow_ic"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrowIcon.image =img;
        [_arrowIcon setTintColor:[KKColor getColor:appHintTextColor]];
    }
    return _arrowIcon;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
//        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.textColor = [KKColor getColor:appMainTextColor];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.text = @"推广送会员 躺着也赚钱";
    }
    return _descLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubViews {
    [self.contentView addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.height.equalTo(@(49 * KK_SCREEN_SCALE));
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).inset(15);
        make.bottom.equalTo(self.contentView).inset(0);
    }];
    [self.layerView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.layerView).offset(15);
        make.height.width.equalTo(@25);
        make.centerY.equalTo(self.layerView);
    }];
    [self.layerView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.centerY.equalTo(self.iconView);
    }];
    [self.layerView addSubview:self.arrowIcon];
    [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.layerView).inset(15);
        make.height.width.equalTo(@(9.5));
        make.centerY.equalTo(self.layerView);
    }];
    [self.layerView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.layerView);
        make.right.equalTo(self.arrowIcon.mas_left).inset(10);
        make.left.lessThanOrEqualTo(self.titleLab.mas_right).offset(5);
    }];
    
}

@end
