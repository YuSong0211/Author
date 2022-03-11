//
//  KKLoginAuthenticationVC.m
//  KK
//
//  Created by 小草 on 2021/7/5.
//

#import "KKLoginAuthenticationVC.h"
#import "KKLoginAuthenticationView.h"
#import "KKCodeValidationView.h"
@interface KKLoginAuthenticationVC ()<KKLoginAuthenticationDelegate>

@property (nonatomic,strong) KKCodeValidationView *  authenticationView;

@end

@implementation KKLoginAuthenticationVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.authenticationView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configView];
}

// 创建登录视图
-(void)configView{
    [self.view addSubview:self.authenticationView];
    [self.authenticationView hidden:NO];
    MJWeakSelf;
    [self.authenticationView setCloseBlock:^{
        [weakSelf.authenticationView hidden:YES];
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark -- KKLoginAuthenticationDelegate
-(void)clickConfirmAuthenticationIds:(NSMutableArray *)ids{
    [self.authenticationView hidden:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.KKLoginAuthenticationCommintBlock) {
            self.KKLoginAuthenticationCommintBlock();
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}


-(KKCodeValidationView *)authenticationView{
    if (!_authenticationView) {
        _authenticationView = [[KKCodeValidationView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT)];
        _authenticationView.delegate =self;
    
    }
    return _authenticationView;
}
@end
