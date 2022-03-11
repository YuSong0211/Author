//
//  KKMineMemberCell.m
//  KK
//
//  Created by Gwynne on 2021/8/9.
//

#import "KKMineMemberCell.h"
#import "NSString+Extension.h"
# import "KKJurisdictionManager.h"

@interface KKMineMemberCell()

@property (nonatomic,strong) UIView *layerView;
@property (nonatomic,strong) UIImageView *medalImageView;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *watchNumLabel;
@property (nonatomic,strong) UILabel *watchDescLabel;
@property (nonatomic,strong) UIImageView *watchIcon;
@property (nonatomic,strong) UILabel *downLoadNumLabel;
@property (nonatomic,strong) UILabel *downLoadDescLabel;
@property (nonatomic,strong) UIImageView *downLoadIcon;

@end

@implementation KKMineMemberCell

- (UIImageView *)watchIcon {
    if (!_watchIcon) {
        _watchIcon = [[UIImageView alloc] init];
//        _watchIcon.contentMode = UIViewContentModeCenter;
        _watchIcon.image = [UIImage imageNamed:@"icon_mine_vip_watch_count_silver"];
    }
    return _watchIcon;
}

- (UILabel *)watchNumLabel {
    if (!_watchNumLabel) {
        _watchNumLabel = [[UILabel alloc] init];
        _watchNumLabel.textColor = KKRGBA(242, 205, 146, 1);
        _watchNumLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _watchNumLabel.text = @"10/10";
    }
    return _watchNumLabel;
}

- (UILabel *)watchDescLabel {
    if (!_watchDescLabel) {
        _watchDescLabel = [[UILabel alloc] init];
        _watchDescLabel = [[UILabel alloc] init];
        _watchDescLabel.textColor = KKRGBA(242, 205, 146, 1);
        _watchDescLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _watchDescLabel.text = @"今日观看";
    }
    return _watchDescLabel;
}

- (UIImageView *)downLoadIcon {
    if (!_downLoadIcon) {
        _downLoadIcon = [[UIImageView alloc] init];
//        _downLoadIcon.contentMode = UIViewContentModeCenter;
        _downLoadIcon.image = [UIImage imageNamed:@"icon_mine_vip_down_count_silver"];
    }
    return _downLoadIcon;
}

- (UILabel *)downLoadNumLabel {
    if (!_downLoadNumLabel) {
        _downLoadNumLabel = [[UILabel alloc] init];
        _downLoadNumLabel.textColor = KKRGBA(242, 205, 146, 1);
        _downLoadNumLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _downLoadNumLabel.text = @"1/2";
    }
    return _downLoadNumLabel;
}

- (UILabel *)downLoadDescLabel {
    if (!_downLoadDescLabel) {
        _downLoadDescLabel = [[UILabel alloc] init];
        _downLoadDescLabel = [[UILabel alloc] init];
        _downLoadDescLabel.textColor = KKRGBA(242, 205, 146, 1);
        _downLoadDescLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _downLoadDescLabel.text = @"今日下载";
    }
    return _downLoadDescLabel;
}

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] init];
        _buyBtn.backgroundColor = KKRGBA(201, 163, 109, 1);
        [_buyBtn setTitle:@"购买会员" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        [_buyBtn setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
        _buyBtn.layer.cornerRadius = 27 / 2;
        _buyBtn.layer.masksToBounds = YES;
        [_buyBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [KKColor getColor:appMainTextColor];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.text = @"有限期2022-09-12";
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}


- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [[UIView alloc] init];
        _layerView.backgroundColor = [KKColor getColor:appMainCardBgColor];
        _layerView.layer.cornerRadius = 15;
        _layerView.layer.masksToBounds = YES;
    }
    return _layerView;
}

