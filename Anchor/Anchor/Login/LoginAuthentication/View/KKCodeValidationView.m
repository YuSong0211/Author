//
//  KKCodeValidationView.m
//  KK
//
//  Created by ProgramMa on 2021/9/3.
//

#import "KKCodeValidationView.h"
#import "KKCodeValidationModel.h"
#import "UIButton+EnlargeTouchArea.h"
@interface KKCodeValidationView ()<UITextFieldDelegate>
// 背景
@property (nonatomic,strong) UIView *backView;
//图形
@property (nonatomic,strong) UIImageView *CodeView;
// 提示文字
@property (nonatomic,strong) UILabel * titleLab;
// 确定按钮
@property (nonatomic,strong) UIButton * confirButton;
@property (nonatomic,strong) UIButton * closeBtn;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UIImageView *codeImageView;
@property(nonatomic,strong)UIView *line;
// 确定渐变阴影
@property (nonatomic,strong) CAGradientLayer * confirButtonLayer;

@property(nonatomic,strong)KKCodeValidationModel *ValidationModel;
@property(nonatomic,assign)NSInteger id_p;

@end
@implementation KKCodeValidationView

-(KKCodeValidationModel*)ValidationModel{
    if (!_ValidationModel) {
        _ValidationModel = [[KKCodeValidationModel alloc]init];
    }
    
    return _ValidationModel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [KKColor getColor:memberalerAlertBgColor];
        [self addSubview:self.backView];
        [self.backView addSubview:self.titleLab];
        [self.backView addSubview:self.codeField];
        [self.backView addSubview:self.codeImageView];
        [self.backView addSubview:self.confirButton];
        [self.backView addSubview:self.line];
        [self.backView addSubview:self.closeBtn];
        [self.ValidationModel requestCodeVAlidation:^(NSInteger id_p, NSData * _Nonnull imageSrc) {
            self.codeImageView.image = [UIImage imageWithData:imageSrc];
            self.id_p = id_p;
        }];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 背景
    self.backView.frame = CGRectMake(50, KK_NAV_BAR_HEIGHT + 80, self.frame.size.width - 100, 250);
    // 标题
    self.titleLab.frame = CGRectMake(0, 20, self.backView.frame.size.width, 22);
    
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.backView).offset(2);
        make.size.mas_equalTo(CGSizeMake(KK_SCREEN_WIDTH/2 -50-20, 50));
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backView);
        make.left.equalTo(self.backView.mas_left).offset(20);
        make.right.equalTo(self.codeImageView.mas_left).offset(-15);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeField.mas_bottom).offset(5);
        make.left.equalTo(self.codeField.mas_left);
        make.right.equalTo(self.codeField.mas_right);
        make.height.mas_equalTo(1);
    }];
    // 确认按钮
//    self.confirButton.frame = CGRectMake(self.backView.frame.size.width - 16 - 80, CGRectGetMaxY(self.frame)+100, 80, 30);
    [self.confirButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(20);
        make.right.equalTo(self.backView.mas_right).offset(-20);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-25);
        make.height.mas_equalTo(40);
    }];
//    [KKGeneralGradientColor KK_createByCAGradientLayer:KK_GRDIENT_THEMECOLOR direction:GradientTypeLeftToRight layerView:self.confirButton isConstraint:YES];
    self.confirButton.layer.masksToBounds = YES;
    self.confirButton.layer.cornerRadius = 20;
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-15);
        make.top.equalTo(self.backView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.closeBtn setEnlargeEdge:15];
}

#pragma mark -- 创建缩放动画
// 出现
-(void)show{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backView.layer.transform = CATransform3DMakeScale(1, 1, 0.5);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)closeClick:(UIButton *)sender{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

// 消失
-(void)hidden:(BOOL)isAnimate{
    self.backView.layer.transform = CATransform3DIdentity;
    if (isAnimate == YES) {
        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backView.layer.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.5);
        } completion:^(BOOL finished) {
        }];
    }else{
        self.backView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.5);
    }
}

