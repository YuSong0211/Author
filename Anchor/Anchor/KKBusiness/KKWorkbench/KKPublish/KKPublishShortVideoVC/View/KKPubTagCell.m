//
//  KKPubTagTableViewCell.m
//  KK
//
//  Created by 小鱼 on 2021/7/1.
//
#import "KKPubTagCell.h"
@interface KKPubTagCell()
@property (nonatomic,strong)UIView *titleBgView;


@end

@implementation KKPubTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.contentView.layer.cornerRadius = 32 / 2;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [KKColor getColor:colorSecondBtnBg];
    [self.contentView addSubview:self.titleBgView];
    [self.titleBgView addSubview:self.titleLabel];
    
}
- (void)setModel:(KKPubTagVCDataModel *)model {
    _model = model;
    if (model.isSelect == 0) {
        // 选中
        [self createByCAGradientLayer:[KKColor getColor:colorPrimary] endColor:[KKColor getColor:colorPrimaryDark] layerFrame:self.contentView.frame direction:GradientTypeLeftToRight];
        [self.titleLabel setTextColor:[KKColor getColor:colorMainBtnText]];
    }else {
        // 取消
        [self.layerNew removeFromSuperlayer];
        [self.titleLabel setTextColor:[KKColor getColor:colorSecondBtnText]];
    }
}
-(void)setTagModel:(KKPubTagVCDataModel *)tagModel{
    
    _tagModel = tagModel;
    if (tagModel.isSelect == 0) {
        // 选中
        [self createByCAGradientLayer:[KKColor getColor:colorPrimary] endColor:[KKColor getColor:colorPrimaryDark] layerFrame:self.contentView.frame direction:GradientTypeLeftToRight];
        [self.titleLabel setTextColor:[KKColor getColor:colorMainBtnText]];
    }else {
        // 取消
        [self.layerNew removeFromSuperlayer];
        [self.titleLabel setTextColor:[KKColor getColor:colorSecondBtnText]];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.titleBgView);
    }];
}
- (UIView *)titleBgView {
    if (!_titleBgView) {
        _titleBgView = [[UIView alloc] init];
    }
    return _titleBgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor =  [KKColor getColor:colorSecondBtnText];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font =[UIFont regularWithSize:14];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    
    

}
-(void)createByCAGradientLayer:(UIColor *)startColor endColor:(UIColor *)endColor layerFrame:(CGRect)frame direction:(GradientType)direction{
    
    [self.layerNew.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layerNew removeFromSuperlayer];
    self.layerNew = nil;

    self.layerNew = [CAGradientLayer new];
    //存放渐变的颜色的数组
    self.layerNew.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    //起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
    switch (direction) {
        case GradientTypeTopToBottom:
            self.layerNew.startPoint = CGPointMake(0.0, 0.0);
            self.layerNew.endPoint = CGPointMake(0.0, 1);
            break;
        case GradientTypeLeftToRight:
            self.layerNew.startPoint = CGPointMake(0.0, 0.0);
            self.layerNew.endPoint = CGPointMake(1, 0.0);
            break;
        default:
            break;
    }
    self.layerNew.frame = frame;
    [self.titleBgView.layer insertSublayer:self.layerNew atIndex:0];
}
@end
