//
//  LoginViewController.m
//  KK
//
//  Created by 小草 on 2021/6/23.
//

#import "LoginViewController.h"
#import "KKLoginAuthenticationVC.h"
#import "PhoneLoginView.h"
#import "KKTool.h"
#import "KKMyEditUserInfoVC.h"
#import "KKNavVC.h"
#import "LoginViewModel.h"
#import "UcPrimaryApiRecaptcha.pbobjc.h"
@interface LoginViewController ()<KKLoginDelegate>
@property (nonatomic,strong) PhoneLoginView * phoneLoginView;
@property (nonatomic,assign)NSInteger smID;// 验证码ID
@property (nonatomic,copy)NSString *smCodeContent;// 验证码内容
@property (nonatomic,assign)NSInteger reCaptchaId;// 阿里云图片验证码成功或者失败
@property (nonatomic,strong)LoginViewModel* loginVm;
@property (nonatomic,assign)BOOL canGetCode;
@property (nonatomic,strong)RACDisposable* codeTimer;
@property (nonatomic,assign)NSInteger codeSecond;
@property (nonatomic,assign)BOOL canBind;
@property (nonatomic,assign) BOOL isGetCode;
@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    KKNavVC *nav =(KKNavVC *)self.navigationController;
    nav.isForbiddenFullPopGestureRecognizer = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.phoneLoginView.phoneTextFiled becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.phoneLoginView.phoneTextFiled resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   
    KKNavVC *nav =(KKNavVC *)self.navigationController;
    nav.isForbiddenFullPopGestureRecognizer = NO;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginVm =  [LoginViewModel initWithType:self.loginType];
    [self.view addSubview:self.phoneLoginView];
    
    if (self.isUpdataPhone) {
        self.phoneLoginView.isUpdataPhone = self.isUpdataPhone;
    }
    if (self.isBingDingPhone) {
        self.phoneLoginView.isBingDingPhone = self.isBingDingPhone;
    
    }
    if (self.isSign) {
        self.phoneLoginView.isSign = self.isSign;
    }
    if (self.isSwitchACcount) {
        self.phoneLoginView.isSwitchACcount = self.isSwitchACcount;
    }
    //监听一些信息
   [self initData];
   [self initListener];
}

- (void)initData{
    self.codeSecond = 60;
}

