//
//  KKShareCodeViewController.m
//  mt
//
//  Created by ProgramMa on 2021/10/19.
//

#import "KKShareCodeViewController.h"
#import "UITextField+Extension.h"
#import "KKShareCodeModel.h"
@interface KKShareCodeViewController ()
@property (nonatomic,strong)UITextField *textF;
@property (nonatomic,strong)UILabel *tipL;
@property (nonatomic,strong)KKShareCodeModel *model;
@end

@implementation KKShareCodeViewController

-(KKShareCodeModel *)model{
    if (!_model) {
        _model = [[KKShareCodeModel alloc]init];
    }
    return _model;
}

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
    self.navigationItem.title = @"绑定推广码";
    self.view.backgroundColor = [KKColor getColor:appBgColor];
   
    [self.view addSubview:self.textF];
//    [self.view addSubview:self.tipL];
    [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(0);
    }];
    MJWeakSelf;
    [self.model getShareCode:^(NSString * _Nonnull shareCode) {
        
        if (!kStringIsEmpty(shareCode)) {
            weakSelf.textF.text = shareCode;
            weakSelf.textF.enabled = NO;
            weakSelf.textF.clearButtonMode = UITextFieldViewModeNever;
        }else{
            weakSelf.textF.enabled = YES;
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(sucess)];
            self.navigationItem.rightBarButtonItem = item;
            NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
            textAttrs[NSForegroundColorAttributeName] = [KKColor getColor:appHintTextColor];
            textAttrs[NSFontAttributeName] = [UIFont regularWithSize:15];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            
        }
    }];
//    [self.tipL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.height.mas_equalTo(20);
//        make.top.mas_equalTo(self.textF.mas_bottom).offset(5);
//    }];
//    [self.textF calculateTextViewWordNum:self.tipL num:20];
//    [kNotificationCenter addObserver:self selector:@selector(textViewTextDidChangeNotification) name:UITextFieldTextDidChangeNotification object:nil];
}
//- (void)textViewTextDidChangeNotification {
//    [self.textF calculateTextViewWordNum:self.tipL num:20];
//}
-(void)sucess {
    if (kStringIsEmpty(self.textF.text)) {
        [SVProgressHUD showMessage:@"推广码不能为空"];
        return;
    }
    
    [self.model sendShareCode:self.textF.text withBlock:^(BOOL isSucess, NSInteger errorCode) {
        if (isSucess) {
            [SVProgressHUD showMessage:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if (errorCode == 20032) {
                [SVProgressHUD showMessage:@"邀请码不存在"];
            }else if (errorCode == 20034){
                [SVProgressHUD showMessage:@"邀请码已被邀请"];
            }else if (errorCode ==20041){
                [SVProgressHUD showMessage:@"您的账户暂不允许绑定"];
            }else{
                [SVProgressHUD showMessage:@"系统出错"];
            }
        }
    }];
    
  
}
-(void)textFieldBeginEditing:(UITextField *)textField{
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [KKColor getColor:appHintTextColor];
    textAttrs[NSFontAttributeName] = [UIFont regularWithSize:15];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
}
-(void)textFieldDidEditing:(UITextField *)textfield{
    if (textfield.text.length>0) {
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [KKColor getColor:appMainTextColor];
        textAttrs[NSFontAttributeName] = [UIFont regularWithSize:15];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    }else{
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [KKColor getColor:appHintTextColor];
        textAttrs[NSFontAttributeName] = [UIFont regularWithSize:15];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    }
}

- (UITextField *)textF {
    if (!_textF) {
        _textF = [[UITextField alloc] init];
        NSString *holderText = @"请输入推广码";
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
        _textF.backgroundColor = [KKColor getColor:appEditTextBgColor];
//        _textF.layer.borderColor = KKRGBA(234, 234, 234, 1).CGColor;
//        _textF.layer.borderWidth = 0.5;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _textF.leftViewMode = UITextFieldViewModeAlways;
        _textF.leftView = leftView;
        [_textF addTarget:self action:@selector(textFieldBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
        [_textF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textF;
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
