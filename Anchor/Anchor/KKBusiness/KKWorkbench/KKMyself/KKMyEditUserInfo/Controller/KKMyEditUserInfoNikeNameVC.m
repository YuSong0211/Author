//
//  KKMyEditUserInfoNikeNameVC.m
//  KK
//
//  Created by ProgramMa on 2021/7/28.
//

#import "KKMyEditUserInfoNikeNameVC.h"
#import "UITextField+Extension.h"
@interface KKMyEditUserInfoNikeNameVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *textF;
@property (nonatomic,strong)UILabel *tipL;
@end

@implementation KKMyEditUserInfoNikeNameVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textF becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置名字";
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(sucess)];
    self.navigationItem.rightBarButtonItem = item;
    self.textF.text = self.nikeName;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont regularWithSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.view addSubview:self.textF];
    [self.view addSubview:self.tipL];
    [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(0);
    }];
    [self.tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.textF.mas_bottom).offset(5);
    }];
    [self.textF calculateTextViewWordNum:self.tipL num:15];
    [kNotificationCenter addObserver:self selector:@selector(textViewTextDidChangeNotification) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textViewTextDidChangeNotification {
    [self.textF calculateTextViewWordNum:self.tipL num:15];
}
-(void)sucess {
    if (kStringIsEmpty(self.textF.text)) {
        [self.navigationController popViewControllerAnimated:YES];
//        [SVProgressHUD showMessage:@"用户昵称不能为空"];
        return;
    }
//    else if ([self.textF.text length]<3){
//        [SVProgressHUD showMessage:@"请输入不少于3个字符"];
//        return;
//    }
    if ([[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
        if (self.editUserInfoNikeNameBlock) {
            self.editUserInfoNikeNameBlock(self.textF.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showMessage:@"网络连接失败，请检查网络重试"];
    }
    
}
- (UITextField *)textF {
    if (!_textF) {
        _textF = [[UITextField alloc] init];
        NSString *holderText = @"请输入新昵称";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName
                                value:[KKColor getColor:appHintTextColor]
                                range:NSMakeRange(0, holderText.length)];
        [placeholder addAttribute:NSFontAttributeName
                                value:[UIFont regularWithSize:16]
                                range:NSMakeRange(0, holderText.length)];
        _textF.attributedPlaceholder = placeholder;
        _textF.font = [UIFont regularWithSize:16];
        _textF.clearButtonMode = UITextFieldViewModeAlways;
        _textF.textColor =[KKColor getColor:appMainTextColor];
        _textF.returnKeyType = UIReturnKeyDone;
        [_textF setDelegate:self];
        _textF.backgroundColor = [KKColor getColor:appEditTextBgColor];
//        _textF.layer.borderColor = KKRGBA(234, 234, 234, 1).CGColor;
//        _textF.layer.borderWidth = 0.5;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _textF.leftViewMode = UITextFieldViewModeAlways;
        _textF.leftView = leftView;
    }
    return _textF;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sucess];
    return YES;
}

- (UILabel *)tipL {
    if (!_tipL) {
        _tipL = [[UILabel alloc] init];
        _tipL.textColor = [KKColor getColor:appHintTextColor];
        _tipL.font = [UIFont regularWithSize:14];
    }
    return _tipL;
}

@end
