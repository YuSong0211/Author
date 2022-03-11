//
//  MineHeaderMsgView.m
//  KK
//
//  Created by 小草 on 2021/6/24.
//

#import "MineHeaderMsgView.h"
#import "appvUser.pbobjc.h"
#import "appvBasic.pbobjc.h"// 用户信息内容类
#import "LoginViewController.h"
#import "KKTool.h"
#import "KKUtilityTool.h"
@interface MineHeaderMsgView ()

// 背景icon
@property (nonatomic,strong) UIImageView * backGroundIcon;

// 用户头像
@property (nonatomic,strong) UIImageView * userIcon;

// 用户类型 VIP
@property (nonatomic,strong) UIImageView * userVIP;

// 用户名
@property (nonatomic,strong) UILabel * userNickName;

// 性别
@property (nonatomic,strong) CoustomButton * sexSign;

// 位置Icon
@property (nonatomic,strong) UIImageView * locationSignIcon;

// 位置标签
@property (nonatomic,strong) UILabel * locationSignLab;

// 编辑资料
@property (nonatomic,strong) CoustomButton * editUserInfo;

// 是否属于首次
@property (nonatomic,assign) BOOL isFirst;

@end

@implementation MineHeaderMsgView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backGroundIcon];
        [self addSubview:self.userIcon];
        [self addSubview:self.userVIP];
        [self addSubview:self.userNickName];
        [self addSubview:self.sexSign];
        [self addSubview:self.locationSignIcon];
        [self addSubview:self.locationSignLab];
        [self addSubview:self.editUserInfo];
        self.isFirst = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backGroundIcon.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.userIcon.frame = CGRectMake(self.frame.size.width/2-(65/2), 15, 65, 65);
    self.userVIP.frame = CGRectMake(self.frame.size.width/2 - (42/2), CGRectGetMaxY(self.userIcon.frame) - 15, 42, 15);
    self.userNickName.frame = CGRectMake(self.frame.size.width/2-(230/2), CGRectGetMaxY(self.userVIP.frame) + 4.4, 230, 22);
    self.sexSign.frame = CGRectMake(self.frame.size.width/2-34, CGRectGetMaxY(self.userNickName.frame) + 1, 26.5, 16.5);
    self.sexSign.yc_buttonStyle = YcButtonStyleImageTextAlentCenter;
    self.locationSignIcon.frame = CGRectMake(self.frame.size.width/2+7.5, CGRectGetMaxY(self.userNickName.frame) + 4, 8.5, 10);
    self.locationSignLab.frame = CGRectMake(CGRectGetMaxX(self.locationSignIcon.frame) + 5, CGRectGetMaxY(self.userNickName.frame) + 1, 100, 16.5);
    self.editUserInfo.frame = CGRectMake(self.frame.size.width/2 - (91/2), CGRectGetMaxY(self.sexSign.frame)+10, 91, 25);
    self.editUserInfo.yc_buttonStyle = YcButtonStyleImageTextAlentCenter;
    if (self.isFirst == YES) {
        self.isFirst = NO;
        NSMutableArray * textArray = [[NSMutableArray alloc]initWithObjects:@"获赞",@"关注",@"粉丝", nil];
        for (int i = 0; i < textArray.count; i++) {
            // 标签背景
            UIView * labView = [[UIView alloc]initWithFrame:CGRectMake(i*(self.frame.size.width/3), CGRectGetMaxY(self.editUserInfo.frame) + 13, self.frame.size.width/3, 40)];
            labView.backgroundColor = [UIColor clearColor];
            labView.tag = 1100 + i;
            [self addSubview:labView];
            
            // 设置标签的点击事件
            UITapGestureRecognizer * tapClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabViewClick:)];
            [labView addGestureRecognizer:tapClick];
            
            // 行为数量
            UILabel * behaviorLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labView.frame.size.width, 22.5)];
            behaviorLab.textColor =  [KKColor getColor:appMainTextColor];
            
            behaviorLab.font = [UIFont mediumWithSize:16];
            behaviorLab.textAlignment = NSTextAlignmentCenter;
            behaviorLab.tag = 1000 + i;
            [labView addSubview:behaviorLab];
            
            
            
            // 标签说明
            UILabel * descLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(behaviorLab.frame)+1, labView.frame.size.width, 16.5)];
            descLab.text = textArray[i];
            descLab.font = [UIFont regularWithSize:12];
            descLab.textAlignment = NSTextAlignmentCenter;
            // descLab.textColor = [KKColor getColor:appHintTextColor];
            descLab.textColor = [KKColor getColor:appHintTextColor];
            [labView addSubview:descLab];
        }
        [self userInfo];
    }
}
// 此方法为刷新用户数据做处理
- (void)setBasic:(appvapiUserInfoBasic *)basic {
    _basic = basic;
    _userNickName.text = basic.nickname;
    if ([KKUserInfo share].gender == appvapiGenders_Male) {
        _sexSign.yc_buttontitle = @"男";
    }else if([KKUserInfo share].gender == appvapiGenders_Female){
        _sexSign.yc_buttontitle = @"女";
    }else{
        _sexSign.yc_buttontitle = @"女";
    }
}
// 此方法为刷新用户修改头像数据做处理
-(void)setAvterUrl:(NSString *)avterUrl {
    _avterUrl = avterUrl;
//    if (kStringIsEmpty(self.avterUrl)) {
//        _userIcon.backgroundColor = [UIColor redColor];
//    }else {
//
//    }
    
    [_userIcon setImageWithUrlString:self.avterUrl placeholderImage:@"default_head" animated:NO];
}
- (void)userInfo {
//    if (kStringIsEmpty([KKUserInfo share].avatarURL)) {
//        _userIcon.backgroundColor = [UIColor redColor];
//    }else {
//        ;
//    }
    if ([KKUserInfo share].userImage) {
        [_userIcon setImage:[KKUserInfo share].userImage];
    }
    else{
    [_userIcon setImageWithUrlString:[KKUserInfo share].avatarURL placeholderImage:@"default_head" animated:NO];
    }
    self.userVIP.image = [KKUtilityTool memberListImageWithVipType:[KKUserInfo share].member_level withDateTime:[KKUserInfo share].member_expiration_time WithCreationLevel:[KKUserInfo share].creationLevel]; 
    _userNickName.text = [KKUserInfo share].nickname;
    if ([KKUserInfo share].gender == appvapiGenders_Male) {
        _sexSign.yc_buttontitle = @"男";
    }else if([KKUserInfo share].gender == appvapiGenders_Female){
        _sexSign.yc_buttontitle = @"女";
    }else{
        _sexSign.yc_buttontitle = @"女";
    }
    self.sexSign.yc_buttonImageName = [KKUserInfo share].gender == appvapiGenders_Male ? @"mine_header_sex_man_ic" : @"mine_header_sex_woman_ic";

    _locationSignLab.text =  [KKUserInfo share].city;
    UILabel *behaviorLab = (UILabel *)[self viewWithTag:1000];// 获赞
    behaviorLab.text = [KKTool formatNumber:[KKUserInfo share].likes];
    UILabel *behaviorLab1 = (UILabel *)[self viewWithTag:1001];// 关注
    behaviorLab1.text = [KKTool formatNumber:[KKUserInfo share].following];
    UILabel *behaviorLab2 = (UILabel *)[self viewWithTag:1002];// 粉丝
    behaviorLab2.text = [KKTool formatNumber:[KKUserInfo share].followers];
    if ([[KKUserInfo share] hasBindingTelephone]) {
        _editUserInfo.yc_buttontitle = @"编辑资料";
        _editUserInfo.yc_titleColor = [KKColor getColor:colorSecondBtnText];
        
//        _editUserInfo.yc_buttonImageName = @"mine_header_edit_userinfo_ic";
        [_editUserInfo setYc_buttonImageName:@"mine_header_edit_userinfo_ic" WithImageColor:[KKColor getColor:colorSecondBtnText] withType:@"1"];
        _editUserInfo.yc_buttonimagesize = CGSizeMake(8.5, 9);
    }else {
        _editUserInfo.yc_buttontitle = @"绑定手机";
        _editUserInfo.yc_titleColor = [KKColor getColor:colorPrimary];
        
//        _editUserInfo.yc_buttonImageName = @"mine_header_phone_userinfo_ic";
        [_editUserInfo setYc_buttonImageName:@"mine_header_phone_userinfo_ic" WithImageColor:[KKColor getColor:colorPrimary] withType:@"2"];
        _editUserInfo.yc_buttonimagesize = CGSizeMake(8, 11.5);
    }
}
// 编辑用户信息
-(void)clickEditUserInfoClick{
    if ([self.delegate respondsToSelector:@selector(clickEditUserInfo)]) {
        [self.delegate clickEditUserInfo];
    }
}

