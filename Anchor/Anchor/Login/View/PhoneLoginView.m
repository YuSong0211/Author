//
//  PhoneLoginView.m
//  KK
//
//  Created by 小草 on 2021/6/24.
//

#import "PhoneLoginView.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface PhoneLoginView ()<UITextFieldDelegate>

// 确定渐变阴影
@property (nonatomic,strong) CAGradientLayer * loginButtonLayer;
@property (nonatomic,assign)BOOL isGetCode;// 是否正在获取验证码
@property (nonatomic,assign)int codeIndex;
@end

@implementation PhoneLoginView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [KKColor getColor:appBgColor];
        
        [self addSubview:self.phoneDesc];
        [self addSubview:self.bingDingTipL];
        [self addSubview:self.selectAreaCodeButton];
        [self addSubview:self.selectAreaCodeRightLineView];
        [self addSubview:self.phoneTextFiled];
        [self addSubview:self.phoneBottomLineView];
        [self addSubview:self.phoneCode];
        [self addSubview:self.phoneCodeBottomLineView];
        [self addSubview:self.getPhoneCodeButton];
        [self addSubview:self.loginButton];
        [self addSubview:self.bingDingBottomTipL];
        [self addSubview:self.bingDingBottomTipIcon];
        self.codeIndex = 60;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.phoneDesc.frame = CGRectMake(25,20, 200, 26.5);
    self.bingDingTipL.frame = CGRectMake(25, CGRectGetMaxY(self.phoneDesc.frame) + 8, KK_SCREEN_WIDTH - 50, 21);
    self.selectAreaCodeButton.frame = CGRectMake(25, CGRectGetMaxY(self.isBingDingPhone || self.isCommintUpdataPhone || self.isUpdataPhone ? self.bingDingTipL.frame : self.phoneDesc.frame)+33, 53, 21);
    self.selectAreaCodeButton.yc_buttonStyle = YcButtonStyleTextLeftImageRightType;
    self.selectAreaCodeRightLineView.frame = CGRectMake(CGRectGetMaxX(self.selectAreaCodeButton.frame)+5, CGRectGetMaxY(self.isBingDingPhone  || self.isCommintUpdataPhone || self.isUpdataPhone? self.bingDingTipL.frame : self.phoneDesc.frame)+33, 1, 21);
    self.phoneTextFiled.frame = CGRectMake(CGRectGetMaxX(self.selectAreaCodeRightLineView.frame)+10, CGRectGetMaxY(self.isBingDingPhone  || self.isCommintUpdataPhone || self.isUpdataPhone ? self.bingDingTipL.frame : self.phoneDesc.frame)+33, 150, 21);
    self.phoneBottomLineView.frame = CGRectMake(25, CGRectGetMaxY(self.selectAreaCodeButton.frame)+8, self.frame.size.width - 50, 0.5);
    self.phoneCode.frame = CGRectMake(25, CGRectGetMaxY(self.phoneBottomLineView.frame)+34.5, 150, 20);
    self.phoneCodeBottomLineView.frame = CGRectMake(20, CGRectGetMaxY(self.phoneCode.frame)+8, self.frame.size.width - 50, 0.5);
    self.getPhoneCodeButton.frame = CGRectMake(self.frame.size.width - 23 - 70, CGRectGetMaxY(self.phoneBottomLineView.frame)+34.5, 70, 20);
    self.bingDingBottomTipIcon.frame = CGRectMake(25, CGRectGetMaxY(self.getPhoneCodeButton.frame)+35, 13, 13);
    self.bingDingBottomTipL.frame = CGRectMake(CGRectGetMaxX(self.bingDingBottomTipIcon.frame) + 5, CGRectGetMaxY(self.getPhoneCodeButton.frame)+31.5, 260, 20);
    self.loginButton.frame = CGRectMake(25, CGRectGetMaxY(self.isBingDingPhone || self.isCommintUpdataPhone || self.isUpdataPhone ? self.bingDingBottomTipL.frame : self.phoneCodeBottomLineView.frame ) + (self.isBingDingPhone  || self.isCommintUpdataPhone  || self.isUpdataPhone ? 13 : 40), self.frame.size.width - 50, 45);
    self.getPhoneCodeColor = KKRGBA(143, 143, 143, 1);
   // [self addListener];
 
}

