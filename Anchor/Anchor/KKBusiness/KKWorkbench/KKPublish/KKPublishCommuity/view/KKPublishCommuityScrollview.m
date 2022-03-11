//
//  KKPublishCommuityScrollview.m
//  mt
//
//  Created by 小草 on 2021/9/14.
//

#import "KKPublishCommuityScrollview.h"
#import "WAVideoBox.h" // 压缩视频使用
#import "KKPushlishSelectTagView.h" // 选择标签
#import "KKPubCommunityTagController.h"
#import <Photos/Photos.h>
#import <mobileffmpeg/MobileFFmpegConfig.h>
#import "KKPermissionUtils.h"
#import <mobileffmpeg/MobileFFmpeg.h>
@interface KKPublishCommuityScrollview ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,ExecuteDelegate>

@property (nonatomic , strong) WAVideoBox *videoBox; // 压缩处理

@property (nonatomic,strong) KKPushlishSelectTagView * selectTagView; // 选择标签

@property (nonatomic, strong) NSMutableArray *selecteDataArray;

@property (nonatomic,assign)CGFloat scrollViewHeight;

@property (nonatomic,assign)CGFloat keyBordHeight;

@property (nonatomic,assign)BOOL isShowKeyBord;

@property (nonatomic,assign) BOOL isSelectImage;// 是否选择的图片

@property (nonatomic,strong) NSMutableArray *cellArray;

@property (nonatomic,strong) UIView *backView;

@end

@implementation KKPublishCommuityScrollview

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.cellArray = [[NSMutableArray alloc] init];
        self.scrollViewHeight =KK_SCREEN_HEIGHT;
        [self initDataWithAll:YES isImage:YES];
        // 滚动视图
        [self addSubview:self.scrollview];
        // 内容输入框
        [self.scrollview addSubview:self.contentInputView];
        // 选择标识
        [self.scrollview addSubview:self.selectMediaLab];
        // 全部删除
        [self.scrollview addSubview:self.deleteAll];
        // 显示以选择的图片或视频
        [self.scrollview addSubview:self.backView];
        [self.backView addSubview:self.collectionView];
        // 选择标签
        [self.scrollview addSubview:self.selectTagView];
        // 发布按钮
        [self addSubview:self.releaseButton];
        
        // 接收预览页面删除通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bigImageVideDelete:) name:@"bigImageVideDelete" object:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.contentInputView.frame = CGRectMake(15, 27.5, self.frame.size.width - 30, 180);
    
    self.selectMediaLab.frame = CGRectMake(15, CGRectGetMaxY(self.contentInputView.frame)+27.5, 200, 22.5);
    
    self.deleteAll.frame = CGRectMake(self.scrollview.frame.size.width - 15 - 80, CGRectGetMaxY(self.contentInputView.frame)+27.5, 80, 22.5);
    
    CGFloat lineCount = ceilf(self.mediaArray.count/3.0);
    
    self.backView.frame = CGRectMake(15, CGRectGetMaxY(self.selectMediaLab.frame)+15, self.frame.size.width-30, (97.5*lineCount)+20); // 20为横向间距的总和
    
    self.collectionView.frame = CGRectMake(0, 0, self.backView.frame.size.width, self.backView.frame.size.height); // 20为横向间距的总和
    
    self.selectTagView.frame = CGRectMake(15, CGRectGetMaxY(self.backView.frame)+15, self.frame.size.width-30, 100);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(keyboardWasShown:)
                name:UIKeyboardDidShowNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(keyboardWasHidden:)
                name:UIKeyboardDidHideNotification object:nil];
    
}

// 键盘收起通知
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    _isShowKeyBord = YES;
    NSDictionary* info = [aNotification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    self.keyBordHeight = keyboardSize.height;
    if (self.mediaArray.count >3) {
        
        _scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH, self.scrollViewHeight-keyboardSize.height);
    
    }else{
        _scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT-keyboardSize.height);
        
    }
}

// 预览页面删除刷新通知
-(void)bigImageVideDelete:(NSNotification *)nofi{
    if (nofi.object) {
        NSInteger deleteIndex = [nofi.object integerValue];
        self.mediaCount -= 1;
        [self checkIsMediaModelWithImage:YES indexPath:[NSIndexPath indexPathForRow:deleteIndex inSection:0]];
    }
}

- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    _isShowKeyBord = NO;
    if (self.mediaArray.count >3) {
        _scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH, self.scrollViewHeight);
    }else{
        
        _scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT);
    }

}

/// 是否需要两种类型
/// @param isAll 如果为YES，显示选择图片和视频两种
/// @param isImage 如果isAll为no 判断isImage为YES,只要图片
-(void)initDataWithAll:(BOOL)isAll isImage:(BOOL)isImage{
    
    if (isAll == YES) { // isAll 如果为YES，显示选择图片和视频两种
        self.selectImageModel = [[KKPublishSelectModel alloc]init];
        self.selectImageModel.selectType = KKPublishSelectModelSelectImageMidiaType;
        [self.mediaArray addObject:self.selectImageModel];
        
        self.selectVideoModel = [[KKPublishSelectModel alloc]init];
        self.selectVideoModel.selectType = KKPublishSelectModelSelectVideoMidiaType;
        [self.mediaArray addObject:self.selectVideoModel];
    }else{
        if (isImage == YES) { // 如果isAll为no 判断isImage为YES,只要图片
            self.selectImageModel = [[KKPublishSelectModel alloc]init];
            self.selectImageModel.selectType = KKPublishSelectModelSelectImageMidiaType;
            self.selectImageModel.imageIndex = self.mediaArray.count;
            [self.mediaArray addObject:self.selectImageModel];
        }else{
            self.selectVideoModel = [[KKPublishSelectModel alloc]init];
            self.selectVideoModel.selectType = KKPublishSelectModelSelectVideoMidiaType;
            self.selectImageModel.imageIndex = 1;
            [self.mediaArray addObject:self.selectVideoModel];
        }
    }
}

// 刷新控件
-(void)reloadView{
    [self.cellArray removeAllObjects];
    [self.collectionView reloadData];
    if (self.mediaArray.count >6 ){
        
        self.scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH,_isShowKeyBord? KK_SCREEN_HEIGHT +97*2-self.keyBordHeight:KK_SCREEN_HEIGHT +97*2);
        self.scrollViewHeight = KK_SCREEN_HEIGHT +97*2;
        
        
    }else if(self.mediaArray.count >3&&self.mediaArray.count <6){
        
        self.scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH,_isShowKeyBord ?KK_SCREEN_HEIGHT +97-self.keyBordHeight : KK_SCREEN_HEIGHT +97);
        self.scrollViewHeight = KK_SCREEN_HEIGHT +97;
        
        
    }else{
        self.scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH,_isShowKeyBord? KK_SCREEN_HEIGHT-self.keyBordHeight:KK_SCREEN_HEIGHT);
        self.scrollViewHeight = KK_SCREEN_HEIGHT;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (KKPublishSelectModel *model in self.mediaArray) {
        if (model.selectType ==KKPublishSelectModelMediaImageType||model.selectType ==KKPublishSelectModelMediaVideoType) {
            [arr addObject:model];
        }
    }
    if (arr.count >0) {
        [_deleteAll setTitleColor: [KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
    }else{
        [_deleteAll setTitleColor: [KKColor getColor:appHintTextColor] forState:UIControlStateNormal];
    }
    [self layoutSubviews];
}

/// 检查本地数组中是否有选择视频或图片的model
/// @param isImage YES 为从操作的图片，NO 为操作的视频
-(void)checkIsMediaModelWithImage:(BOOL)isImage indexPath:(NSIndexPath *)indexPath{
    if (isImage == YES) {
        if (self.mediaArray.count >0) {
            [self.mediaArray removeObjectAtIndex:indexPath.row];
            if (![self.mediaArray containsObject:self.selectImageModel]) {
                [self.mediaArray addObject:self.selectImageModel];
            }
            // 如果数组等于1并且不包含选择视频model就加入
            if (self.mediaArray.count == 1 && ![self.mediaArray containsObject:self.selectVideoModel]) {
                [self.mediaArray addObject:self.selectVideoModel];
            }
            [self reloadView];
        }
    }else{
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KKPublishSelectModel * model = self.mediaArray[indexPath.row];
    // 资源类型
    if (model.selectType == KKPublishSelectModelMediaImageType || model.selectType == KKPublishSelectModelMediaVideoType) {
        // 显示资源
        KKPushMidiaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKPushMidiaCollectionViewCellID" forIndexPath:indexPath];
        cell.model = model;
        
        [self.cellArray addObject:cell];
        
        // 点击删除图片回调
        WS
        [cell setDeleteImageBlock:^{
          SS
            self.mediaCount -= 1;
            [self checkIsMediaModelWithImage:YES indexPath:indexPath];
        }];
        
        return cell;
    }else{
        KKPushSelectMediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKPushSelectMediaCellID" forIndexPath:indexPath];
        cell.mediaCount = self.mediaCount;
        cell.model = model;
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mediaArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KK_SCREEN_WIDTH-50)/3, 97);
}


// 点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKPublishSelectModel * model = self.mediaArray[indexPath.row];
    if (model.selectType == KKPublishSelectModelSelectImageMidiaType) {
        // 选择图片控件
        [self selectImage];
    }else if (model.selectType == KKPublishSelectModelSelectVideoMidiaType){
        // 选择视频控件
        [self selectVideo];
    }else{
        // 查看二级资源
        SelectMediaMoudle * showBigImageMoudle = [[SelectMediaMoudle alloc]init];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.mediaArray.count; i++) {
            KKPublishSelectModel * imageModel = self.mediaArray[i];
            if (imageModel.selectType == KKPublishSelectModelMediaImageType) {
                [arr addObject:imageModel.image];
            }
        }
        [showBigImageMoudle showLocalPhotoArray:arr selectIndex:indexPath.row superView:self.backView imageViewArr:self.cellArray isPublish:YES];
    }
    
}
 

