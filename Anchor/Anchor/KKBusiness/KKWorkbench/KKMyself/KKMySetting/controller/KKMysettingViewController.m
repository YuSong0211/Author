//
//  KKMysettingViewController.m
//  KK
//
//  Created by 小草 on 2021/6/29.
//

#import "KKMysettingViewController.h"
#import "KKMysettingListView.h"
#import "LoginViewController.h"

#import "KKDeveloperModeViewController.h"
#import "AppVersionMgr.h"
static NSInteger maxCount = 30;

#import "KKShareCodeViewController.h"

@interface KKMysettingViewController ()

@property (nonatomic,strong) KKMysettingListView * settingListView;
@property (nonatomic,strong) UIButton * versionAltLab;
@property (nonatomic,assign) NSInteger clickCount;

@end

@implementation KKMysettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    [self createUI];
}

-(void)createUI{
    [self.view addSubview:self.settingListView];
    self.title = @"设置";
    [self.view addSubview:self.versionAltLab];
    [self.versionAltLab mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(60);
        } else {
            // Fallback on earlier versions
            make.bottom.equalTo(self.view).inset(60);
        }
        make.centerX.equalTo(self.view);
        make.height.equalTo(@30);
    }];
}

-(UIButton *)versionAltLab{
    if (!_versionAltLab) {
        _versionAltLab = [[UIButton alloc]init];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString * app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *version = [[AppVersionMgr shareMgr]getVersion:NO];
        [_versionAltLab setTitle:[NSString stringWithFormat:@"当前版本：v%@",version] forState:UIControlStateNormal];
        [_versionAltLab setTitleColor:[KKColor getColor:appHintTextColor] forState:UIControlStateNormal];
        _versionAltLab.titleLabel.font = [UIFont mediumWithSize:13];
        [_versionAltLab addTarget:self action:@selector(versionAltLabAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _versionAltLab;
}

- (void)versionAltLabAction {
    self.clickCount += 1;
    if (self.clickCount >= maxCount) {
        [self.navigationController pushViewController:[KKDeveloperModeViewController new] animated:YES];
        self.clickCount = 0;
    }
    
}

// 我的设置列表
-(KKMysettingListView *)settingListView{
    if (!_settingListView) {
        _settingListView = [[KKMysettingListView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT)];
        WEAK_REF(self);
        [_settingListView setKKMysettingSwitchACcountBlock:^{
            STRONG_REF(self);
            LoginViewController *selectVC = [[LoginViewController alloc] init];
            selectVC.loginType = ChangeAccont;
            selectVC.isSwitchACcount = YES;
            [self.navigationController pushViewController:selectVC animated:YES];
        }];
        
        [_settingListView setKKMysettingShareCodeBlock:^{
            STRONG_REF(self);
            KKShareCodeViewController *code  =[[KKShareCodeViewController alloc]init];
            [self.navigationController pushViewController:code animated:YES];
            
        }];
    }
    return _settingListView;
}
@end
