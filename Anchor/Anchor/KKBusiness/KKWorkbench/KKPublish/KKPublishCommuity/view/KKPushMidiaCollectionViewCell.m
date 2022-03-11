//
//  KKPushMidiaCollectionViewCell.m
//  mt
//
//  Created by 小草 on 2021/9/14.
//

#import "KKPushMidiaCollectionViewCell.h"

@interface KKPushMidiaCollectionViewCell ()

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,strong) UIView * deleteBackView; // 删除背景视图

@property (nonatomic,strong) KKClearButton * deleteButton; // 删除按钮

@end

@implementation KKPushMidiaCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [KKColor getColor:colorSecondBtnBg];
        [self addSubview:self.imageView];
        [self addSubview:self.deleteBackView];
        [self addSubview:self.deleteButton];
    }
    return self;
}

-(void)setModel:(KKPublishSelectModel *)model{
    _model = model;
    
    if (model.selectType == KKPublishSelectModelMediaImageType) {
        self.imageView.image = model.image;
    }else{
        self.imageView.image = model.videoImage;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.deleteBackView.frame = CGRectMake(0, self.imageView.frame.size.height - 30, self.imageView.frame.size.width, 30);
    self.deleteButton.frame = CGRectMake(self.deleteBackView.frame.size.width - 13.5 - 15, self.imageView.frame.size.height-30, 30, 30);
}

// 删除按钮点击
-(void)deleteTheImageClick{
    if (self.deleteImageBlock) {
        self.deleteImageBlock();
    }
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 7.5;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}


-(UIView *)deleteBackView{
    if (!_deleteBackView) {
        _deleteBackView = [[UIView alloc]init];
        _deleteBackView.backgroundColor = KKRGBA(0, 0, 0, 0.7);
        _deleteBackView.userInteractionEnabled = YES;
    }
    return _deleteBackView;
}

-(KKClearButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [[KKClearButton alloc]init];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_publish_community"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteTheImageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