- (void)initListener{
    [self.phoneLoginView addListener];
    //监听是否可以获取验证码
    [RACObserve(self, self.canGetCode) subscribeNext:^(id  _Nullable x) {
        BOOL b =[x boolValue];
        if(self.phoneLoginView.getPhoneCodeColor!=NULL){
            if (b) {
                if ([self.phoneLoginView.getPhoneCodeButton.titleLabel.text isEqualToString:@"重新获取"]||[self.phoneLoginView.getPhoneCodeButton.titleLabel.text isEqualToString:@"获取验证码"]) {
                    self.phoneLoginView.getPhoneCodeColor = [KKColor getColor:colorPrimary];
                    self.phoneLoginView.getPhoneCodeButton.enabled = YES;
                    self.phoneLoginView.getPhoneCodeButton.userInteractionEnabled = YES;
                }else{
                    self.phoneLoginView.getPhoneCodeColor = KKRGBA(143, 143, 143, 1);
                    self.phoneLoginView.getPhoneCodeButton.enabled = NO;
                    self.phoneLoginView.getPhoneCodeButton.userInteractionEnabled = NO;
                }
               
            }
            else{
                self.phoneLoginView.getPhoneCodeColor = KKRGBA(143, 143, 143, 1);
                self.phoneLoginView.getPhoneCodeButton.enabled = NO;
                self.phoneLoginView.getPhoneCodeButton.userInteractionEnabled = NO;
            }
        }
    }];
    //监听手机号码变动,过滤数据
    [[[self.phoneLoginView.phoneTextFiled rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        if(value == NULL){
            return NO;
        }
        if(value.length<11){
            if(value.length>0){
                if(self.phoneLoginView.getPhoneCodeColor == NULL){
                    self.phoneLoginView.getPhoneCodeColor = KKRGBA(143, 143, 143, 1);
                }
            }
            self.canGetCode =NO;
            [self.phoneLoginView changeLoginButtonStyle:NO];
            return NO;
        }
        if(value.length>11){
            self.phoneLoginView.phoneTextFiled.text = [value substringToIndex:11];
        }
        if(![KKTool isPhoneNum:value]){
            return NO;
        }
        if (value.length==11) {
            if ([self.phoneLoginView.phoneCode.text length]==4) {
                [self.phoneLoginView changeLoginButtonStyle:YES];
            }else{
                [self.phoneLoginView changeLoginButtonStyle:NO];
            }
        }else{
            [self.phoneLoginView changeLoginButtonStyle:NO];
        }
        return YES;
    }]subscribeNext:^(NSString * _Nullable x) {
        self.canGetCode =YES;
       
    }];

    //获取验证码成功消息,暂时直接放入输入框。
    [self.loginVm.getCodeSuccess subscribeNext:^(NSString*  _Nullable code) {
//#ifdef  OPEN_MODEL
                        // 测试环境需要用到
        self.phoneLoginView.phoneCode.text = code;
//#else
//// 真是环境直接使用短信验证码
//#endif
        [self codeInvide:code];
        //成功后。需要处理定时时间信息。
        self.codeTimer =[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            self.codeSecond =  self.codeSecond-1;
            if( self.codeSecond==0){
                self.codeSecond = 60;
                self.phoneLoginView.codeTitle = @"重新获取";
                self.canGetCode = YES;
                [self.codeTimer dispose];
                self.phoneLoginView.getPhoneCodeColor = [KKColor getColor:colorPrimary];
                self.phoneLoginView.getPhoneCodeButton.userInteractionEnabled = YES;
            }
            else{
                self.phoneLoginView.codeTitle = [NSString stringWithFormat:@"%li秒",(long)self.codeSecond];
                self.phoneLoginView.getPhoneCodeColor = KKRGBA(143, 143, 143, 1);
            }
        }];
    }];
    
    //验证码输入监听,过滤检测
    [[[self.phoneLoginView.phoneCode rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        return  [self codeInvide:value];
    }]subscribeNext:^(NSString * _Nullable x) {
        if ([self.phoneLoginView.phoneTextFiled.text length]==11) {
            [self.phoneLoginView changeLoginButtonStyle:YES];
        }else{
            [self.phoneLoginView changeLoginButtonStyle:NO];
        }
       
    }];
    
    //绑定成功通知
    [self.loginVm.bindSuccess subscribeNext:^(NSString*  _Nullable x) {
        [KKLoadingView hidden];
//        NSString* tip = @"绑定成功";
//        if(self.loginVm.loginType == ChangePhone){
//            tip = @"修改成功";
//        }
        // 绑定手机号/修改绑定手机号
        if (self.loginType == ChangePhone) {
            [SVProgressHUD showMessage:@"修改成功"];
            
            // 从webview进入的直接返回webview
            if (self.isWebviewFrom == YES) {
                [self.navigationController popViewControllerAnimated:YES];
                [kNotificationCenter postNotificationName:KKSwitchACcountNotificationCenter object:nil];
                [kUserDefaults setObject:kStringIsEmpty(x)? self.phoneLoginView.phoneTextFiled.text:x forKey:@"telephone"];// 用户绑定后才会出现的手机号
                return;
            }
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
               if ([controller isKindOfClass:[KKMyEditUserInfoVC class]]) {
                   KKMyEditUserInfoVC *vc = (KKMyEditUserInfoVC *)controller;
                   if (vc.editUpdatePhoneBlock) {
                       vc.editUpdatePhoneBlock(kStringIsEmpty(x)? self.phoneLoginView.phoneTextFiled.text:x);
                   }
                   [kNotificationCenter postNotificationName:KKSwitchACcountNotificationCenter object:nil];
                   [kUserDefaults setObject:kStringIsEmpty(x)? self.phoneLoginView.phoneTextFiled.text:x forKey:@"telephone"];// 用户绑定后才会出现的手机号
                   [self.navigationController popToViewController:controller animated:YES];
                   return;
               }
           }
        }
        else if(self.loginType == BindPhone) {
            [SVProgressHUD showMessage:@"手机号绑定成功"];
            [kNotificationCenter postNotificationName:KKSwitchACcountNotificationCenter object:nil];
            [kUserDefaults setObject:kStringIsEmpty(x)? self.phoneLoginView.phoneTextFiled.text:x forKey:@"telephone"];// 用户绑定后才会出现的手机号
            
            if (self.isWebviewFrom == YES) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        else if(self.loginType == ChangeAccont){
            [SVProgressHUD showMessage:@"切换账户成功!"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [kNotificationCenter postNotificationName:KKSwitchACcountNotificationCenter object:nil];
            [kUserDefaults setObject:kStringIsEmpty(x)? self.phoneLoginView.phoneTextFiled.text:x forKey:@"telephone"];// 用户绑定后才会出现的手机号
        }
    }];
    
    //点击获取验证码
    
    [self.phoneLoginView.getPhoneCodeButton addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [[self.phoneLoginView.getPhoneCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        if(!self.canGetCode){
//            return;
//        }
//
//
////        KKLoginAuthenticationVC * loginAuthenticationVC = [[KKLoginAuthenticationVC alloc]init];
////        [loginAuthenticationVC setKKLoginAuthenticationCommintBlock:^{
//        if (!self.isGetCode) {
//            self.isGetCode = YES;
//            [self.loginVm getCode:self.phoneLoginView.phoneTextFiled.text :self.isSign withBlock:^(BOOL isGetCode) {
//                self.isGetCode = NO;
//            }];
//        }
//
////        }];
////        loginAuthenticationVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
////        loginAuthenticationVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
////        [self presentViewController:loginAuthenticationVC animated:NO completion:nil];
//    }];
    //点击登陆按钮,执行绑定逻辑
    [[self.phoneLoginView.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        if (self.phoneLoginView.phoneTextFiled.text.length <11) {
            [SVProgressHUD showMessage:@"请输入正确的手机号"];
            return;
        }
        if(!self.canBind){
            [SVProgressHUD showMessage:@"验证码不正确"];
            return;
        }
        [KKLoadingView showFullScreen];
        [self.loginVm onBtnLoginOk:self.phoneLoginView.phoneCode.text];
    }];
    
}

-(void)getCodeClick:(UIButton *)sender{
    if(!self.canGetCode){
        return;
    }
    self.phoneLoginView.getPhoneCodeButton.userInteractionEnabled = NO;
    [self.loginVm getCode:self.phoneLoginView.phoneTextFiled.text :self.isSign];
    
}

//验证码处理
-(BOOL)codeInvide:(NSString*)value{
    if(value == NULL){
        return NO;
    }
    if(value.length<4){
        [self.phoneLoginView changeLoginButtonStyle:NO];
        self.canBind = NO;
        return false;
    }
    if(value.length>4){
        self.phoneLoginView.phoneCode.text = [value substringToIndex:4 ];
    }
    [self.phoneLoginView changeLoginButtonStyle:YES];
    self.canBind = YES;
    return YES;
}
 
// 懒加载登录视图
-(PhoneLoginView *)phoneLoginView{
    if (!_phoneLoginView) {
        _phoneLoginView = [[PhoneLoginView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT)];
    }
    return _phoneLoginView;
}
@end