// 点击选择图片时调用
-(void)selectImage{
    
    [KKPermissionUtils requestPhotoAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            SelectMediaMoudle * select = [[SelectMediaMoudle alloc]init];
            select.mediaType = SelectMoreImageType;
            select.ImageNumMax = 9 - self.mediaCount; // 最大选择图片的个数
            [select showMedia:[select getCurrentVC]];
            WS
            // 选择图片回调
            [select setDidSelectMoreImages:^(NSArray *images, NSArray *aeests) {
              SS
                // 如果包含选择视频或图片的空间，就删除
                if ([self.mediaArray containsObject:self.selectImageModel]) {
                    [self.mediaArray removeObject:self.selectImageModel];
                }if ([self.mediaArray containsObject:self.selectVideoModel]) {
                    [self.mediaArray removeObject:self.selectVideoModel];
                }
                // 将图片数据加入
                if (images.count>0) {
                    for (int i = 0; i<images.count; i++) {
                        UIImage * selectImage = images[i];
                        KKPublishSelectModel * selectImageModel = [[KKPublishSelectModel alloc]init];
                        selectImageModel.selectType = KKPublishSelectModelMediaImageType;
                        selectImageModel.image = selectImage;
                        [self.mediaArray addObject:selectImageModel];
                    }
                }
        
                // 记录媒体资源，不能放上面，以数组个数为准
                self.mediaCount = self.mediaArray.count;
        
                // 如果是九张图片则不显示选择图片
                if (self.mediaArray.count<9) {
                    [self initDataWithAll:NO isImage:YES];
                }
                self.isSelectImage = YES;
                // 刷新
                //[self.collectionView reloadData];
                [self reloadView];
            }];
        }
    }];
}