//属性监听变化
-(void)addListener{
    //监听验证码按钮颜色变化
    [RACObserve(self, self.getPhoneCodeColor)  subscribeNext:^(UIColor*  _Nullable x) {
        if(x==NULL){return;}
        if(!self.getPhoneCodeButton){return;}
        [self.getPhoneCodeButton setTitleColor:x forState:UIControlStateNormal];
    }];
    //监听验证码变化
    [RACObserve(self, self.codeTitle) subscribeNext:^(NSString*  _Nullable x) {
        if(x==NULL){return;}
        if(!self->_getPhoneCodeButton){return;}
        [self->_getPhoneCodeButton setTitle:x forState:UIControlStateNormal];
    }];
}

// 绑定手机号
- (void)setIsBingDingPhone:(BOOL)isBingDingPhone {
    _isBingDingPhone = isBingDingPhone;
    // 绑定手机号
    if ([KKUserInfo share].hasBindingTelephone) {
        _phoneDesc.text = @"改绑手机号";
    }
    else{
    _phoneDesc.text = @"绑定手机号";
    }
    self.bingDingTipL.hidden = NO;
    self.bingDingBottomTipIcon.hidden = NO;
    self.bingDingBottomTipL.hidden = NO;
    // 绑定手机号
    [_loginButton setTitle:@"确定" forState:UIControlStateNormal];
    if ([KKUserInfo share].hasBindingTelephone) {
        // 绑定过
        _bingDingTipL.text = [NSString stringWithFormat:@"当前绑定手机号码：%@",[KKUserInfo share].telephone];
    }else {
        // 未绑定过
        _bingDingTipL.text = @"当前绑定手机号码：未绑定";
    }
}
// 登录
- (void)setIsSign:(BOOL)isSign {
    _isSign = isSign;
    // 登录
    _phoneDesc.text = @"切换账号";
    self.bingDingTipL.hidden = YES;
    self.bingDingBottomTipIcon.hidden = YES;
    self.bingDingBottomTipL.hidden = YES;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
}
// 验证绑定手机号
- (void)setIsUpdataPhone:(BOOL)isUpdataPhone {
    _isUpdataPhone = isUpdataPhone;
    if ([KKUserInfo share].hasBindingTelephone) {
        _phoneDesc.text = @"改绑手机号";
    }
    else{
    _phoneDesc.text = @"绑定手机号";
    }
    self.bingDingTipL.hidden = NO;
    self.bingDingBottomTipIcon.hidden = NO;
    self.bingDingBottomTipL.hidden = NO;
    // 验证手机号
    [_loginButton setTitle:@"确定" forState:UIControlStateNormal];
    if ([KKUserInfo share].hasBindingTelephone) {
        // 绑定过
        _bingDingTipL.text = [NSString stringWithFormat:@"当前绑定手机号码：%@",[KKUserInfo share].telephone];
    }else {
        // 未绑定过
        _bingDingTipL.text = @"当前绑定手机号码：未绑定";
    }
}
- (void)setIsSwitchACcount:(BOOL)isSwitchACcount {
    _isSwitchACcount = isSwitchACcount;
    _phoneDesc.text = @"切换账号";
    self.bingDingTipL.hidden = YES;
    self.bingDingBottomTipIcon.hidden = YES;
    self.bingDingBottomTipL.hidden = YES;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
}
/// 改变登录按钮的样式
/// @param isEnable  是否可点击
-(void)changeLoginButtonStyle:(BOOL)isEnable{
    if (isEnable == YES) {
        // 移除 之前可能创建好的内容
        [self.loginButtonLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.loginButtonLayer removeFromSuperlayer];
        self.loginButtonLayer = nil;
        // 按钮渐变
        self.loginButtonLayer = [CAGradientLayer layer];
        self.loginButtonLayer.frame = self.loginButton.bounds;
        self.loginButtonLayer.startPoint = CGPointMake(0, 0.5);
        self.loginButtonLayer.endPoint = CGPointMake(1, 0.5);
        self.loginButtonLayer.colors = @[(id)[KKColor getColor:colorPrimary].CGColor,(id)[KKColor getColor:colorPrimaryDark].CGColor];
        self.loginButtonLayer.locations = @[@(0),@(1.0f)];
        self.loginButtonLayer.cornerRadius = 15;
        [self.loginButton setTitleColor:[KKColor getColor:colorMainBtnText] forState:UIControlStateNormal];
        [self.loginButton.layer insertSublayer:self.loginButtonLayer atIndex:0];//注意添加顺序

    }else{
        [self.loginButtonLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.loginButtonLayer removeFromSuperlayer];
        self.loginButtonLayer = nil;
        [self.loginButton setTitleColor:[KKColor getColor:colorSecondBtnText] forState:UIControlStateNormal];
        self.loginButton.backgroundColor = [KKColor getColor:colorSecondBtnBg];
    }
}

