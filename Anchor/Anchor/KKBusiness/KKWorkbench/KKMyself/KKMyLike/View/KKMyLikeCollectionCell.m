//
//  KKMyLikeCollectionCell.m
//  KK
//
//  Created by 小草 on 2021/6/28.
//

#import "KKMyLikeCollectionCell.h"

@interface KKMyLikeCollectionCell ()



@property (nonatomic,strong) UIImageView * maskView;

@property (nonatomic,strong) CAGradientLayer * maskViewlayer;

@property (nonatomic,strong) UILabel * titleDesc;

@property (nonatomic,strong) UIImageView * likeIcon;

@property (nonatomic,strong) UILabel * likeCountLab;

@property (nonatomic,strong) UIView *suspendView;

@property (nonatomic,strong) UILabel *suspendLabel;

@property (nonatomic,strong) UIImageView *suspendIcon;

@end

@implementation KKMyLikeCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.layer.cornerRadius = 10.8;
    self.layer.masksToBounds = YES;
    //封面图
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    //底部阴影
    [self.contentView addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.equalTo(@57);
    }];
    //点赞图标
    [self.contentView addSubview:self.likeIcon];
    [self.likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.width.equalTo(@16.5);
        make.height.equalTo(@14);
        make.bottom.equalTo(self.contentView).inset(12);
    }];
    //点赞数
    [self.contentView addSubview:self.likeCountLab];
    [self.likeCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeIcon);
        make.left.equalTo(self.likeIcon.mas_right).offset(5);
    }];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.centerY.mas_equalTo(self.likeIcon);
        make.size.mas_equalTo(CGSizeMake(100, 14));
    }];
    //标题
    [self.contentView addSubview:self.titleDesc];
    [self.titleDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.likeIcon.mas_top).inset(5.5);
        make.left.equalTo(self.contentView).offset(12);
        make.right.equalTo(self.contentView).inset(12);
    }];
    //悬浮视图
    [self.contentView addSubview:self.suspendView];
    [self.suspendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    //悬浮文字
    [self.suspendView addSubview:self.suspendLabel];
    [self.suspendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.suspendView);
    }];
    //悬浮图标
    [self.suspendView addSubview:self.suspendIcon];
    [self.suspendIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.suspendLabel);
        make.right.equalTo(self.suspendLabel.mas_left).inset(5);
        make.height.equalTo(@10);
        make.width.equalTo(@8);
    }];
}

- (UIImageView *)suspendIcon {
    if (!_suspendIcon) {
        _suspendIcon = [[UIImageView alloc] init];
        _suspendIcon.image = [UIImage imageNamed:@"other_play"];
    }
    return _suspendIcon;
}

- (UIView *)suspendView {
    if (!_suspendView) {
        _suspendView = [[UIView alloc] init];
        _suspendView.backgroundColor = KKRGBA(0, 0, 0, 0.5);
        _suspendView.hidden = YES;
    }
    return _suspendView;
}

- (UILabel *)suspendLabel {
    if (!_suspendLabel) {
        _suspendLabel = [[UILabel alloc] init];
        _suspendLabel.textColor = [UIColor whiteColor];
        _suspendLabel.font = [UIFont systemFontOfSize:12.5 weight:UIFontWeightMedium];
        _suspendLabel.text = @"刚刚看过";
    }
    return _suspendLabel;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _icon;
}

-(UIImageView *)maskView{
    if (!_maskView) {
        _maskView = [[UIImageView alloc]init];
        _maskView.image = [UIImage imageNamed:@"rectangle"];
    }
    return _maskView;
}

-(UILabel *)titleDesc{
    if (!_titleDesc) {
        _titleDesc = [[UILabel alloc]init];
        _titleDesc.text = @"测试数据，意大利面的热舞时刻";
        _titleDesc.textColor = [UIColor whiteColor];
        _titleDesc.font = [UIFont regularWithSize:13];
        _titleDesc.textAlignment = NSTextAlignmentLeft;
    }
    return _titleDesc;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"";
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.font = [UIFont regularWithSize:13];
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

-(UIImageView *)likeIcon{
    if (!_likeIcon) {
        _likeIcon = [[UIImageView alloc]init];
        _likeIcon.image = [UIImage imageNamed:@"mine_like_ic"];
    }
    return _likeIcon;
}

-(UILabel *)likeCountLab{
    if (!_likeCountLab) {
        _likeCountLab = [[UILabel alloc]init];
        _likeCountLab.text = @"1.1k";
        _likeCountLab.textColor = [UIColor whiteColor];
        _likeCountLab.font = [UIFont mediumWithSize:12];
        _likeCountLab.textAlignment = NSTextAlignmentLeft;
    }
    return _likeCountLab;
}

- (void)setModel:(AvModel *)model {
    _model = model;
    self.titleDesc.text = model.video.title;

    
    [self.icon setImageWithUrlString:model.video.coverURL.URL placeholderImage:@"icon_short_video_bg" animated:NO];
//    WS
//    [self.icon kk_setImageWithUrlString:model.video.coverURL.URL placeholderImage:@"icon_short_video_bg" WithcompletedBlock:^{
//        SS
//        self.cellImageUrl = model.video.coverURL.URL;
//        if (self.imageConmendBlock) {
//            self.imageConmendBlock(self.cellImageUrl);
//        }
//    }];
    
    self.likeCountLab.text = [KKTool formatNumber:model.video.likes];
    UIImage *image = model.video.isLike ? [UIImage imageNamed:@"icon_video_praise_selected"] : [UIImage imageNamed:@"icon_video_praise_unselected"];
    self.likeIcon.image = image;
    NSArray *dic = (NSArray *)[KKTool dictionaryWithJsonString:model.video.videoURL.extra];
    CGFloat time= 0;
    if (dic.count>0) {
        for (NSDictionary *d in dic) {
            NSInteger type = [d[@"type"] integerValue];
            if (type==2) {
                NSLog(@"时长==%@",d[@"data"]);
                NSString *timeStr = [NSString stringWithFormat:@"%@",d[@"data"]];
                time = [timeStr integerValue];
            }
        }
    }
    if (time >0) {
        NSInteger timeUnit = time/1;
        NSLog(@"时长:%ld",timeUnit);
        self.timeLab.text = [KKTool SecondFormatFonversion:timeUnit];
    }else{
        self.timeLab.text = @"";
    }
}

- (void)isShowsuspendView:(BOOL)isShow {
    self.suspendView.hidden = !isShow;
}

@end