/// 点击 点赞 关注  粉丝
/// @param tapViewClick 针对view做的点击事件
-(void)tapLabViewClick:(UITapGestureRecognizer *)tapViewClick{
    NSInteger type = 0;
    if (tapViewClick.view.tag == 1100) {
        // 点赞
        type = 0;
    }else if (tapViewClick.view.tag == 1101){
        // 关注
        type = 1;
    }else if (tapViewClick.view.tag == 1102){
        // 粉丝
        type = 2;
    }
    if ([self.delegate respondsToSelector:@selector(clickBehaviorWithType:)]) {
        [self.delegate clickBehaviorWithType:type];
    }
}

-(UIImageView *)backGroundIcon{
    if (!_backGroundIcon) {
        _backGroundIcon = [[UIImageView alloc]init];
        _backGroundIcon.backgroundColor = [KKColor getColor:appMainCardBgColor];
        _backGroundIcon.layer.masksToBounds = YES;
        _backGroundIcon.layer.cornerRadius = 15;
    }
    return _backGroundIcon;
}

// 用户icon
-(UIImageView *)userIcon{
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc]init];
        _userIcon.layer.cornerRadius = 65/2;
        _userIcon.layer.masksToBounds = YES;
        _userIcon.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _userIcon;
}

-(UIImageView *)userVIP{
    if (!_userVIP) {
        _userVIP = [[UIImageView alloc]init];
//        _userVIP.image = [UIImage imageNamed:@"KK_user_sign_svip"];
    }
    return _userVIP;
}