// 获取手机验证码点击事件
-(void)getPhoneCodeClick{
//    if ([self.delegate respondsToSelector:@selector(clickGetPhoneAuthenticationCode:)]) {
//        [self.delegate clickGetPhoneAuthenticationCode:self.phoneTextFiled.text];
//    }
}

// 进行登录
-(void)loginButtonClick{
    
    if ([self.delegate respondsToSelector:@selector(clickLoginButton:userPhoneCode:)]) {
        [self.delegate clickLoginButton:self.phoneTextFiled.text userPhoneCode:self.phoneCode.text];
    }
}
- (void)verifyEvent
{
    //启动倒计时
    [self performSelector:@selector(reflashGetKeyBt:)withObject:[NSNumber numberWithInt:self.codeIndex] afterDelay:0];
}

//倒数
- (void)reflashGetKeyBt:(NSNumber *)second
{
   if ([second integerValue] == 0)
    {
        _getPhoneCodeButton.selected=YES;
        _getPhoneCodeButton.userInteractionEnabled=YES;
        [_getPhoneCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [_getPhoneCodeButton setTitleColor:KKRGBA(143, 143, 143, 1) forState:UIControlStateNormal];
        self.isGetCode = NO;
    }
   else
    {
        _getPhoneCodeButton.selected=NO;
        _getPhoneCodeButton.userInteractionEnabled=NO;
        self.codeIndex = [second intValue];
        [_getPhoneCodeButton setTitle:[NSString stringWithFormat:@"%is",self.codeIndex] forState:(UIControlStateNormal)];
        [_getPhoneCodeButton setTitleColor:KKRGBA(137, 138, 141, 1) forState:UIControlStateNormal];
        [self performSelector:@selector(reflashGetKeyBt:)withObject:[NSNumber numberWithInt:self.codeIndex-1] afterDelay:1];
        self.isGetCode = YES;
    }
    
}
- (void)cancelPreviousPerformRequestsWithTarget {
    if (self.isGetCode) {
        // 只有获取过验证码的情况下才需要停止定时器
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        self.codeIndex = 0;
        _getPhoneCodeButton.selected=YES;
        _getPhoneCodeButton.userInteractionEnabled=YES;
        [_getPhoneCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [_getPhoneCodeButton setTitleColor:KKRGBA(143, 143, 143, 1) forState:UIControlStateNormal];
        self.isGetCode = NO;
    }
}
// 手机号快捷登录
-(UILabel *)phoneDesc{
    if (!_phoneDesc) {
        _phoneDesc = [[UILabel alloc]init];
        _phoneDesc.textColor =  [KKColor getColor:appMainTextColor];
        _phoneDesc.font = [UIFont mediumWithSize:19];
    }
    return _phoneDesc;
}
// 绑定手机号提醒标题
-(UILabel *)bingDingTipL{
    if (!_bingDingTipL) {
        _bingDingTipL = [[UILabel alloc]init];
        _bingDingTipL.textColor = KKRGBA(255, 255, 255, 0.7);
        _bingDingTipL.font = [UIFont regularWithSize:15];
    }
    return _bingDingTipL;
}

// 选择手机区号
-(CoustomButton *)selectAreaCodeButton{
    if (!_selectAreaCodeButton) {
        _selectAreaCodeButton = [[CoustomButton alloc]init];
        _selectAreaCodeButton.yc_buttontitle = @"+86 ▾";
        _selectAreaCodeButton.yc_titleColor = [KKColor getColor:appHintTextColor];
        _selectAreaCodeButton.yc_titleFont = [UIFont regularWithSize:15];
        _selectAreaCodeButton.yc_controlMargin = 5;
        _selectAreaCodeButton.yc_buttonimagesize = CGSizeMake(6.5, 4.5);
        _selectAreaCodeButton.yc_buttonImageNameChangeTheme = @"phone_login_select_area_coe_ic";
    }
    return _selectAreaCodeButton;
}

// 选择区号旁边的线条
-(UIView *)selectAreaCodeRightLineView{
    if (!_selectAreaCodeRightLineView) {
        _selectAreaCodeRightLineView = [[UIView alloc]init];
        _selectAreaCodeRightLineView.backgroundColor = KKRGBA(216, 216, 216, 0.3);
    }
    return _selectAreaCodeRightLineView;
}


// 手机号输入框
-(UITextField *)phoneTextFiled{
    if (!_phoneTextFiled) {
        _phoneTextFiled = [[UITextField alloc]init];
        _phoneTextFiled.placeholder = @"请输入手机号码";
        _phoneTextFiled.font = [UIFont regularWithSize:15];
        _phoneTextFiled.textColor = [KKColor getColor:appMainTextColor];
        if (@available(iOS 13, *)) {
            _phoneTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName:[KKColor getColor:appHintTextColor], NSFontAttributeName:[UIFont regularWithSize:15]}];
        }else{
            [_phoneTextFiled setValue:[KKColor getColor:appHintTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        _phoneTextFiled.tintColor = [KKColor getColor:appMainTextColor];
        _phoneTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
        _phoneTextFiled.delegate = self;
    }
    return _phoneTextFiled;
}

// 手机号
-(UIView *)phoneBottomLineView{
    if (!_phoneBottomLineView) {
        _phoneBottomLineView = [[UIView alloc]init];
        _phoneBottomLineView.backgroundColor = KKRGBA(216, 216, 216, 0.3);
    }
    return _phoneBottomLineView;
}

// 手机号验证码
-(UITextField *)phoneCode{
    if (!_phoneCode) {
        _phoneCode = [[UITextField alloc]init];
        _phoneCode.placeholder = @"请输入短信验证码";
        _phoneCode.font = [UIFont regularWithSize:15];
        _phoneCode.textColor = [KKColor getColor:appMainTextColor];
        if (@available(iOS 13, *)) {
            _phoneCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入短信验证码" attributes:@{NSForegroundColorAttributeName:[KKColor getColor:appHintTextColor], NSFontAttributeName:[UIFont regularWithSize:15]}];
        }else{
            [_phoneCode setValue:[KKColor getColor:appHintTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        _phoneCode.delegate = self;
        _phoneCode.tintColor = [KKColor getColor:appMainTextColor];
        _phoneCode.keyboardType = UIKeyboardTypeDecimalPad;
        //[_phoneTextFiled addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneCode;
}

// 验证码底部线条
-(UIView *)phoneCodeBottomLineView{
    if (!_phoneCodeBottomLineView) {
        _phoneCodeBottomLineView = [[UIView alloc]init];
        _phoneCodeBottomLineView.backgroundColor = KKRGBA(216, 216, 216, 0.5);
    }
    return _phoneCodeBottomLineView;
}

// 获取验证码
-(UIButton *)getPhoneCodeButton{
    if (!_getPhoneCodeButton) {
        _getPhoneCodeButton = [[UIButton alloc]init];
        [_getPhoneCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getPhoneCodeButton.titleLabel.font = [UIFont mediumWithSize:14];
        [_getPhoneCodeButton setTitleColor:KKRGBA(143, 143, 143, 1) forState:UIControlStateNormal];
        //_getPhoneCodeButton.enabled = NO;
       // [_getPhoneCodeButton addTarget:self action:@selector(getPhoneCodeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getPhoneCodeButton;
}
// 绑定手机号底部提醒标题
-(UILabel *)bingDingBottomTipL{
    if (!_bingDingBottomTipL) {
        _bingDingBottomTipL = [[UILabel alloc]init];
        _bingDingBottomTipL.textColor = [KKColor getColor:appHintTextColor];
        _bingDingBottomTipL.font = [UIFont regularWithSize:14];
        _bingDingBottomTipL.text = @"绑定手机后可通过手机号码找回账户";
    }
    return _bingDingBottomTipL;
}
- (UIImageView *)bingDingBottomTipIcon {
    if (!_bingDingBottomTipIcon) {
        _bingDingBottomTipIcon = [[UIImageView alloc] init];
        _bingDingBottomTipIcon.image = kImage(@"mine_bing_phone_userinfo_ic");
    }
    return _bingDingBottomTipIcon;
}
// 登录
-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]init];
        _loginButton.titleLabel.font = [UIFont mediumWithSize:16];
        _loginButton.layer.cornerRadius = 23.8;
        _loginButton.layer.masksToBounds = YES;
        [self changeLoginButtonStyle:NO];
      //  [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}


@end
