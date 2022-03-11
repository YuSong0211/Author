//
//  KKMemberUpgradeView.m
//  KK
//
//  Created by ProgramMa on 2021/8/27.
//

#import "KKMemberUpgradeView.h"
#import "KKGeneralGradientColor.h"
//#import "KKJurisdictionManager.h"
@interface KKMemberUpgradeView ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desLab;
@property(nonatomic,strong)UILabel *desLab1;
@property(nonatomic,strong)UIButton *PromoteBtn;
@property(nonatomic,strong)UIButton *buyBtn;

@end

@implementation KKMemberUpgradeView
-(instancetype)initWithFrame:(CGRect)frame withMemberType:(KKMemberUpdateType)memberType withShowView:(UIView*)showView WithPromoteblock:(clickPromoteBlock)block WithBuyBlock:(ClickBuyBlock)seBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.ClickBuyBlock = seBlock;
        self.promoteTouchBlock=block;
        self.Membertype = memberType;
        [self showMemberUpgradeView:YES withMemderType:self.Membertype];
    }
    return self;
    
}
-(void)showMemberUpgradeView:(BOOL)isshow withMemderType:(KKMemberUpdateType)memberType{
//    self.backgroundColor = KKRGBA(30, 30, 30,1);
    self.backgroundColor = [KKColor getColor:memberalerAlertBgColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.equalTo(self.mas_top).offset(25);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    [self addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(self.titleLab.mas_bottom).offset(20);
        make.height.mas_equalTo(@15);
    }];
    [self addSubview:self.desLab1];
    [self.desLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(self.desLab.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    
    [self addSubview: self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 37.5));
    }];

   
    [self addSubview: self.PromoteBtn];
    [self.PromoteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buyBtn.mas_top).offset(-15);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 37.5));
    }];
    


    [KKGeneralGradientColor KK_createByCAGradientLayer:@[(id)[KKColor getColor:memberalertAlertExtensionColor].CGColor,(id)[KKColor getColor:memberalertAlertExtensionDarkColor].CGColor] direction:GradientTypeLeftToRight layerView:self.PromoteBtn isConstraint:YES];

    [KKGeneralGradientColor KK_createByCAGradientLayer:@[(id)[KKColor getColor:memberalertAlertBuyColor].CGColor,(id)[KKColor getColor:memberalertAlertBuyDarkColor].CGColor] direction:GradientTypeLeftToRight layerView:self.buyBtn isConstraint:YES];

    
//    [KKGeneralGradientColor KK_createByCAGradientLayer:@[(id)KKRGBA(161, 116, 71, 1).CGColor,(id)KKRGBA(201, 163, 109, 1).CGColor] direction:GradientTypeLeftToRight layerView:self.buyBtn isConstraint:YES];
//
//    [KKGeneralGradientColor KK_createByCAGradientLayer:@[(id)KKRGBA(37, 248, 207, 1).CGColor,(id)KKRGBA(21, 224, 130, 1).CGColor] direction:GradientTypeLeftToRight layerView:self.PromoteBtn isConstraint:YES];
    if (self.Membertype == memberWatch) {
        self.titleLab.text = @"播放次数不足";
        self.desLab.text = @"今日剩余播放次数为0";
        self.desLab1.text = @"成功推广1人送3天会员，无限观看!（可叠加）";
        self.desLab1.textAlignment = NSTextAlignmentLeft;
    }else if (self.Membertype == memberComment){
        self.titleLab.text = @"没有评论权限";
        self.desLab1.text = @"推广或购买会员即可无限评论！";
        self.desLab1.textAlignment = NSTextAlignmentCenter;
        [self.desLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.desLab.mas_bottom).offset(-15);
        }];
    }else if (self.Membertype == memberdownload){
        self.titleLab.text = @"下载次数不足";
        self.desLab.text = @"今日剩余下载次数为0";
        self.desLab1.text = @"推广或购买会员即可无限下载！";
        self.desLab1.textAlignment = NSTextAlignmentLeft;
        
    }else if (self.Membertype == memberChat){
        self.titleLab.text = @"没有私聊权限";
        self.desLab1.text = @"推广或购买会员即可无限私信！";
        [self.desLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.desLab.mas_bottom).offset(-15);
        }];
        self.desLab1.textAlignment = NSTextAlignmentCenter;
        
    }else if (self.Membertype == memberCustomerService){
        self.titleLab.text = @"专属客服权限";
        self.desLab1.text = @"请充值或者推广可获取专属客服为你服务";
        
    }
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textColor =[KKColor getColor:memberalertAlertTitleColor];
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLab;
}

-(UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc]init];
        _desLab.textColor = KKRGBA(255, 255, 255, 0.5);
        _desLab.textColor = [KKColor getColor:memberalertAlertTextColor];
        _desLab.font = [UIFont systemFontOfSize:13];
        _desLab.numberOfLines = 0;
        _desLab.textAlignment = NSTextAlignmentLeft;
    }
    return _desLab;
}
-(UILabel *)desLab1{
    if (!_desLab1) {
        _desLab1 = [[UILabel alloc]init];
        _desLab1.textColor = KKRGBA(255, 255, 255, 0.5);
        _desLab1.textColor = [KKColor getColor:memberalertAlertTextColor];
        _desLab1.font = [UIFont systemFontOfSize:13];
        _desLab1.numberOfLines = 0;
        _desLab1.textAlignment = NSTextAlignmentCenter;
    }
    return _desLab1;
}
-(UIButton *)buyBtn{
    
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setTitle:@"购买会员" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_buyBtn setBackgroundColor:[UIColor greenColor]];
        _buyBtn.layer.masksToBounds = YES;
        _buyBtn.layer.cornerRadius = 18.5;
        [_buyBtn addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _buyBtn;
}