- (UIImageView *)medalImageView {
    if (!_medalImageView) {
        _medalImageView = [[UIImageView alloc] init];
        _medalImageView.image = [UIImage imageNamed:@"mine_mem_icon"];
        _medalImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _medalImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)btnAction {
    if (self.btnActionCallBack) {
        self.btnActionCallBack();
    }
}

- (void)initSubViews {
    //底部
    [self.contentView addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).inset(15);
        make.height.equalTo(@(87.5 * KK_SCREEN_SCALE));
        make.bottom.equalTo(self.contentView).inset(0);
    }];
    //会员奖牌图标
//    [self.layerView addSubview:self.medalImageView];
//    [self.medalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.layerView);
//        make.width.equalTo(@(73));
//        make.bottom.equalTo(self.layerView).inset(15);
//        make.left.equalTo(self.layerView).offset(10);
//    }];
//    self.medalImageView.hidden = YES;
    //购买按钮
    [self.layerView addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.layerView.mas_right).inset(10);
        make.top.equalTo(self.layerView).offset(20);
        make.height.equalTo(@27);
        make.width.equalTo(@82);
    }];
    
    //过期时间
    [self.layerView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.buyBtn);
        make.centerY.equalTo(self.layerView).offset(18);
    }];
    
    //今日观看券
    [self.layerView addSubview:self.watchDescLabel];
    [self.watchDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dateLabel);
        make.left.equalTo(self.layerView).offset(35);
    }];
    //观看数
    [self.layerView addSubview:self.watchNumLabel];
    [self.watchNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.watchDescLabel);
        make.bottom.equalTo(self.watchDescLabel.mas_top).inset(3);
    }];
    //观看图标
    [self.layerView addSubview:self.watchIcon];
    [self.watchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.watchDescLabel);
        make.bottom.equalTo(self.watchNumLabel.mas_top).inset(3);
        make.size.mas_equalTo(CGSizeMake(25, 16));
    }];
    //今日下载券
    [self.layerView addSubview:self.downLoadDescLabel];
    [self.downLoadDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchDescLabel);
        make.centerX.equalTo(self.layerView);
//        make.left.equalTo(self.watchDescLabel.mas_right).offset(60);
    }];
    //下载数
    [self.layerView addSubview:self.downLoadNumLabel];
    [self.downLoadNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchNumLabel);
        make.centerX.equalTo(self.downLoadDescLabel);
    }];
    //下载图标
    [self.layerView addSubview:self.downLoadIcon];
    [self.downLoadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.downLoadNumLabel);
        make.centerY.equalTo(self.watchIcon);
        make.size.mas_equalTo(CGSizeMake(22, 18));
    }];
}

