//
//  KKPublishCommuityVCViewController.m
//  mt
//
//  Created by 小草 on 2021/9/14.
//

#import "KKPublishCommuityVC.h"
#import "KKPublishCommuityScrollview.h" // 滚动视图兼控件容器
#import "KKUploadOssModel.h"
#import "KKPublishShortSelectVideoAlertView.h"
#import "KKPublishVC.h"
#import "KKPublishCommuityViewModel.h" // 发布页面的viewmodel
@interface KKPublishCommuityVC ()<KKPublishShortVideoViewDelegate,KKPublishCommuityViewModelDelegate>

@property (nonatomic,strong) KKPublishCommuityScrollview * scrollview;

@property (nonatomic,strong) KKUploadOssModel * uploadSuperModel;

@property (nonatomic,strong) NSMutableArray * ossFileArray;

@property (nonatomic,strong) NSMutableArray * uploadFilePathArray;

@property (nonatomic,strong) KKPublishShortSelectVideoAlertView *videoAlertView;

@property (nonatomic,strong) KKPublishCommuityViewModel * uploadViewModel; // 上传viewModel

@end

@implementation KKPublishCommuityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetWorkChangenotification:) name:@"NetWorkChangenotification" object:nil];
    [self createUI];
}

-(void)createUI{
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.videoAlertView];
    [self.videoAlertView dissmisView];
}

// 开始上传
-(void)saveThepublishVideoInfo:(KKUploadInfoModel *)videoInfo{
    if (videoInfo.soucreArray.count > 0) {
        // 展示上传样式
        [self.videoAlertView showInView];
        // 重置上传样式
        self.videoAlertView.uploadProgress = 0;
        
        // 非纯本
        [self.uploadViewModel mediaSourceUploadWithText:self.scrollview.contentInputView.text tagArray:self.scrollview.tagsArr fileModel:videoInfo];
    }else{
        [KKLoadingView showInView:self.view];
        // 纯文本
        [self.uploadViewModel singleTextToUpload:self.scrollview.contentInputView.text tagArray:self.scrollview.tagsArr];
    }
}

// 上传成功回调
-(void)uploadSuccess{
    [self.videoAlertView dissmisView];
    [SVProgressHUD showMessage:@"上传成功"];
}


#pragma mark -- KKPublishCommuityViewModelDelegate
// 纯文本请求回调
-(void)singleTextUploadComplte:(KKUploadState)commuityType{
    [KKLoadingView hideInView:self.view];
    
    if (commuityType == KKUploadStateUploadComplete) {
        [SVProgressHUD showMessage:@"发布成功"];
        [self uploadSuccess];
    }else  if (commuityType == KKUploadStateUploadFailed) {
        [self clickCancelUpload:NO];
        if (![[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
            [SVProgressHUD showMessage:@"网络请求失败，请检查网络后重试"];
        }else{
            [SVProgressHUD showMessage:@"发布失败,请重试"];
        }
    }else if (commuityType == KKUploadStateUploadForbiddenWords){
        [SVProgressHUD showMessage:@"您已被禁言，无法发布"];
        [self clickCancelUpload:NO];
    }
}

// 媒体资源文件上传
-(void)mediaSourceUploadComplte:(KKUploadState)commuityType
                       progress:(CGFloat)progress
                  isGetProgress:(BOOL)isGetProgress
                    uploadModel:(KKUploadInfoModel* )uploadModel{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 上传中
        if (commuityType == KKUploadStateUploading) {
            CGFloat uploadProgress = progress;
            // 纯图片和视频计算进度方式不一样
            if (uploadModel.isImage) {
                uploadProgress = 100.0/uploadModel.soucreArray.count;
                if (self.videoAlertView.uploadProgress >= 100) {
                    self.videoAlertView.uploadProgress = 100;
                }else{
                    self.videoAlertView.uploadProgress += uploadProgress;
                }
            }else{
                if (isGetProgress) {
                    self.videoAlertView.uploadProgress = uploadProgress;
                }
            }
        }else if (commuityType == KKUploadStateUploadComplete){
            // 上传完成
            [SVProgressHUD showMessage:@"发布成功"];
            [self.videoAlertView dissmisView];
            // 跳转到发布页面
            [self uploadSuccess];
        }else if (commuityType == KKUploadStateUploadFailed){
            // 上传失败
            [self clickCancelUpload:NO];
            if (![[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
                [SVProgressHUD showMessage:@"网络请求失败，请检查网络后重试"];
            }else{
                [SVProgressHUD showMessage:@"发布失败,请重试"];
            }
            
        }else if (commuityType == KKUploadStateUploadForbiddenWords){
            [SVProgressHUD showMessage:@"您已被禁言，无法发布"];
            [self clickCancelUpload:NO];
        }else if (commuityType == KKUploadStateUploadCancel){
            [SVProgressHUD showMessage:@"取消成功"];
            [self clickCancelUpload:NO];
        }
    });
}

// 网络改变上传失败，取消上传
-(void)NetWorkChangenotification:(NSNotification *)nofi{
    
    if ([NetWrokStatesCtrl getInstance].KKNetWorkState == KKNetUnknown || [NetWrokStatesCtrl getInstance].KKNetWorkState== KKNetLose) {
        [self clickCancelUpload:NO];
    };
}

// 取消上传
-(void)clickCancelUpload:(BOOL)isNotiService{
    [self.videoAlertView dissmisView];
    [self.uploadViewModel commuityCancelUpload:isNotiService];
}

-(KKPublishCommuityScrollview *)scrollview{
    if (!_scrollview) {
        _scrollview = [[KKPublishCommuityScrollview alloc]initWithFrame:CGRectMake(0, 44, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT-44)];
        _scrollview.delegate = self;
    }
    return _scrollview;
}

// 上传提示
- (KKPublishShortSelectVideoAlertView *)videoAlertView {
    if (!_videoAlertView) {
        _videoAlertView  =[[KKPublishShortSelectVideoAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, KK_SCREEN_HEIGHT-44)];
        WS
        [_videoAlertView setCancelButtonClickBlock:^{
            SS
            [self clickCancelUpload:YES];
        }];
    }
    return _videoAlertView;
}

-(NSMutableArray *)ossFileArray{
    if (!_ossFileArray) {
        _ossFileArray = [[NSMutableArray alloc]init];
    }
    return _ossFileArray;
}

-(NSMutableArray *)uploadFilePathArray{
    if (!_uploadFilePathArray) {
        _uploadFilePathArray = [[NSMutableArray alloc]init];
    }
    return _uploadFilePathArray;
}

// 上传Model
-(KKPublishCommuityViewModel *)uploadViewModel{
    if (!_uploadViewModel) {
        _uploadViewModel = [[KKPublishCommuityViewModel alloc]init];
        _uploadViewModel.delegate = self;
    }
    return _uploadViewModel;
}
@end
