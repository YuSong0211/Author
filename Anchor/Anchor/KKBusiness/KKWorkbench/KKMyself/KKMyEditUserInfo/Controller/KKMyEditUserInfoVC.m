//
//  KKMyEditUserInfoVC.m
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import "KKMyEditUserInfoVC.h"
#import "KKMyEditUserInfoListView.h"
#import "LoginViewController.h"
#import "KKMyEditUserInfoNikeNameVC.h"
#import "NSString+Extension.h"
#import "KKMyEditUserInfoViewModel.h"
#import "KKUploadModel.h" // 上传model

@interface KKMyEditUserInfoVC ()<KKPubLishVideoDataDelegate>

@property (nonatomic,strong) KKMyEditUserInfoListView * userInfoListView;
@property (nonatomic,assign)appvapiGenders genders;// 性别
@property (nonatomic,copy)NSString *intro;// 简介
@property (nonatomic,copy)NSString *nikeName;// 昵称
@property (nonatomic,strong)UIImage * selectUserAvatarImage;
@property (nonatomic,strong)KKMyEditUserInfoViewModel *viewModel;
@property (nonatomic,strong)KKUploadModel * uploadModel;
@end

@implementation KKMyEditUserInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    self.title = @"修改资料";
    [self createUI];
    [self.userInfoListView.tableview.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    if (self.basic.gender != self.genders || ![self.basic.intro isEqualToString:self.intro] || ![self.basic.nickname isEqualToString:self.nikeName]) {
//        [KKMyEditUserInfoViewModel apiUpdataUserInfo:self.nikeName gender:self.genders intro:self.intro];
//    }
}
-(void)setBasic:(appvapiUserInfoBasic *)basic {
    _basic = basic;
    self.userInfoListView.basic = _basic;
}

-(void)createUI{
    [self.view addSubview:self.userInfoListView];
    WS
    self.genders = self.basic.gender;
    self.intro = self.basic.intro;
    self.nikeName = self.basic.nickname;
    [self.userInfoListView setSelectGenderBlock:^(appvapiGenders isMan) {
        SS
        // 性别
        self.genders = isMan;
        [KKMyEditUserInfoViewModel apiUpdataUserInfo:nil gender:self.genders intro:nil];
    }];
    [self.userInfoListView setTextViewTextDidChangeNotificationBlock:^(NSString * _Nonnull content) {
        SS
        // 简介
        self.intro = content;
        
    }];
    [self.userInfoListView setTextViewTextDidEndNotificationBlock:^(NSString * _Nonnull content) {
        SS
        [KKMyEditUserInfoViewModel apiUpdataUserInfo:nil gender:nil intro:self.intro];
    }];
    [self.userInfoListView setEditUserInfoNikeNameBlock:^{
        SS
        // 修改昵称
        KKMyEditUserInfoNikeNameVC *vc = [[KKMyEditUserInfoNikeNameVC alloc] init];
        [vc setEditUserInfoNikeNameBlock:^(NSString * _Nonnull content) {
            self.nikeName = content;
            self.userInfoListView.nikeName = content;
            [KKMyEditUserInfoViewModel apiUpdataUserInfo:self.nikeName gender:nil intro:nil];
        }];
        vc.nikeName = self.nikeName;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.userInfoListView setUpdataAvterBlock:^(UIImage * _Nonnull selectImage) {
        SS
        [KKLoadingView showFullScreen];
        self.selectUserAvatarImage = selectImage;
        // 修改头像
        KKUploadInfoModel * infoModel = [[KKUploadInfoModel alloc] init];
        infoModel.isImage = YES;
        UploadOSSDataModel * ossDataModel = [[UploadOSSDataModel alloc]init];
        ossDataModel.image = selectImage;
        ossDataModel.objectName = [NSString stringWithFormat:@"/iOS_avatarImage_%@.jpg",[NSString getNowTimeTimestamp]];
        ossDataModel.isImage = YES;
        [infoModel.soucreArray addObject:ossDataModel];
        // 上传用户头像
        [self.uploadModel avaterBeginUploadWithInfo:infoModel];
        
    }];
    [self.userInfoListView setUpdataBingPhoneBlock:^{
        SS
        // 修改绑定手机号
        LoginViewController *login = [[LoginViewController alloc]init];
        login.isUpdataPhone = YES;
        login.loginType = ChangePhone;
        [self.navigationController pushViewController:login animated:YES];
    }];
    [self setEditUpdatePhoneBlock:^(NSString * _Nonnull phone) {
        SS
        // 回显修改后的绑定手机号
        self.userInfoListView.phone = phone;
    }];
}

// 当前上传头像状态
-(void)currentUploadProgress:(CGFloat)progress uploadState:(KKUploadState)state isGetProgress:(BOOL)isGetProgress{
    if (state == KKUploadStateUploadComplete) {
        // 上传完成
        NSLog(@"上传完成");
        // 刷新成功
        self.userInfoListView.selectImage = self.selectUserAvatarImage;
        [KKUserInfo share].userImage = self.selectUserAvatarImage;
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [KKLoadingView hidden];
            [SVProgressHUD showMessage:@"设置成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:UPDATEOUSERHEADERIMAGECENTER object:nil];
        });
    }else if (state == KKUploadStateUploadFailed) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [KKLoadingView hidden];
            [SVProgressHUD showMessage:@"上传失败"];
        });
      
       
    }
//    else if (state == KKUploadStateUploadForbiddenWords){
//        [KKLoadingView hidden];
//        [SVProgressHUD showMessage:@"您已被禁言，上传失败"]; // 禁言可能不需要
//    }
}

-(KKMyEditUserInfoListView *)userInfoListView{
    if (!_userInfoListView) {
        _userInfoListView = [[KKMyEditUserInfoListView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT)];
    }
    return _userInfoListView;
}
- (KKMyEditUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[KKMyEditUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

// 上传model
-(KKUploadModel *)uploadModel{
    if (!_uploadModel) {
        _uploadModel = [[KKUploadModel alloc]init];
        _uploadModel.delegate = self;
    }
    return _uploadModel;
}
@end