-(void)reloadVIPData{
    
    [KKGeneralGradientColor KK_removeFromSuperlayerView:self.buyBtn];
    KKUserInfo *KK = [[KKUserInfo alloc]init];
    if ([KK member_level] == 0 ||[KKTool isPastDueByComparisonTimestamp:[KK member_expiration_time]]){
        _watchIcon.image =  [UIImage imageNamed:@"icon_mine_vip_watch_count_silver"];
        _downLoadIcon.image = [UIImage imageNamed:@"icon_mine_vip_down_count_silver"];
        _watchDescLabel.textColor =[KKColor getColor:colorTextSilver];
        _downLoadDescLabel.textColor = [KKColor getColor:colorTextSilver];
//        _buyBtn.backgroundColor = KKRGBA(201, 163, 109, 1);
        [KKGeneralGradientColor KK_createByCAGradientLayer:KK_GRDIENT_THEMECOLOR direction:GradientTypeLeftToRight layerView:self.buyBtn isConstraint:YES];
        [_buyBtn setTitle:@"会员购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[KKColor getColor:colorMainBtnText] forState:UIControlStateNormal];
        [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.layerView.mas_right).inset(10);
            make.centerY.mas_equalTo(self.layerView);
            make.height.equalTo(@27);
            make.width.equalTo(@82);
        }];
        
        _downLoadNumLabel.textColor = [KKColor getColor:colorTextSilver];
        _watchNumLabel.textColor = [KKColor getColor:colorTextSilver];
        _dateLabel.hidden = YES;

    }else if ([KK member_level] == 1) {
        _watchIcon.image =  [UIImage imageNamed:@"icon_mine_vip_watch_count_silver"];
        _downLoadIcon.image =[UIImage imageNamed:@"icon_mine_vip_down_count_silver"];
        _watchDescLabel.textColor =[KKColor getColor:colorTextSilver];
        _downLoadDescLabel.textColor = [KKColor getColor:colorTextSilver];
//        _buyBtn.backgroundColor = KKRGBA(153, 162, 174, 1);
        [self.buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.layerView.mas_right).inset(10);
            make.top.equalTo(self.layerView).offset(20);
            make.height.equalTo(@27);
            make.width.equalTo(@82);
        }];
        [KKGeneralGradientColor KK_createByCAGradientLayer:KK_GRDIENT_YINCOLOR direction:GradientTypeLeftToRight layerView:self.buyBtn isConstraint:YES];
        [_buyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        _downLoadNumLabel.textColor = [KKColor getColor:colorTextSilver];
        _watchNumLabel.textColor = [KKColor getColor:colorTextSilver];
        _dateLabel.textColor = [KKColor getColor:colorTextSilver];
        _dateLabel.hidden = NO;
        [_buyBtn setTitle:@"VIP" forState:UIControlStateNormal];
        NSString *timeOver =[NSString convertTimeToString:([KK member_expiration_time])/1000];
        _dateLabel.text = [NSString stringWithFormat:@"%@到期",timeOver];
        
        
    }else if([KK member_level] == 2){
        _watchIcon.image = [UIImage imageNamed:@"icon_mine_vip_watch_count_gold"];
        _downLoadIcon.image = [UIImage imageNamed:@"icon_mine_vip_down_count_gold"];
        _watchDescLabel.textColor =[KKColor getColor:colorTextGold];
        _downLoadDescLabel.textColor = [KKColor getColor:colorTextGold];
//        _buyBtn.backgroundColor = KKRGBA(201, 163, 109, 1);
        [KKGeneralGradientColor KK_createByCAGradientLayer:KK_GRDIENT_JINCOLOR direction:GradientTypeLeftToRight layerView:self.buyBtn isConstraint:YES];
        [_buyBtn setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
        _downLoadNumLabel.textColor = [KKColor getColor:colorTextGold];
        _watchNumLabel.textColor = [KKColor getColor:colorTextGold];
        _dateLabel.textColor = [KKColor getColor:colorTextGold];
        [self.buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.layerView.mas_right).inset(10);
            make.top.equalTo(self.layerView).offset(20);
            make.height.equalTo(@27);
            make.width.equalTo(@82);
        }];
        _dateLabel.hidden = NO;
        if ([KK member_expiration_time]==LONG_MAX) {
          
            [_buyBtn setTitle:@"SVIP" forState:UIControlStateNormal];
            _dateLabel.text = [NSString stringWithFormat:@"终身有效"];
        }else{
    
            [_buyBtn setTitle:@"SVIP" forState:UIControlStateNormal];
            NSString *timeOver =[NSString convertTimeToString:([KK member_expiration_time])/1000];
            _dateLabel.text = [NSString stringWithFormat:@"%@到期",timeOver];
            
        }
    }
    if ([KKJurisdictionManager seeTotalCount]==INT32_MAX) {
        _watchNumLabel.text = [NSString stringWithFormat:@"无限"];
    }else{
        _watchNumLabel.text = [NSString stringWithFormat:@"%ld/%ld",[KKJurisdictionManager seeCount],[KKJurisdictionManager seeTotalCount]];

    }
    
    if ([KKJurisdictionManager downTotalCount] ==INT32_MAX) {
        _downLoadNumLabel.text = @"无限";
    }else{
        _downLoadNumLabel.text = [NSString stringWithFormat:@"%ld/%ld",[KKJurisdictionManager downCount] ,[KKJurisdictionManager downTotalCount]];
    }
   
}

@end