/// 改变按钮状态
/// @param isEnable YES 可点击 NO不可点击
-(void)changeConfirmButton:(BOOL)isEnable{
    self.confirButton.enabled = isEnable;
    if (isEnable == YES) {
        // 可点击
        // 改变文字颜色
        // 移除 之前可能创建好的内容
        [self.confirButtonLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.confirButtonLayer removeFromSuperlayer];
        self.confirButtonLayer = nil;

        // 按钮渐变
        self.confirButtonLayer = [CAGradientLayer layer];
        self.confirButtonLayer.frame = self.confirButton.bounds;
        self.confirButtonLayer.startPoint = CGPointMake(0, 0.5);
        self.confirButtonLayer.endPoint = CGPointMake(1, 0.5);
        self.confirButtonLayer.colors =@[(id)[KKColor getColor:colorPrimary].CGColor,(id)[KKColor getColor:colorPrimaryDark].CGColor];
        self.confirButtonLayer.locations = @[@(0),@(1.0f)];
        self.confirButtonLayer.cornerRadius = 15;
        [self.confirButton.layer insertSublayer:self.confirButtonLayer atIndex:0];//注意添加顺序
        [self.confirButton setTitleColor:[KKColor getColor:colorMainBtnText] forState:UIControlStateNormal];
    }else{
        // 移除
        [self.confirButtonLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.confirButtonLayer removeFromSuperlayer];
        self.confirButtonLayer = nil;
        // 不可点击
        [self.confirButton setTitleColor:[KKColor getColor:colorSecondBtnText] forState:UIControlStateNormal];
        self.confirButton.backgroundColor = [KKColor getColor:colorSecondBtnBg];
    }
}

-(void)CodeClick{
    
    [self.ValidationModel requestCodeVAlidation:^(NSInteger id_p, NSData * _Nonnull imageSrc) {
        self.codeImageView.image = [UIImage imageWithData:imageSrc];
        self.id_p = id_p;
    }];
    
}

// 点击确认按钮
-(void)clickConfirmButton{
    
    [self.ValidationModel requestSendCodeID:self.id_p withCodeText:self.codeField.text WithValidationBlock:^(BOOL isScuess, NSInteger Id_p) {
        if (isScuess) {
            if ([self.delegate respondsToSelector:@selector(clickConfirmAuthenticationIds:)]) {
                [self.delegate clickConfirmAuthenticationIds:nil];
            }
            
        }else{
            [SVProgressHUD showMessage:@"输入失败，请重试"];
        }
    }];
}

// 背景
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [KKColor getColor:appMainCardBgColor];
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

// 标题
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"图形验证码";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont mediumWithSize:16];
        _titleLab.textColor =  [KKColor getColor:appMainTextColor];
    }
    return _titleLab;
}

// 确认
-(UIButton *)confirButton{
    if (!_confirButton) {
        _confirButton = [[UIButton alloc]init];
        [_confirButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirButton.titleLabel.font = [UIFont mediumWithSize:14];
        _confirButton.layer.cornerRadius = 15;
//        [_confirButton setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
        [self changeConfirmButton:NO];
        [_confirButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirButton;
}

// quxiao
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"iconSearchDelete"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UITextField *)codeField{
    if (!_codeField) {
        
        _codeField = [[UITextField alloc]init];
        _codeField.placeholder = @"请输入验证码";
        _codeField.font = [UIFont regularWithSize:15];
        _codeField.textColor = [KKColor getColor:appHintTextColor];
        _codeField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        if (@available(iOS 13, *)) {
            _codeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[KKColor getColor:appHintTextColor], NSFontAttributeName:[UIFont regularWithSize:15]}];
        }else{
            [_codeField setValue:[KKColor getColor:appHintTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        _codeField.tintColor = [KKColor getColor:appMainTextColor];
        [self.codeField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeField;
}

-(void)textFieldDidEditing:(UITextField *)textField{
    if (textField == self.codeField) {
        if ([textField.text length]>0) {
            _confirButton.userInteractionEnabled = YES;
            [self changeConfirmButton:YES];
//            _confirButton.backgroundColor =KKRGBA(20, 223, 129, 1);
//            [_confirButton setTitleColor:[KKColor getColor:appBgColor] forState:UIControlStateNormal];
        }else{
            
            _confirButton.userInteractionEnabled = NO;
            [self changeConfirmButton:NO];
//            _confirButton.backgroundColor =KKRGBA(56, 58, 68, 1);
//            [_confirButton setTitleColor:KKRGBA(143, 143, 143, 1) forState:UIControlStateNormal];
        }
    }
}

-(UIImageView *)codeImageView{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]init];
        _codeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CodeClick)];
        [_codeImageView addGestureRecognizer:tap];
    }
    return _codeImageView;
}
-(UIView*)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor =KKRGBA(216, 216, 216, 0.3);
    }
    return _line;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