// 点击选择视频时调用
-(void)selectVideo{
    [KKPermissionUtils requestPhotoAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            SelectMediaMoudle * select = [[SelectMediaMoudle alloc]init];
            select.mediaType = SelectOnlyVideoType;
            [select showMedia:[select getCurrentVC]];
            WS
            [select setDidSelectSingleVideo:^(NSString *videoPath) {
              SS
                // 指定导出视频地址
                NSString * exportVideoPath = [self buildFilePath:videoPath];
                // 创建导出视频目录
                self.videoPath = [self getVideoOutputPath];
                
                // 创建ffmpeg命令
                NSString * ffmpegZipVide = [NSString stringWithFormat:@"-i %@ -vcodec copy -vb 800000 -r 20 -movflags faststart -acodec  aac -ac 2 -y %@ ",videoPath,self.videoPath];
                // 执行ffmpeg命令
                [MobileFFmpeg executeAsync:ffmpegZipVide withCallback:self];
                
                // 异步处理视频
                [self.videoBox asyncFinishEditByFilePath:exportVideoPath complete:^(NSError *error) {
                    if (!error) {
                        self.isSelectImage = NO;
                        // 加载样式回调
                        [SVProgressHUD dismiss];
                        self.videoPath = exportVideoPath;
                        // 重置
                        self.videoBox.ratio = WAVideoExportRatio960x540;
                        self.videoBox.videoQuality = 0;
                        
                        [self.mediaArray removeAllObjects];
                        // 把数组之前的清空
                        KKPublishSelectModel * selectVideoModel = [[KKPublishSelectModel alloc]init];
                        selectVideoModel.selectType = KKPublishSelectModelMediaVideoType;
                        selectVideoModel.videoPath = exportVideoPath;
                        selectVideoModel.videoImage = [self pushSelectVideoVC:exportVideoPath];
                        [self.mediaArray addObject:selectVideoModel];
                        // 媒体个数
                        self.mediaCount = self.mediaArray.count;
                        [self reloadView];
                    }
                }];
            }];
            
            [select setDidSelectSingleVideoComplete:^{
                [SVProgressHUD showWithStatus:@"视频预处理中..."];
            }];
        }
    }];
}

