//
//  MineTableviewCell.m
//  KK
//
//  Created by 小草 on 2021/6/25.
//

#import "MineTableviewCell.h"


@interface MineTableviewCell ()

@property (nonatomic,strong) UIImageView * icon;

@property (nonatomic,strong) UILabel * titleLab;

@property (nonatomic,strong) UIImageView * arrowIcon;

@end

@implementation MineTableviewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(15);
            make.bottom.equalTo(self).inset(15);
            make.width.height.equalTo(@25);
        }];
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(10);
            make.centerY.equalTo(self.icon);
            make.height.equalTo(@20);
        }];
        [self addSubview:self.arrowIcon];
        [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.icon);
            make.right.equalTo(self).inset(15);
            make.width.height.equalTo(@11);
        }];
    }
    return self;
}

-(void)setDataModel:(MinCellModelDataSource *)dataModel{
    _dataModel = dataModel;
    self.icon.image = [KKTool decodeResourceFileImageName:dataModel.iconName];
    self.titleLab.text = dataModel.titleName;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
//    self.icon.frame = CGRectMake(15, self.frame.size.height/2-(25/2), 25, 25);
//    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+10, self.frame.size.height/2-(10), 150, 20);
//    self.arrowIcon.frame = CGRectMake(self.frame.size.width - 15 - 11, self.frame.size.height/2 - (11/2), 11, 11);
    
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
//        _titleLab.textColor = KKRGBA(233, 233, 233, 1);
        _titleLab.textColor = [KKColor getColor:appMainTextColor];
        _titleLab.font = [UIFont mediumWithSize:14];
        _titleLab.textAlignment = NSTextAlignmentLeft;
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

@end
