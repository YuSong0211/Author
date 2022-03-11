
//
//  KKPublishVC.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKPublishShortVideoVC.h"
#import "KKPublishShortVideoView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "KKPubTagVC.h"
#import "TZImagePickerController.h"
#import "KKNavVC.h"
#import "SelectMediaMoudle.h"
#import "AlpEditCoverViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "KKPublishShortLookVideoVC.h"
#import "KKPubTagVCModel.h"
#import "AlpVideoSliderTimeClip.h"
#import "KKPublishVC.h"
#import "WAVideoBox.h" // 压缩视频使用
#import "KKUploadModel.h" // viewModel
#import <mobileffmpeg/MobileFFmpegConfig.h>
#import <mobileffmpeg/MobileFFmpeg.h>
#import "KKPermissionUtils.h"
@interface KKPublishShortVideoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,KKPublishShortVideoViewDelegate,KKPubLishVideoDataDelegate,ExecuteDelegate>
@property (nonatomic, strong) KKPublishShortVideoView *pubView;
@property (nonatomic, strong) NSMutableArray *tagDataArray;
@property (nonatomic, strong) NSMutableArray *selecteDataArray;
@property (nonatomic, assign) BOOL isSelectVideo;
@property (nonatomic, assign) BOOL isSelectLb;
@property (nonatomic, copy)NSString *videoPath;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat proGressIndex;
@property (nonatomic, assign) CGFloat clipTime; // 选取封面的时间
@property (nonatomic, assign) CGFloat thumbLocation; // 选取封面后 进度条上滑块的位置
@property (nonatomic, strong) UIImage *clipSelectImage;  // 选取封面的图片
@property (nonatomic, strong) KKUploadModel * publishViewModel; // viewmodel

@property (nonatomic , strong) WAVideoBox *videoBox; // 压缩处理
@end

@implementation KKPublishShortVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.proGressIndex = 1.0;
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    [self setUpView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetWorkChangenotification:) name:@"NetWorkChangenotification" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.pubView dismisView];
}

//
- (void)setSelectPageIndex:(NSInteger)selectPageIndex {
    _selectPageIndex = selectPageIndex;
    self.pubView.selectPageIndex = self.selectPageIndex;
}


-(void)setUpView{
    self.tagDataArray = [NSMutableArray array];
    
    [self.view addSubview:self.pubView];
    
    // 适配
    [self.pubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 选择标签回调
    [self selectTagsArray];
    // 点击选择视频按钮
    [self selectVideo];
    // 去选择封面
    [self toSelectVideoCover];
}

// 选择标签回调
-(void)selectTagsArray{
    WS
    [self.pubView setSelectTagBlock:^(NSMutableArray * _Nonnull selecteArray) {
        SS
        self.selecteDataArray = selecteArray;
        [self pushSelectTagVc];
    }];
}

// 选择视频
-(void)selectVideo{
    WS
    [self.pubView setSelectVideoBlock:^(UIButton * _Nonnull btn) {
        SS
        
        
        [KKPermissionUtils requestPhotoAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                // 加载相册视频
                SelectMediaMoudle * seleMedia = [[SelectMediaMoudle alloc]init];
                seleMedia.mediaType = SelectOnlyVideoType;  // 选择视频传入
                [seleMedia setDidSelectSingleVideoComplete:^{
                    [SVProgressHUD showWithStatus:@"视频预处理中..."];
                }];
                // 选择单个视频回调
                [seleMedia setDidSelectSingleVideo:^(NSString *videoPath) {
                    
                    self.pubView.isSelectVideo = NO;
                    
                    // 创建导出视频目录
                    self.videoPath = [self getVideoOutputPath];
                    
                    // 创建ffmpeg命令
                    NSString * ffmpegZipVide = [NSString stringWithFormat:@"-i %@ -vcodec copy -vb 800000 -r 20 -movflags faststart -acodec  aac -ac 2 -y %@ ",videoPath,self.videoPath];
                    // 执行ffmpeg命令
                    [MobileFFmpeg executeAsync:ffmpegZipVide withCallback:self];

                }];
                [seleMedia showMedia:self];
            }
        }];
    }];
}


// 计算大小
-(NSInteger)getFileSize:(NSString*) path{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ((theFileSize = [attributes objectForKey:NSFileSize])){
            return  [theFileSize intValue]/1024/1024;
        }else{
            return -1;
        }
    }else{
        return -1;
    }
}

- (void)executeCallback:(long)executionId :(int)returnCode {
    if (returnCode == RETURN_CODE_SUCCESS) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"ffmpeg视频大小---%ld",[self getFileSize:self.videoPath]);
            // 加载样式回调
            [SVProgressHUD dismiss];
            self.isSelectVideo = YES;
            self.pubView.isSelectVideo = YES;
            self.pubView.videoPath = self.videoPath;
            self.pubView.selectImage = [self pushSelectVideoVC:self.videoPath];
            self.pubView.firstselectImage = self.pubView.selectImage; // 首帧图片
            self.clipTime = 0;
            self.thumbLocation = 0;
            self.clipSelectImage = [self pushSelectVideoVC:self.videoPath]; // 截取帧图片
        });
        
        NSLog(@"Async command execution completed successfully.\n");
    } else if (returnCode == RETURN_CODE_CANCEL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showMessage:@"退出导出，请重试"];
            self.videoPath = @"";
        });
        NSLog(@"Async command execution cancelled by user.\n");
    } else {
        NSLog(@"Async command execution failed with rc=%d.\n", returnCode);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showMessage:@"导出失败，请重试"];
            self.videoPath = @"";
        });
    }
}


- (NSString *)getVideoOutputPath {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH-mm-ss-SSS"];
    NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/ffmpegVideo-%@-%d.mp4", [formater stringFromDate:[NSDate date]], arc4random_uniform(10000000)];
    return outputPath;
}


