//
//  KKPushSelectMediaCell.m
//  mt
//
//  Created by 小草 on 2021/9/14.
//

#import "KKPushSelectMediaCell.h"


@interface KKPushSelectMediaCell ()

@property (nonatomic,strong) UIView * backView;

@property (nonatomic,strong) UIImageView * icon;

@property (nonatomic,strong) UILabel * descLab;

@end

@implementation KKPushSelectMediaCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.icon];
        [self.backView addSubview:self.descLab];
    }
    return self;
}

-(void)setModel:(KKPublishSelectModel *)model{
    _model = model;
    if (model.selectType == KKPublishSelectModelSelectImageMidiaType) {
        UIImage *img=[UIImage imageNamed:@"publish_community_collecttion_select_image"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.icon.image = img;
        [self.icon setTintColor:[KKColor getColor:appHintTextColor]];
        self.descLab.text = [NSString stringWithFormat:@"%ld/9\n上传图片",self.mediaCount];
    }else{
        UIImage *img=[UIImage imageNamed:@"publish_community_collecttion_select_video"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.icon.image = img;
        [self.icon setTintColor:[KKColor getColor:appHintTextColor]];
        self.descLab.text = [NSString stringWithFormat:@"%ld/1\n上传视频",self.mediaCount];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    if (self.model.selectType == KKPublishSelectModelSelectImageMidiaType) {
        self.icon.frame = CGRectMake(self.backView.frame.size.width/2-13, 18, 26, 24);
    }else{
        self.icon.frame = CGRectMake(self.backView.frame.size.width/2-13, 18, 31, 18);
    }
    self.descLab.frame = CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50);
}


-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [KKColor getColor:appMainCardBgColor];
        _backView.layer.cornerRadius = 7.5;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}


-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

-(UILabel *)descLab{
    if (!_descLab) {
        _descLab = [[UILabel alloc]init];
        _descLab.textAlignment = NSTextAlignmentCenter;
        _descLab.numberOfLines = 0;
        _descLab.textColor = [KKColor getColor:appHintTextColor];
        _descLab.font = [UIFont mediumWithSize:13];
    }
    return _descLab;
}

@end
