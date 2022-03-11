//
//  KKKKDeveloperModeCell.m
//  mt
//
//  Created by Gwynne on 2021/10/19.
//

#import "KKKKDeveloperModeCell.h"

@implementation KKKKDeveloperModeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        _titleLabel.text = @"标题";
        _titleLabel.textColor = [KKColor getColor:appMainTextColor];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        _valueLabel.textColor = [KKColor getColor:appHintTextColor];
        _valueLabel.text = @"2398174822478127481274817";
        _valueLabel.numberOfLines = 0;
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}

- (UIImageView *)arrowsView {
    if (!_arrowsView) {
        _arrowsView = [[UIImageView alloc] init];
        UIImage *img=[UIImage imageNamed:@"mine_cell_arrow_ic"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrowsView.image =img;
        [_arrowsView setTintColor:[KKColor getColor:appHintTextColor]];
    }
    return _arrowsView;
}

- (void)initSubViews {
    [self.contentView addSubview:self.arrowsView];
    [self.arrowsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).inset(15);
        make.height.width.equalTo(@10);
        
    }];
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(25);
//        make.height.equalTo(@20);
        make.bottom.equalTo(self.contentView).inset(25);
        make.right.equalTo(self.arrowsView.mas_left).inset(10);
        make.left.equalTo(self.contentView).offset(100);
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.valueLabel).inset(5);
    }];
}

@end