-(UILabel *)userNickName{
    if (!_userNickName) {
        _userNickName = [[UILabel alloc]init];
        _userNickName.textAlignment = NSTextAlignmentCenter;
//        _userNickName.textColor = [UIColor whiteColor];
        _userNickName.textColor = [KKColor getColor:appMainTextColor];
        _userNickName.font = [UIFont mediumWithSize:16];
    }
    return _userNickName;
}

-(CoustomButton *)sexSign{
    if (!_sexSign) {
        _sexSign = [[CoustomButton alloc]init];
        _sexSign.yc_buttonImageNameChangeTheme = @"mine_header_sex_man_ic";
        _sexSign.yc_controlMargin = 5;
        _sexSign.yc_buttonimagesize = CGSizeMake(9.5, 10);
        _sexSign.yc_titleFont = [UIFont regularWithSize:12];
//        _sexSign.yc_titleColor = [KKColor getColor:appHintTextColor];
        _sexSign.yc_titleColor = [KKColor getColor:appHintTextColor];
        _sexSign.userInteractionEnabled = NO;
    }
    return _sexSign;
}

-(UIImageView *)locationSignIcon{
    if (!_locationSignIcon) {
        _locationSignIcon = [[UIImageView alloc]init];
        _locationSignIcon.image = [KKTool decodeResourceFileImageName:@"icon_mine_position"];
    }
    return _locationSignIcon;
}

-(UILabel *)locationSignLab{
    if (!_locationSignLab) {
        _locationSignLab = [[UILabel alloc]init];
        _locationSignLab.textAlignment = NSTextAlignmentLeft;
//        _locationSignLab.textColor = [KKColor getColor:appHintTextColor];
        _locationSignLab.textColor = [KKColor getColor:appHintTextColor];
        _locationSignLab.font = [UIFont regularWithSize:12];
    }
    return _locationSignLab;
}

-(CoustomButton *)editUserInfo{
    if (!_editUserInfo) {
        _editUserInfo = [[CoustomButton alloc]init];
        _editUserInfo.yc_controlMargin = 6;
        _editUserInfo.yc_titleFont = [UIFont mediumWithSize:12];
        _editUserInfo.layer.cornerRadius = 25 / 2;
        _editUserInfo.layer.masksToBounds = YES;
        _editUserInfo.backgroundColor = [KKColor getColor:colorSecondBtnBg];
        [_editUserInfo addTarget:self action:@selector(clickEditUserInfoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editUserInfo;
}

@end