-(UIButton *)PromoteBtn{
    
    if (!_PromoteBtn) {
        _PromoteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_PromoteBtn setTitle:@"推广赚会员" forState:UIControlStateNormal];
        [_PromoteBtn setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
        _PromoteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_PromoteBtn setBackgroundColor:[UIColor orangeColor]];
        _PromoteBtn.layer.masksToBounds = YES;
        _PromoteBtn.layer.cornerRadius = 18.5;
        [_PromoteBtn addTarget:self action:@selector(PromoteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PromoteBtn;
}

-(void)buyClick:(UIButton *)sender{
//    if (self.ClickBuyBlock) {
        self.ClickBuyBlock();
//    }
    
}

-(void)PromoteClick:(UIButton *)sender{
//    if (self.promoteTouchBlock) {
        self.promoteTouchBlock();
//    }
    
}

+(KKMemberUpgradeView *)showMTMemberUpdateViewWithMemberUpdateType:(KKMemberUpdateType)memberType withShowView:(UIView*)showView WithPromoteblock:(clickPromoteBlock)block WithBuyBlock:(ClickBuyBlock)seBlock{
    KKMemberUpgradeView *showv = [[KKMemberUpgradeView alloc]initWithFrame:CGRectZero withMemberType:memberType withShowView:showView WithPromoteblock:^{
        if (block) {
            block();
        }
    } WithBuyBlock:^{
        if (seBlock) {
            seBlock();
        }
    }];
    CGFloat leftRightSpace = 60;
    if (memberType == memberWatch) {
        KKMemberUpgradeView *vie =  [[KKMemberUpgradeView alloc] init];
        [vie setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        vie.Membertype = memberType;
        [showView addSubview:vie];
        [vie mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(showView);
        }];
        
        [vie addSubview:showv];
        [showv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(showView.mas_left).offset(leftRightSpace);
            make.right.equalTo(showView.mas_right).offset(-leftRightSpace);
            make.centerX.mas_equalTo(showView);
            make.centerY.mas_equalTo(showView).offset(KK_TABBAR_BAR_HEIGHT/2);
            make.height.mas_equalTo(240);
        }];
    }
    else if (memberType == memberComment){
        
        KKMemberUpgradeView *vie =  [[KKMemberUpgradeView alloc] init];
        [vie setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        vie.Membertype = memberType;
//        UIGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
//        [vie addGestureRecognizer:tag];
        [showView addSubview:vie];
        [vie mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(showView);
        }];
      
        [vie addSubview:showv];
        CGFloat w = KK_SCREEN_WIDTH-2*leftRightSpace;
        if (KK_SCREEN_WIDTH>KK_SCREEN_HEIGHT) {
            w = KK_SCREEN_HEIGHT-2*leftRightSpace;
        }
        [showv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(showView.mas_left).offset(leftRightSpace);
//            make.right.equalTo(showView.mas_right).offset(-leftRightSpace);
            make.width.equalTo(@(w));
            make.centerX.mas_equalTo(showView);
            make.centerY.mas_equalTo(showView);
            make.height.mas_equalTo(240);
        }];
        return vie;
    }
    else if (memberType == memberdownload ||memberType == memberChat){
        
        KKMemberUpgradeView *vie =  [[KKMemberUpgradeView alloc] init];
        [vie setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        
        vie.Membertype = memberType;

//        UIGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
//        [vie addGestureRecognizer:tag];

        
        [showView addSubview:vie];
        [vie mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(showView);
        }];
        CGFloat w = KK_SCREEN_WIDTH-2*leftRightSpace;
        if (KK_SCREEN_WIDTH>KK_SCREEN_HEIGHT) {
            w = KK_SCREEN_HEIGHT-2*leftRightSpace;
        }
        [vie  addSubview:showv];
        [showv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(showView.mas_left).offset(leftRightSpace);
//            make.right.equalTo(showView.mas_right).offset(-leftRightSpace);
            make.width.equalTo(@(w));
            make.centerX.mas_equalTo(showView);
            make.centerY.mas_equalTo(showView);
            make.height.mas_equalTo(240);
        }];
        return vie;
    }
    else{
        
        [showv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(showView.mas_left).offset(15);
            make.right.equalTo(showView.mas_right).offset(-15);
            make.centerX.mas_equalTo(showView);
            make.centerY.mas_equalTo(showView);
            make.height.mas_equalTo(240);
        }];
    }
    return showv;
}
+(void)clickTap:(UITapGestureRecognizer*)tag{
    if ([tag.view isKindOfClass:[KKMemberUpgradeView class]]) {
        KKMemberUpgradeView *clickView = (KKMemberUpgradeView*)tag.view;
        [clickView removeFromSuperview];
        [[KKJurisdictionManager shareManager].viewArray removeObject:clickView];
//        [KKJurisdictionManager disMisiMeViewWithMeType:clickView.Membertype];
    }
//    [KKMemberUpgradeView disMissMTMemberUpdateViewWithShowView:tag.view.superview];
}
+(void)disMissMTMemberUpdateViewWithShowView:(UIView*)showView{
    
//    [KKJurisdictionManager  disMisiAllMeView];

    for (UIView * view in showView.subviews) {
        if ([view isKindOfClass:[KKMemberUpgradeView class]]) {
            [view removeFromSuperview];
            [[KKJurisdictionManager shareManager].viewArray removeObject:view];
        }
    }
}

@end
