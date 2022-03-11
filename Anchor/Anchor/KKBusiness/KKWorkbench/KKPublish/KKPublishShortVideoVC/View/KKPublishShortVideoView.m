//
//  KKPublishView.m
//  KK
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKPublishShortVideoView.h"
#import "NSString+Extension.h"
#import "KKPublishShortVideoCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "UITextView+Placeholder.h"
#import "KKPublishShortSelectVideoAlertView.h"
#import "KKPubTagVCModel.h"
#import "KKPublicUploadSuccessModel.h"
#import "AlpVideoSliderTimeClip.h"
#import "UIImage+Extension.h"

// 登录管理
@interface KKPublishShortVideoView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *keepView;
@property (nonatomic, strong) UILabel *keepTitle;
@property (nonatomic, strong) UIView *releaseButtonBgView;
@property (nonatomic, strong) UIButton *releaseButton;
@property (nonatomic, assign) BOOL isReaload;
@property (nonatomic, strong)KKPublishShortSelectVideoAlertView *videoAlertView;
@property (nonatomic, strong) NSString * ossCoverfileName;
@property (nonatomic, strong) NSString * ossVideofileName;

@end

@implementation KKPublishShortVideoView{
    UILabel *_selctVideoLabel;
    UILabel *_tipsTextLabel;
    UILabel *_lineLabe;
    UILabel *_textViewHeadrLabel;
    UITextView *_textView;
    UILabel *_addTagLabel;
    UILabel *_addTagTipsLabel;
    UIButton *_selectTagBtn;
    UIButton *_pubBtn;
    UIImageView *_phoImageV;
    UILabel *_phoLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    [self addSubview:self.shortBackGroundView];
    _selctVideoLabel = [[UILabel alloc]init];
    [_selctVideoLabel setText:@"选择视频"];
    [_selctVideoLabel setFont:[UIFont mediumWithSize:15]];
    [_selctVideoLabel setTextColor: [KKColor getColor:appMainTextColor]];
    [self.shortBackGroundView addSubview:_selctVideoLabel];
    
    _tipsTextLabel = [[UILabel alloc]init];
    [_tipsTextLabel setText:@"(视频大小不能超过100M)"];
    [_tipsTextLabel setFont:[UIFont mediumWithSize:14]];
    [_tipsTextLabel setTextColor:[KKColor getColor:appHintTextColor]];
    
    [self.shortBackGroundView addSubview:_tipsTextLabel];
    
    _selectVideoBtn = [[UIButton alloc]init];
    [_selectVideoBtn setBackgroundColor:[KKColor getColor:appMainCardBgColor]];
    [_selectVideoBtn.layer setCornerRadius:8];
    [_selectVideoBtn.layer setMasksToBounds:YES];
    [_selectVideoBtn addTarget:self action:@selector(selectVideoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectVideoBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.shortBackGroundView addSubview:_selectVideoBtn];
    
    UIImage *img=[UIImage imageNamed:@"videoCameraWithPlayButton"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _phoImageV = [[UIImageView alloc] init];
    _phoImageV.image =img;
    [_phoImageV setTintColor:[KKColor getColor:appHintTextColor]];
    [_selectVideoBtn addSubview:_phoImageV];
    
    _phoLabel = [[UILabel alloc]init];
    [_phoLabel setText:@"上传视频"];
    [_phoLabel setTextAlignment:NSTextAlignmentCenter];
    [_phoLabel setFont:[UIFont mediumWithSize:14]];
    [_phoLabel setTextColor:[KKColor getColor:appHintTextColor]];
    [_selectVideoBtn addSubview:_phoLabel];
    
    _lineLabe = [[UILabel alloc] init];
    [_lineLabe setBackgroundColor:KKRGBA(255, 255, 255, 0.2)];
    [self.shortBackGroundView addSubview:_lineLabe];
    
    _textViewHeadrLabel = [[UILabel alloc]init];
    [_textViewHeadrLabel setText:@"填写标题"];
    [_textViewHeadrLabel setFont:[UIFont mediumWithSize:14]];
    [_textViewHeadrLabel setTextColor: [KKColor getColor:appMainTextColor]];
    [self.shortBackGroundView addSubview:_textViewHeadrLabel];
    
    _textView = [[UITextView alloc]init];
    [_textView setFont:[UIFont mediumWithSize:14]];
    _textView.placeholder = @"请输入合适的标题";
    _textView.placeholderColor = [KKColor getColor:appHintTextColor];
    _textView.textColor = [KKColor getColor:appMainTextColor];
    _textView.backgroundColor = KK_RELES_PAGE_THEMECOLOR;
    [self addSubview:_textView];
    
    _addTagLabel = [[UILabel alloc]init];
    [_addTagLabel setText:@"添加标签"];
    [_addTagLabel setFont:[UIFont mediumWithSize:15]];
    [_addTagLabel setTextColor: [KKColor getColor:appMainTextColor]];
    [self.shortBackGroundView addSubview:_addTagLabel];
    
    
    _addTagTipsLabel = [[UILabel alloc]init];
    [_addTagTipsLabel setText:@"(最多5个)"];
    [_addTagTipsLabel setFont:[UIFont mediumWithSize:14]];
    [_addTagTipsLabel setTextColor:[KKColor getColor:appHintTextColor]];
    [self.shortBackGroundView addSubview:_addTagTipsLabel];
    
    _selectTagBtn = [[UIButton alloc]init];
    [_selectTagBtn setBackgroundColor:[KKColor getColor:colorSecondBtnBg]];
    [_selectTagBtn setTitle:@"选择标签" forState:UIControlStateNormal];
    [_selectTagBtn.titleLabel setFont:[UIFont mediumWithSize:13]];
    [_selectTagBtn setTitleColor: [KKColor getColor:colorSecondBtnText] forState:UIControlStateNormal];
    [_selectTagBtn.layer setCornerRadius:15];
    [_selectTagBtn.layer setMasksToBounds:YES];
    [_selectTagBtn addTarget:self action:@selector(selectTagBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shortBackGroundView addSubview:_selectTagBtn];
    
    
    // 先添加标签，后添加发布
    [self.shortBackGroundView addSubview:self.collectionView];
    
    [self.shortBackGroundView addSubview:self.releaseButtonBgView];
    [self.releaseButtonBgView addSubview:self.releaseButton];
    
    [_selectVideoBtn addSubview:self.keepView];
    [self.keepView addSubview:self.keepTitle];
}
-(void)layoutSubviews{
    if (self.isReaload) {
        return;
    }
    [self.shortBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(0);
        make.right.mas_equalTo(self).offset(0);
        make.top.mas_equalTo(self).offset(44);
        make.bottom.mas_equalTo(self).offset(0);
    }];
    [_selctVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shortBackGroundView).offset(15);
        make.top.mas_equalTo(self.shortBackGroundView).offset(30);
        make.width.mas_equalTo(@61);
    }];
    [_tipsTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_selctVideoLabel.mas_right).offset(9);
        make.top.bottom.mas_equalTo(_selctVideoLabel);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    [_selectVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_selctVideoLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(@138);
        make.height.mas_equalTo(@184);
    }];
    
    [_phoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_selectVideoBtn);
        make.top.mas_equalTo(_selectVideoBtn).offset(66.5);
        make.width.mas_equalTo(@39.5);
        make.height.mas_equalTo(@23.5);
    }];
    [_phoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoImageV.mas_bottom).offset(14);
        make.left.right.mas_equalTo(_selectVideoBtn);
        make.height.mas_equalTo(@20);
    }];
    [_lineLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_selectVideoBtn.mas_bottom).offset(21);
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(@0.5);
    }];
    [_textViewHeadrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineLabe.mas_bottom).offset(15);
        make.left.width.height.equalTo(_selctVideoLabel);
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textViewHeadrLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(self.shortBackGroundView).offset(10);
        make.right.equalTo(self.shortBackGroundView.mas_right).offset(-15);
        make.height.equalTo(@70);
    }];
    [_addTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.mas_bottom).offset(10);
        make.height.left.right.equalTo(_selctVideoLabel);
    }];
    [_addTagTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_tipsTextLabel);
        make.top.bottom.equalTo(_addTagLabel);
    }];
    [_selectTagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addTagLabel);
        make.right.equalTo(self).offset(-15);
        make.width.equalTo(@86);
        make.height.equalTo(@30);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectTagBtn.mas_bottom).offset(20);
        make.left.equalTo(self.shortBackGroundView);
        make.right.equalTo(self);
        make.height.equalTo(@80);
    }];
    [self.releaseButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(45);
        //make.top.equalTo(self.collectionView.mas_bottom).offset(15);
        make.bottom.equalTo(self).inset((15+KK_BOTTOM_SECURITY_HEIGHT));
    }];
    [self.releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.releaseButtonBgView).offset(-15);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(self).inset((15+KK_BOTTOM_SECURITY_HEIGHT));
        //make.top.equalTo(self.collectionView.mas_bottom).offset(15);
    }];
    [self.keepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_selectVideoBtn);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(35.5);
    }];
    [self.keepTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_selectVideoBtn);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(35.5);
    }];
    [_releaseButtonBgView.superview setNeedsLayout];
    [_releaseButtonBgView.superview layoutIfNeeded];
    self.shortBackGroundView.contentSize = CGSizeMake(0, _releaseButtonBgView.frame.origin.y + 45 + 35);
    [KKGeneralGradientColor KK_createByCAGradientLayer:KK_GRDIENT_THEMECOLOR direction:GradientTypeLeftToRight layerView:self.releaseButton isConstraint:YES];
    self.isReaload = YES;
}
- (void)setIsSelectVideo:(BOOL)isSelectVideo {
    _isSelectVideo = isSelectVideo;
    if (isSelectVideo) {
        self.keepTitle.hidden = NO;
        self.keepView.hidden = NO;
        _phoImageV.hidden = YES;
        _phoLabel.hidden = YES;
    }else{
        self.keepTitle.hidden = YES;
        self.keepView.hidden = YES;
        _phoImageV.hidden = NO;
        _phoLabel.hidden = NO;
        [self.selectVideoBtn setBackgroundColor:[KKColor getColor:appMainCardBgColor]];
        [self.selectVideoBtn setImage:nil forState:UIControlStateNormal];
    }
}
- (void)setSelectImage:(UIImage *)selectImage {
    _selectImage = selectImage;
    [self.selectVideoBtn setImage:selectImage forState:UIControlStateNormal];
    
    if (selectImage.size.width>selectImage.size.height||selectImage.size.width==selectImage.size.height) {
        [self.selectVideoBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
    }else{
        [self.selectVideoBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
}
- (void)setVideoPath:(NSString *)videoPath {
    _videoPath = videoPath;
    
}

-(void)dismissProgressView{
    [self.videoAlertView dissmisView];
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //        _collectionView.scrollEnabled = false;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        [_collectionView registerClass:[KKPublishShortVideoCell class] forCellWithReuseIdentifier:@"KKSHortTagCellID"];
    }
    return _collectionView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endEditing:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tagDataArray.count > 0 && indexPath.row <= self.tagDataArray.count - 1) {
        [self.tagDataArray removeObjectAtIndex:indexPath.row];
        [collectionView reloadData];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKPublishShortVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKSHortTagCellID" forIndexPath:indexPath];
    KKPubTagVCDataModel *selectDataModel = self.tagDataArray[indexPath.row];
    cell.titleLabel.text =[NSString stringWithFormat:@"#%@",selectDataModel.title];
    [cell.titleLabel setTextColor:[KKColor getColor:colorPrimary]];
    cell.titleLabel.backgroundColor = KK_RELES_PAGE_THEMECOLOR;
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagDataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 5, 15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //return CGSizeMake((KSCREEN_WIDTH-70)/4, 106);
    KKPubTagVCDataModel *selectDataModel = self.tagDataArray[indexPath.row];
    NSString *text = selectDataModel.title;
    CGFloat width = [text singleLineSizeWithText:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]].width;
    return CGSizeMake(width + 30, 32);
}
-(void)setTagDataArray:(NSMutableArray *)tagDataArray{
    _tagDataArray = tagDataArray;
   
    [_collectionView reloadData];
    
    
    [_collectionView.superview setNeedsLayout];
    [_collectionView.superview layoutIfNeeded];
    self.shortBackGroundView.contentSize = CGSizeMake(0, CGRectGetMaxY(_collectionView.frame) + 45 + 35);
    
}
-(void)selectVideoBtnAction:(UIButton *)btnAction{
    if (self.selectVideoBlock) {
        self.selectVideoBlock(btnAction);
    }
    
}
-(void)selectTagBtnAction{
    if (self.selectTagBlock) {
        self.selectTagBlock(self.tagDataArray);
    }
}
-(void)pubBtnAction{
    
}
- (void)didsKeepTitle {
    if (self.didsKeepTitleBlock) {
        self.didsKeepTitleBlock();
    }
}
- (void)didsReleseButton:(UIButton *)releseButton{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    NSInteger videoSize = [self getFileSize:self.videoPath];
    

    if (kStringIsEmpty(self.videoPath)) {
        [SVProgressHUD showMessage:@"请选择视频"];
        return;
    }if (videoSize > 100) {
        [SVProgressHUD showMessage:@"视频不能大于100M"];
        return;
    }if (kStringIsEmpty(_textView.text)) {
        [SVProgressHUD showMessage:@"请输入标题"];
        return;
    }if ([KKTool isStringAllSpace:_textView.text] == YES) { // 全是空格也不允许发布
        [SVProgressHUD showMessage:@"请输入标题"];
        return;
    }
    if ([[NetWrokStatesCtrl getInstance] isRealyNetAvailable] == NO) {
        [SVProgressHUD showMessage:@"网络连接失败，请检查网络后重试"];
        return;
    }
    if (self.tagDataArray.count==0) {
        [SVProgressHUD showMessage:@"请选择标签"];
        return;
    }
    
    // 准备上传信息
    KKUploadInfoModel * uploadInfo = [[KKUploadInfoModel alloc]init];
    // 初始化资源model
    uploadInfo.soucreArray = [[NSMutableArray alloc]init];
    uploadInfo.userTitle = _textView.text;
    uploadInfo.tags = self.tagDataArray;
    
    // 首帧图片model
    UploadOSSDataModel * firstImageModel = [[UploadOSSDataModel alloc]init];
    firstImageModel.image = self.firstselectImage;
    firstImageModel.objectName = [NSString stringWithFormat:@"/iOS_firstImage_%@.jpg",[NSString getNowTimeTimestamp]];
    firstImageModel.isImage = YES;
    firstImageModel.isFirstImage = YES;
    firstImageModel.videoOrCoverWidthHeight = [NSString stringWithFormat:@"%.0f:%.0f",self.firstselectImage.size.width,self.firstselectImage.size.height];
    // 文件长度
    NSData * firstImageData = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(self.firstselectImage, thumbnailCoverZip)];
    firstImageModel.videoSize = [firstImageData length];
    [uploadInfo.soucreArray addObject:firstImageModel];
    
    UploadOSSDataModel * coverImageModel = [[UploadOSSDataModel alloc]init];
    coverImageModel.image = self.selectImage;
    coverImageModel.objectName = [NSString stringWithFormat:@"/iOS_videoCover_image_%@.jpg",[NSString getNowTimeTimestamp]];
    coverImageModel.videoOrCoverWidthHeight = [NSString stringWithFormat:@"%.0f:%.0f",self.selectImage.size.width,self.selectImage.size.height];
    coverImageModel.isImage = YES;
    coverImageModel.isFirstImage = NO;
    // 文件长度
    NSData * videoCoverData = [richers encodeMedia:EncodeType_Image src:UIImageJPEGRepresentation(self.selectImage, thumbnailCoverZip)];
    coverImageModel.videoSize = [videoCoverData length];
    [uploadInfo.soucreArray addObject:coverImageModel];
    
    UploadOSSDataModel * videoModel = [[UploadOSSDataModel alloc]init];
    videoModel.videoFilePath = self.videoPath;
    videoModel.objectName = [NSString stringWithFormat:@"/iOS_video_%@",[self.videoPath stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    videoModel.isImage = NO;
    videoModel.videoOrCoverWidthHeight = coverImageModel.videoOrCoverWidthHeight;
    videoModel.videoSize = [NSData dataWithContentsOfFile:self.videoPath].length;
    [uploadInfo.soucreArray addObject:videoModel];
    
    
    
    
//    uploadInfo.imageName = [NSString stringWithFormat:@"iOS-videoCover-image-%@.jpg",[NSString getNowTimeTimestamp]];
//    uploadInfo.imageData = [self.selectImage compressWithMaxLength:20480];//压缩到20KB左右
//    
//    uploadInfo.firstImageName = [NSString stringWithFormat:@"iOS-firstImage-%@.jpg",[NSString getNowTimeTimestamp]];
//    uploadInfo.firstImageData = [self.firstselectImage compressWithMaxLength:20480];//压缩到20kB左右
//    uploadInfo.videoName = [self.videoPath stringByReplacingOccurrencesOfString:@"/" withString:@""];
//    uploadInfo.videoPath = self.videoPath;
//    uploadInfo.videoSize = [uploadInfo.imageData length];
//    uploadInfo.videoOrCoverWidthHeight = [NSString stringWithFormat:@"%.0f:%.0f",self.selectImage.size.width,self.selectImage.size.height];
    
    
    // 保存视频信息
    if ([self.delegate respondsToSelector:@selector(saveThepublishVideoInfo:)]) {
        [self.delegate saveThepublishVideoInfo:uploadInfo];
    }
    
    // 以下是进度展示样式
    self.videoAlertView.selectImage = self.selectImage;
    
    // 取消上传
    WS
    [self.videoAlertView setCancelButtonClickBlock:^{
        SS
        if ([self.delegate respondsToSelector:@selector(clickCancelUpload:)]) {
            [self.delegate clickCancelUpload:YES];
        }
    }];
    // 展示上传样式
    [self.videoAlertView showInView];
    
    // 重置
    self.videoAlertView.uploadProgress = 0;
}


- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 4; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    return resultImage;
}

// 当前上传进度
-(void)setCurrentUploadProgress:(CGFloat)currentUploadProgress{
    _currentUploadProgress = currentUploadProgress;
    self.videoAlertView.uploadProgress = currentUploadProgress;
}

-(void)dismisView{
    [self.videoAlertView dissmisView];
}

//获取视频 大小
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

// 背景
- (UIScrollView *)shortBackGroundView {
    if (!_shortBackGroundView) {
        _shortBackGroundView = [[UIScrollView alloc] init];
        _shortBackGroundView.showsVerticalScrollIndicator = NO;
        _shortBackGroundView.showsHorizontalScrollIndicator = NO;
        _shortBackGroundView.alwaysBounceVertical = YES;
        _shortBackGroundView.alwaysBounceHorizontal = NO;
        _shortBackGroundView.delegate = self;
        // _shortBackGroundView.bounces = NO;
        _shortBackGroundView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        // [_shortBackGroundView.panGestureRecognizer requireGestureRecognizerToFail:[KKTool getCurrentVC].navigationController.interactivePopGestureRecognizer];
        // [[KKTool getCurrentVC].navigationController.interactivePopGestureRecognizer requireGestureRecognizerToFail:_shortBackGroundView.panGestureRecognizer ];
    }
    return _shortBackGroundView;
}

// 选封面遮罩
- (UIView *)keepView {
    if (!_keepView) {
        _keepView = [[UIView alloc] init];
        _keepView.backgroundColor = KKRGBA(0, 0, 0, 0.64);
        _keepView.hidden = YES;
    }
    return _keepView;
}

// 选封面标题
- (UILabel *)keepTitle {
    if (!_keepTitle) {
        _keepTitle = [[UILabel alloc] init];
        _keepTitle.textColor = [KKColor getColor:colorSecondBtnText];
        _keepTitle.font = [UIFont mediumWithSize:14];
        _keepTitle.textAlignment = NSTextAlignmentCenter;
        _keepTitle.text = @"选封面";
        _keepTitle.hidden = YES;
        _keepTitle.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didsKeepTitle)];
        [_keepTitle addGestureRecognizer:tap];
    }
    return _keepTitle;
}

// 发布按钮背景遮罩
- (UIView *)releaseButtonBgView {
    if (!_releaseButtonBgView) {
        _releaseButtonBgView = [[UIView alloc] init];
        _releaseButtonBgView.layer.cornerRadius = 23;
        _releaseButtonBgView.layer.masksToBounds = YES;
    }
    return _releaseButtonBgView;
}

// 发布按钮
- (UIButton *)releaseButton {
    if (!_releaseButton) {
        _releaseButton = [[UIButton alloc] init];
        [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
        _releaseButton.backgroundColor = [UIColor clearColor];
//        [_releaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_releaseButton setTitleColor:[KKColor getColor:colorMainBtnText] forState:UIControlStateNormal];
        _releaseButton.titleLabel.font = [UIFont mediumWithSize:16];
        _releaseButton.layer.cornerRadius = 23;
        _releaseButton.layer.masksToBounds = YES;
        [_releaseButton addTarget:self action:@selector(didsReleseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseButton;
}

// 上传提示
- (KKPublishShortSelectVideoAlertView *)videoAlertView {
    if (!_videoAlertView) {
        _videoAlertView  =[[KKPublishShortSelectVideoAlertView alloc] init];
    }
    return _videoAlertView;
}
@end