- (void)executeCallback:(long)executionId :(int)returnCode {
    if (returnCode == RETURN_CODE_SUCCESS) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 加载样式回调
            // 加载样式回调
            [SVProgressHUD dismiss];
            // 重置
            self.videoBox.ratio = WAVideoExportRatio960x540;
            self.videoBox.videoQuality = 0;
            
            [self.mediaArray removeAllObjects];
            // 把数组之前的清空
            KKPublishSelectModel * selectVideoModel = [[KKPublishSelectModel alloc]init];
            selectVideoModel.selectType = KKPublishSelectModelMediaVideoType;
            selectVideoModel.videoPath = self.videoPath;
            selectVideoModel.videoImage = [self pushSelectVideoVC:self.videoPath];
            [self.mediaArray addObject:selectVideoModel];
            // 媒体个数
            self.mediaCount = self.mediaArray.count;
            // 刷新
            //[self.collectionView reloadData];
            [self reloadView];
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

-(void)deletaClick{
    [self.mediaArray removeAllObjects];
    self.mediaCount = 0;
    [self initDataWithAll:YES isImage:NO];
    //[self.collectionView reloadData];
    [self reloadView];
}

// 选择发布按钮
-(void)didsReleseButton{
    if ([self.contentInputView.text length] ==0) {
        [SVProgressHUD showMessage:@"请输入文本内容"];
        return;
    }
    if ([KKTool isStringAllSpace:self.contentInputView.text] == YES) {
        [SVProgressHUD showMessage:@"请输入文本内容"];
        return;
    }
    
    if (self.tagsArr.count==0) {
        [SVProgressHUD showMessage:@"请选择标签"];
        return;
    }
    
    // 准备上传信息
    KKUploadInfoModel * uploadInfo = [[KKUploadInfoModel alloc]init];
    uploadInfo.isImage = self.isSelectImage;
    if (uploadInfo.isImage == YES) {
        for (int i = 0; i<self.mediaArray.count; i++) {
            // 取出所有图片资源
            KKPublishSelectModel * imageModel = self.mediaArray[i];
            if (imageModel.selectType == KKPublishSelectModelMediaImageType) {
                // 阿里云model
                UploadOSSDataModel * ossDataModel = [[UploadOSSDataModel alloc]init];
                ossDataModel.image = imageModel.image;
                ossDataModel.isImage = YES;
                ossDataModel.objectName = [NSString stringWithFormat:@"/iOS_commuity_Image_%@_%d.jpg",[NSString getNowTimeTimestampMillisecond],i];
                // 文件长度
                NSData * imageData = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(imageModel.image, videoCoverZip)];
                ossDataModel.videoSize = [imageData length];
                [uploadInfo.soucreArray addObject:ossDataModel];
                
                
                // 缩略图
                UploadOSSDataModel * ossThumbDataModel = [[UploadOSSDataModel alloc]init];
                ossThumbDataModel.image = imageModel.image;
                ossThumbDataModel.isImage = YES;
                ossThumbDataModel.isThumbImage = YES;
                ossThumbDataModel.objectName = [NSString stringWithFormat:@"/iOS_commuity_ThumbnailImage_%@_%d.jpg",[NSString getNowTimeTimestampMillisecond],i];
                // 文件长度
                NSData * thumbImageData = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(imageModel.image, thumbnailCoverZip)];
                ossThumbDataModel.videoSize = [thumbImageData length];
                [uploadInfo.soucreArray addObject:ossThumbDataModel];
            }
        }
    }else{
        for (int i = 0; i<self.mediaArray.count; i++) {
            // 取出所有视频资源
            KKPublishSelectModel * imageModel = self.mediaArray[i];
            if (imageModel.selectType == KKPublishSelectModelMediaVideoType) {
                
                if (imageModel.videoImage) {
                    UploadOSSDataModel * ossVideoImageDataModel = [[UploadOSSDataModel alloc]init];
                    ossVideoImageDataModel.image = imageModel.videoImage;
                    ossVideoImageDataModel.objectName = [NSString stringWithFormat:@"/iOS_commuity_VideoCover_%@_%d.jpg",[NSString getNowTimeTimestampMillisecond],i];
                    uploadInfo.videoOrCoverWidthHeight = [NSString stringWithFormat:@"%.0f:%.0f",imageModel.videoImage.size.width,imageModel.videoImage.size.height];
                    ossVideoImageDataModel.isImage = YES;
                    // 文件长度
                    NSData * imageData = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(imageModel.videoImage, videoCoverZip)];
                    ossVideoImageDataModel.videoSize = [imageData length];
                    [uploadInfo.soucreArray addObject:ossVideoImageDataModel];
                }
                
                // 阿里云model
                UploadOSSDataModel * ossDataModel = [[UploadOSSDataModel alloc]init];
                ossDataModel.videoFilePath = imageModel.videoPath;
                ossDataModel.isImage = NO;
                ossDataModel.objectName = [NSString stringWithFormat:@"/iOS_commuity_Video_%@_%d.mp4",[NSString getNowTimeTimestampMillisecond],i];
                ossDataModel.videoSize = [NSData dataWithContentsOfFile:imageModel.videoPath].length;
                [uploadInfo.soucreArray addObject:ossDataModel];
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(saveThepublishVideoInfo:)]) {
        [self.delegate saveThepublishVideoInfo:uploadInfo];
    }
}

- (NSString *)buildFilePath:(NSString *)videoPath{
    return [NSTemporaryDirectory() stringByAppendingString:[videoPath stringByReplacingOccurrencesOfString:@"/" withString:@""]];
}

// 懒加载
-(UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]init];
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.delegate = self;
        _scrollview.contentSize = CGSizeMake(KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT);
    }
    return _scrollview;
}

-(UITextView *)contentInputView{
    if (!_contentInputView) {
        _contentInputView = [[UITextView alloc]init];
        _contentInputView.delegate = self;
        _contentInputView.placeholder = @"请输入正文";
        _contentInputView.placeholderColor = [KKColor getColor:appHintTextColor];
        [_contentInputView setFont:[UIFont mediumWithSize:14]];
        _contentInputView.textColor =  [KKColor getColor:appMainTextColor];
        _contentInputView.backgroundColor = [KKColor getColor:appMainCardBgColor];
        _contentInputView.layer.cornerRadius = 6;
        _contentInputView.layer.masksToBounds = YES;
    }
    return _contentInputView;
}

-(UILabel *)selectMediaLab{
    if (!_selectMediaLab) {
        _selectMediaLab = [[UILabel alloc]init];
        _selectMediaLab.text = @"选择图片或视频";
        _selectMediaLab.textColor =  [KKColor getColor:appMainTextColor];
        _selectMediaLab.font = [UIFont mediumWithSize:16];
        _selectMediaLab.textAlignment = NSTextAlignmentLeft;
    }
    return _selectMediaLab;
}

