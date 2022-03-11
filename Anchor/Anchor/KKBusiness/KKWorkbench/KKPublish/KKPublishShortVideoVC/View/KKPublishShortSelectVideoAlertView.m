//
//  KKPublishShortSelectVideoAlertView.m
//  KK
//
//  Created by ProgramMa on 2021/7/8.
//

#import "KKPublishShortSelectVideoAlertView.h"

@interface KKPublishShortSelectVideoAlertView ()
@property (nonatomic, strong) UIView *keepView; // 蒙层
@property (nonatomic, strong) UIButton *canCelButton;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIImageView *avter;
@property (nonatomic, strong) UILabel *progressTitle;

@end
@implementation KKPublishShortSelectVideoAlertView
- (void)showInView {
    self.frame = CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT);
    self.backgroundColor = KKRGBA(0, 0, 0, 0.64);
    [KK_GET_WINDOWS addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        
    }];
    [self addSubview:self.keepView];
    [self.keepView addSubview:self.canCelButton];
    [self addSubview:self.progressView];
    [self.keepView addSubview:self.avter];
    [self.keepView addSubview:self.progressTitle];
    // 蒙层
    [self.keepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(105.5);
        make.bottom.mas_equalTo(0);
    }];
    // 取消上传
    [self.canCelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.keepView).offset(-15);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(105);
        make.top.mas_equalTo(16.5);
    }];
    // 头像
    [self.avter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(52);
        make.height.mas_equalTo(52);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(16);
    }];
    // 上传进度说明
    [self.progressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(30);
    }];
}

// 选择图片
- (void)setSelectImage:(UIImage *)selectImage {
    _selectImage = selectImage;
    self.avter.image = selectImage;
}

// 当前上传进度 （包含上传图像 上传视频，回调我们自己的服务器）
-(void)setUploadProgress:(CGFloat)uploadProgress{
    _uploadProgress = uploadProgress;
    NSLog(@"%f  %@",uploadProgress,self);
    CGFloat progressViewWidth = uploadProgress == 0?0:(self.frame.size.width/10 )* (uploadProgress/10);
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(progressViewWidth);
        make.height.mas_equalTo(2);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.keepView.mas_top).offset(0);
    }];
    self.progressTitle.text = [NSString stringWithFormat:@"上传中 %.0f%%",uploadProgress];
    if (uploadProgress == 100) {
        self.progressTitle.text = @"处理中…";
    }else if (uploadProgress == 0){
        self.progressTitle.text = [NSString stringWithFormat:@"上传中 0%%"];
    }
}
- (void)setUploadProgressone:(CGFloat)uploadProgressone{
    _uploadProgressone = uploadProgressone;
    
    CGFloat progressViewWidth = uploadProgressone == 0?0:(self.frame.size.width )* uploadProgressone;
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(progressViewWidth);
        make.height.mas_equalTo(2);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.keepView.mas_top).offset(0);
    }];
    
    self.progressTitle.text = [NSString stringWithFormat:@"上传中 %.0f%%",uploadProgressone*100];
    
}
// 消失
- (void)dissmisView {
    self.progressTitle.text = [NSString stringWithFormat:@"上传中 0%%"];
    if ([NSThread isMainThread]) {
        [self removeFromSuperview];
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
}

// 点击退出
- (void)didsCanCelButton {
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(0);
        make.top.mas_equalTo(self.keepView.mas_top).offset(0);
    }];
    // 是否声明block
    if (self.cancelButtonClickBlock) {
        self.cancelButtonClickBlock();
    }
    [self dissmisView];
}
- (UIView *)keepView {
    if (!_keepView) {
        _keepView = [[UIView alloc] init];
        _keepView.backgroundColor = [KKColor getColor:appBgColor];
    }
    return _keepView;
}
- (UIButton *)canCelButton {
    if (!_canCelButton) {
        _canCelButton = [[UIButton alloc] init];
        [_canCelButton setTitle:@"取消上传" forState:UIControlStateNormal];
        [_canCelButton setTitleColor: [KKColor getColor:colorMainBtnText] forState:UIControlStateNormal];
        _canCelButton.backgroundColor = [KKColor getColor:colorPrimary];
        _canCelButton.layer.cornerRadius = 20;
        _canCelButton.layer.masksToBounds = YES;
        _canCelButton.titleLabel.font = [UIFont mediumWithSize:14];
        [_canCelButton addTarget:self action:@selector(didsCanCelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canCelButton;
}
- (UIImageView *)avter {
    if (!_avter) {
        _avter = [[UIImageView alloc] init];
        _avter.backgroundColor = [UIColor blueColor];
        _avter.layer.cornerRadius = 52/2;
        [_avter setContentMode:UIViewContentModeScaleAspectFill];
        _avter.layer.masksToBounds = YES;
        _avter.hidden = YES;
    }
    return _avter;
}
- (UILabel *)progressTitle {
    if (!_progressTitle) {
        _progressTitle = [[UILabel alloc] init];
        _progressTitle.text = @"上传中 0%";
        _progressTitle.font = [UIFont regularWithSize:15];
        _progressTitle.textColor =  [KKColor getColor:appMainTextColor];
    }
    return _progressTitle;
}
- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = KK_THEMECOLOR;
    }
    return _progressView;
}
@end
