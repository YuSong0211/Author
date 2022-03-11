//
//  KKWebActiveCollectionCell.m
//  richers
//
//  Created by 小草 on 2022/1/23.
//

#import "KKWebActiveCollectionCell.h"

@interface KKWebActiveCollectionCell ()

@property (nonatomic,strong) UIImageView * iconView;

@property (nonatomic,strong) UILabel * titleLab;


@end

@implementation KKWebActiveCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self.iconView kk_setImageWithUrlString:[dic objectForKey:@"img"] placeholderImage:@"webview_banner"];
    self.titleLab.text = [dic objectForKey:@"n"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(10, 0, self.frame.size.width-20, 113);
    self.titleLab.frame = CGRectMake(0, CGRectGetMaxY(self.iconView.frame)+10, self.frame.size.width, 20);
}

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.layer.cornerRadius = 10;
        _iconView.layer.masksToBounds = YES;
        _iconView.image = [UIImage imageNamed:@"webview_banner"];
    }
    return _iconView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"活动";
        _titleLab.font = [UIFont regularWithSize:16];
    }
    return _titleLab;
}

@end