-(UIButton *)deleteAll{
    if (!_deleteAll) {
        _deleteAll = [[UIButton alloc]init];
        _deleteAll.titleLabel.font = [UIFont mediumWithSize:15];
        [_deleteAll setTitle:@"全部删除" forState:UIControlStateNormal];
        [_deleteAll setTitleColor: [KKColor getColor:appHintTextColor] forState:UIControlStateNormal];
        [_deleteAll addTarget:self action:@selector(deletaClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteAll;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[KKPushMidiaCollectionViewCell class] forCellWithReuseIdentifier:@"KKPushMidiaCollectionViewCellID"];
        [_collectionView registerClass:[KKPushSelectMediaCell class] forCellWithReuseIdentifier:@"KKPushSelectMediaCellID"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
       
    }
    return _collectionView;
}

- (NSMutableArray *)selecteDataArray {
    if (!_selecteDataArray) {
        _selecteDataArray = [NSMutableArray array];
    }
    return _selecteDataArray;
}

// 选择标签视图
-(KKPushlishSelectTagView *)selectTagView{
    if (!_selectTagView) {
        _selectTagView = [[KKPushlishSelectTagView alloc]init];
        WS
        [_selectTagView setSelectTagBlock:^(NSMutableArray * _Nonnull selecteArray) {
            SS
            self.selecteDataArray = selecteArray;
            KKPubCommunityTagController *pubTagVc = [[KKPubCommunityTagController alloc] init];
            pubTagVc.selecteDataArray = self.selecteDataArray;
            WS
            [pubTagVc setComBtnActionBlock:^(NSMutableArray * _Nonnull dataArray) {
                SS
                self.selectTagView.tagDataArray = dataArray;
                self.selecteDataArray = dataArray;
                [self.tagsArr removeAllObjects];
                for (KKPubTagVCDataModel *model in dataArray) {
                    appvapiIdEncode *item = [[appvapiIdEncode  alloc]init];
                    item.id_p = model.id_p;
//                    item.tagName = model.tagModel.tagName;
                    [self.tagsArr addObject:item];
                }
            }];
            [[KKTool getCurrentVC].navigationController pushViewController:pubTagVc animated:YES];
        }];
        
        [_selectTagView setCancleselectTagBlock:^(KKPubTagVCDataModel * _Nonnull tagVCDataModel) {
            SS
            for (appvapiIdEncode *item in self.tagsArr) {
                if ([item.id_p isEqualToString:tagVCDataModel.id_p]) {
                    [self.tagsArr removeObject:item];
                    break;
                }
            }
        }];
    }
    return _selectTagView;;
}

// 发布按钮
- (UIButton *)releaseButton {
    if (!_releaseButton) {
        _releaseButton = [[UIButton alloc] init];
        self.releaseButton.frame = CGRectMake(30, self.frame.size.height - 45 - 15 - KK_BOTTOM_SECURITY_HEIGHT - KK_NAV_BAR_HEIGHT, self.frame.size.width-30-30, 45);
        [KKGeneralGradientColor KK_createByCAGradientLayer:KK_GRDIENT_THEMECOLOR direction:GradientTypeLeftToRight layerView:self.releaseButton isConstraint:YES];
        [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
        _releaseButton.backgroundColor = [UIColor clearColor];
        [_releaseButton setTitleColor:[KKColor getColor:colorMainBtnText] forState:UIControlStateNormal];
        _releaseButton.titleLabel.font = [UIFont mediumWithSize:16];
        _releaseButton.layer.cornerRadius = 23;
        _releaseButton.layer.masksToBounds = YES;
        [_releaseButton addTarget:self action:@selector(didsReleseButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseButton;
}

-(NSMutableArray *)mediaArray{
    if (!_mediaArray) {
        _mediaArray = [[NSMutableArray alloc]init];
    }
    return _mediaArray;
}
-(NSMutableArray *)tagsArr{
    if (!_tagsArr) {
        _tagsArr = [NSMutableArray array];
    }
    return _tagsArr;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}

@end