// 去选择封面
-(void)toSelectVideoCover{
    WS
    [self.pubView setDidsKeepTitleBlock:^{
        SS
        AlpEditCoverViewController *editCoverVC = [AlpEditCoverViewController new];
        editCoverVC.videoURL = [NSURL fileURLWithPath:self.videoPath];
        editCoverVC.clipTime = self.clipTime;
        editCoverVC.thumbLocation = self.thumbLocation;
        editCoverVC.clipSelectImage = self.clipSelectImage;
        [editCoverVC setReleseButtonBlock:^(UIImage * _Nonnull selectImage, CGFloat time, CGFloat thumbLocation) {
            SS
            // 接收选择的封面
            self.pubView.selectImage = selectImage;
            self.clipTime = time;
            self.clipSelectImage = selectImage;
            self.thumbLocation = thumbLocation;
            [self.pubView.selectVideoBtn setImage:selectImage forState:UIControlStateNormal];
        }];
        [self.navigationController pushViewController:editCoverVC animated:YES];
    }];
}

// 上传成功回调
-(void)uploadSuccess{
    
    [self.pubView dismisView];
    [SVProgressHUD showMessage:@"上传成功"];
}

// 选择标签
-(void)pushSelectTagVc{
    KKPubTagVC *pubTagVc = [[KKPubTagVC alloc] init];
    pubTagVc.selecteDataArray = self.selecteDataArray;
    WS
    [pubTagVc setComBtnActionBlock:^(NSMutableArray * _Nonnull dataArray) {
        SS
        self.pubView.tagDataArray = dataArray;
        self.selecteDataArray = dataArray;
    }];
    [self.navigationController pushViewController:pubTagVc animated:YES];
}

// 根据路径截取视频帧数据
- (UIImage *)pushSelectVideoVC:(NSString *)videoPath {
    NSURL * videoUrl = [NSURL fileURLWithPath:videoPath];
    AVURLAsset * asset = [AVURLAsset assetWithURL:videoUrl];
    CMTime time = [asset duration];
    
    //CMTime time = CMTimeMakeWithSeconds(CMTimeGetSeconds(timee), 600);
    
    UIImage * clicpImage = [AlpVideoSliderTimeClip timeClipVideoImage:CMTimeMake(0.0, time.timescale) videoPath:videoUrl];
    // 如果截取的为空的就往前探测下
    if (clicpImage == nil) {
        return [AlpVideoSliderTimeClip timeClipVideoImage:CMTimeMake(time.value/(time.value / time.timescale), time.timescale) videoPath:videoUrl];;
    }
    return [AlpVideoSliderTimeClip timeClipVideoImage:CMTimeMake(0.0, time.timescale) videoPath:videoUrl];
}

- (NSString *)buildFilePath:(NSString *)videoPath{
    return [NSTemporaryDirectory() stringByAppendingString:[videoPath stringByReplacingOccurrencesOfString:@"/" withString:@""]];
}

#pragma mark -- KKPublishShortVideoViewDelegate
-(void)saveThepublishVideoInfo:(KKUploadInfoModel *)videoInfo{
    // 调用VM层处理视频信息后开始上传
    [self.publishViewModel publishBeginUploadingWithVideoInfo:videoInfo];
}

// 点击取消上传
-(void)clickCancelUpload:(BOOL)isNotiService{
    [self.publishViewModel cancelUpload:isNotiService];
}

#pragma mark -- KKPubLishVideoDataDelegate
-(void)currentUploadProgress:(CGFloat)progress uploadState:(KKUploadState)state isGetProgress:(BOOL)isGetProgress{
    if (isGetProgress == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pubView.currentUploadProgress = progress;
            
            if (state == KKUploadStateUploadComplete) {
                // 开始调用上传成功
                [self uploadSuccess];
            }else if (state == KKUploadStateUploadFailed){
                [self.pubView dismissProgressView];
                [self clickCancelUpload:NO];
                [SVProgressHUD showMessage:@"上传失败,请重试"];
            }else if (state == KKUploadStateUploadForbiddenWords){
                [self.pubView dismissProgressView];
                [self clickCancelUpload:NO];
                [SVProgressHUD showMessage:@"您已被禁言，发布失败"];
            }else if (state == KKUploadStateUploadCancel){
                [self.pubView dismissProgressView];
                [self clickCancelUpload:NO];
                [SVProgressHUD showMessage:@"取消成功"];
            }
        });
    }else{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.pubView dismissProgressView];
//            [self clickCancelUpload];
//            [SVProgressHUD showMessage:@"未知错误"];
//        });
    }
}

// 网络改变上传失败，取消上传
-(void)NetWorkChangenotification:(NSNotification *)nofi{
    
    if ([NetWrokStatesCtrl getInstance].KKNetWorkState == KKNetUnknown || [NetWrokStatesCtrl getInstance].KKNetWorkState== KKNetLose) {
        [self.pubView dismissProgressView];
        [self clickCancelUpload:NO];
    };
}

-(KKPublishShortVideoView *)pubView{
    if (!_pubView) {
        _pubView = [[KKPublishShortVideoView alloc] init];
        _pubView.delegate = self;
    }
    return  _pubView;
}
- (NSMutableArray *)selecteDataArray {
    if (!_selecteDataArray) {
        _selecteDataArray = [NSMutableArray array];
    }
    return _selecteDataArray;
}

// viewmodel初始化
-(KKUploadModel *)publishViewModel{
    if (!_publishViewModel) {
        _publishViewModel = [[KKUploadModel alloc]init];
        _publishViewModel.delegate = self;
    }
    return _publishViewModel;
}

-(void)dealloc{
    NSLog(@"发布页面释放了");
}
@end
