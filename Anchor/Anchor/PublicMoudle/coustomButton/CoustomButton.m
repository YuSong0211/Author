//
//  CoustomButton.m
//  KK
//
//  Created by 小草 on 2021/6/24.
//

#import "CoustomButton.h"
//#import <SDImageCache.h>
//#import <SDWebImage.h>

@interface CoustomButton ()


@end

@implementation CoustomButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.buttonLab];
        [self addSubview:self.buttonIcon];
        [self addSubview:self.loadingImage];
        
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark -- 自定义frame
/**
 * TODO: 动态frame
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize textSize;
    // 之前操作类型有图片就需要设置lab的相关内容
    if (self.yc_buttonStyle != YcButtonStyleOnlyImage) {
        // 如果程序卡在了这里，说明需要设置lab的文字及字体
        //NSAssert(self.buttonLab.text ==nil && self.buttonLab.font ==nil, @"请设置lab的相关属性");
        self.buttonLab.text = [NSString stringWithFormat:@"%@ ",self.yc_buttontitle];
        textSize =   [self.buttonLab.text boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.buttonLab.font} context:nil].size;
    }
    // 未设置枚举类型，默认使用第一个类型
    switch (self.yc_buttonStyle) {
        case YcButtonStyleTextUpImageBottomType :  // 文字在上，图片在下
            self.buttonLab.frame = CGRectMake(0, 0, self.frame.size.width, textSize.height);
            self.buttonLab.textAlignment = NSTextAlignmentCenter;
            self.buttonIcon.frame = CGRectMake(self.frame.size.width/2-(self.yc_buttonimagesize.width/2), CGRectGetMaxY(self.buttonLab.frame)+self.yc_controlMargin, self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
            break;
        case YcButtonStyleTextBottomImageTopType : // 文字在下，图片在上
            self.buttonLab.textAlignment = NSTextAlignmentCenter;
            self.buttonIcon.frame = CGRectMake(self.frame.size.width/2-(self.yc_buttonimagesize.width/2), 0, self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
            self.buttonLab.frame = CGRectMake(0, self.frame.size.height-textSize.height, self.frame.size.width,textSize.height);
            break;
        case YcButtonStyleTextLeftImageRightType : // 文字在左，图片在右
            self.buttonLab.textAlignment = NSTextAlignmentLeft;
            self.buttonLab.frame = CGRectMake(0, self.frame.size.height/2-(textSize.height/2), textSize.width, textSize.height);
            self. buttonIcon.frame = CGRectMake(CGRectGetMaxX(self.buttonLab.frame)+self.yc_controlMargin, self.frame.size.height / 2 - (self.yc_buttonimagesize.height / 2), self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
            break;
        case YcButtonStyleTextRightImageLeftType : // 文字在右，图片在左
            self.buttonLab.textAlignment = NSTextAlignmentLeft;
            
            if (self.yc_buttonimagesize.height>textSize.height) {
                self.buttonIcon.frame = CGRectMake(0, 0, self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
                self.buttonLab.frame = CGRectMake(CGRectGetMaxX(self.buttonIcon.frame)+self.yc_controlMargin, self.frame.size.height/2-(textSize.height/2), textSize.width, textSize.height);
            }else{
                self.buttonIcon.frame = CGRectMake(0, self.frame.size.height/2-(self.yc_buttonimagesize.height/2), self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
                self.buttonLab.frame = CGRectMake(CGRectGetMaxX(self.buttonIcon.frame)+self.yc_controlMargin, self.frame.size.height/2-(textSize.height/2), textSize.width, textSize.height);
            }
            break;
        case YcButtonStyleImageTextCenter:
            self.buttonLab.textAlignment = NSTextAlignmentCenter;
            self.buttonIcon.frame = CGRectMake(self.frame.size.width/2-(self.yc_buttonimagesize.width/2), self.frame.size.height/2-(self.yc_controlMargin/2)-self.yc_buttonimagesize.height, self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
            self.buttonLab.frame = CGRectMake(0, CGRectGetMaxY(self.buttonIcon.frame)+self.yc_controlMargin, self.frame.size.width,textSize.height);
            break;
        case YcButtonStyleOnlyText : // 只有文字
            self.buttonIcon.hidden = YES;
            self.buttonLab.frame = CGRectMake(0, self.frame.size.height/2-(textSize.height/2),self.frame.size.width, textSize.height);
            self.buttonLab.textAlignment = NSTextAlignmentCenter;
            break;
        case YcButtonStyleOnlyImage: // 只有图片
            self.buttonLab.hidden = YES;
            self.buttonIcon.frame = CGRectMake(self.frame.size.width/2-(self.yc_buttonimagesize.width/2), self.frame.size.height/2-(self.yc_buttonimagesize.height/2), self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
            break;
        case YcButtonStyleImageTextAlentCenter:{ // 图片和文字并排  图片在左
            CGFloat iconStartpoint =  (textSize.width+self.yc_buttonimagesize.width+self.yc_controlMargin);
            self.buttonIcon.frame = CGRectMake(self.frame.size.width/2-(iconStartpoint/2), self.frame.size.height/2-(self.yc_buttonimagesize.height/2), self.yc_buttonimagesize.width, self.yc_buttonimagesize.height);
            self.buttonLab.frame = CGRectMake(CGRectGetMaxX(self.buttonIcon.frame)+self.yc_controlMargin, self.frame.size.height/2-(textSize.height/2), textSize.width, textSize.height);
        }
            break;
        default:
            break;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 当前btn的大小
    CGRect btnBounds =self.bounds;
    // 扩大按钮的点击范围，改为负值
    btnBounds = CGRectInset(btnBounds, -20, -20);
    // 若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
}

// 如果自己被点击了
-(void)clickAction:(UIButton *)sender{
    if (self.isShowLoadingStyle == YES) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
        animation.duration = 0.7;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [self.loadingImage.layer addAnimation:animation forKey:nil];
        self.loadingImage.hidden = NO;
        self.buttonLab.hidden = YES;
        self.buttonIcon.hidden = YES;
    }
}

// 复位按钮
-(void)resetTheButton{
    self.loadingImage.hidden = YES;
    self.buttonLab.hidden = NO;
    self.buttonIcon.hidden = NO;
}

#pragma mark -- 自定义设置
/**
 * TODO: 文字与image之间的间距
 */
-(void)setYc_controlMargin:(CGFloat)yc_controlMargin{
    _yc_controlMargin = yc_controlMargin;
}

/**
 * TODO: 文字
 */
-(void)setYc_buttontitle:(NSString *)yc_buttontitle{
    _yc_buttontitle = yc_buttontitle;
    self.buttonLab.text = yc_buttontitle;
}

/**
 * TODO: 字体
 */
-(void)setYc_titleFont:(UIFont *)yc_titleFont{
    _yc_titleFont = yc_titleFont;
    self.buttonLab.font = _yc_titleFont;
}

/**
 * TODO: 字体颜色
 */
-(void)setYc_titleColor:(UIColor *)yc_titleColor{
    _yc_titleColor = yc_titleColor;
    self.buttonLab.textColor = yc_titleColor;
}

/**
 * TODO: buttonImageColor
 */
- (void)setYc_buttonImageColor:(UIColor *)yc_buttonImageColor {
    _yc_buttonImageColor = yc_buttonImageColor;
    self.buttonIcon.backgroundColor = yc_buttonImageColor;
}

/**
 * TODO: 自定义网路图片动画
 */
-(void)setYc_buttonImagePath:(NSString *)yc_buttonImagePath {
    _yc_buttonImagePath = yc_buttonImagePath;
    [self.buttonIcon setImageWithUrlString:yc_buttonImagePath animated:YES];
}

/**
 * TODO: buttonImageName
 */
-(void)setYc_buttonImageName:(NSString *)yc_buttonImageName{
    _yc_buttonImageName = yc_buttonImageName;
    
    // 可能是网络图片
    if ([yc_buttonImageName containsString:@"http"]) {
        // 根据传入的key，删除缓存和磁盘。
        [[SDImageCache sharedImageCache] removeImageForKey:yc_buttonImageName fromDisk:YES withCompletion:^{
            [self.buttonIcon sd_setImageWithURL:[NSURL URLWithString:yc_buttonImageName] placeholderImage:nil];
        }];
        self.buttonIcon.backgroundColor = [UIColor grayColor];
    }else{
        if ([yc_buttonImageName isEqualToString:@"mine_header_edit_userinfo_ic"]) {
            UIImage *img=[UIImage imageNamed:yc_buttonImageName];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.buttonIcon.image =img;
            [self.buttonIcon setTintColor:[KKColor getColor:colorSecondBtnText]];
        }else if([yc_buttonImageName isEqualToString:@"mine_header_phone_userinfo_ic"]){
            UIImage *img=[UIImage imageNamed:yc_buttonImageName];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.buttonIcon.image =img;
            [self.buttonIcon setTintColor:[KKColor getColor:colorPrimary]];
        }else{
            self.buttonIcon.image =[UIImage imageNamed:yc_buttonImageName];
        }
      
    }
}

/**
 * TODO: buttonImageName
 */
-(void)setYc_buttonImageNameChangeTheme:(NSString *)yc_buttonImageNameChangeTheme{
    _yc_buttonImageNameChangeTheme = yc_buttonImageNameChangeTheme;
    
    // 可能是网络图片
    if ([yc_buttonImageNameChangeTheme containsString:@"http"]) {
        // 根据传入的key，删除缓存和磁盘。
        [[SDImageCache sharedImageCache] removeImageForKey:yc_buttonImageNameChangeTheme fromDisk:YES withCompletion:^{
            [self.buttonIcon sd_setImageWithURL:[NSURL URLWithString:yc_buttonImageNameChangeTheme] placeholderImage:nil];
        }];
        self.buttonIcon.backgroundColor = [UIColor grayColor];
    }else{
        if ([yc_buttonImageNameChangeTheme isEqualToString:@"mine_header_edit_userinfo_ic"]) {
            UIImage *img=[KKTool decodeResourceFileImageName:yc_buttonImageNameChangeTheme];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.buttonIcon.image =img;
            [self.buttonIcon setTintColor:[KKColor getColor:colorSecondBtnText]];
        }else if([yc_buttonImageNameChangeTheme isEqualToString:@"mine_header_phone_userinfo_ic"]){
            UIImage *img=[KKTool decodeResourceFileImageName:yc_buttonImageNameChangeTheme];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.buttonIcon.image =img;
            [self.buttonIcon setTintColor:[KKColor getColor:colorPrimary]];
        }else{
            self.buttonIcon.image = [KKTool decodeResourceFileImageName:yc_buttonImageNameChangeTheme];
        }
      
    }
}

-(void)setYc_buttonImageName:(NSString *)yc_buttonImageName WithImageColor:(UIColor*)imageColor withType:(nonnull NSString *)type{
    _yc_buttonImageName = yc_buttonImageName;
    // 可能是网络图片
    if ([yc_buttonImageName containsString:@"http"]) {
        // 根据传入的key，删除缓存和磁盘。
        [[SDImageCache sharedImageCache] removeImageForKey:yc_buttonImageName fromDisk:YES withCompletion:^{
            [self.buttonIcon sd_setImageWithURL:[NSURL URLWithString:yc_buttonImageName] placeholderImage:nil];
        }];
        self.buttonIcon.backgroundColor = [UIColor grayColor];
    }else{
        if ([type isEqualToString:@"1"]) {
            UIImage *img=[KKTool decodeResourceFileImageName:yc_buttonImageName];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.buttonIcon.image =img;
            [self.buttonIcon setTintColor:imageColor];
        }else if([type isEqualToString:@"2"]){
            UIImage *img=[KKTool decodeResourceFileImageName:yc_buttonImageName];
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.buttonIcon.image =img;
            [self.buttonIcon setTintColor:imageColor];
        }else{
            self.buttonIcon.image = [KKTool decodeResourceFileImageName:yc_buttonImageName];
        }
      
    }
}
-(void)setYc_buttonImage:(UIImage *)yc_buttonImage{
    _yc_buttonImage = yc_buttonImage;
    self.buttonIcon.image = yc_buttonImage;
}

/**
 * TODO: 图片的宽高
 */
-(void)setYc_buttonimagesize:(CGSize)yc_buttonimagesize{
    _yc_buttonimagesize = yc_buttonimagesize;
}

/**
 * TODO: 圆角
 */
-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.buttonIcon.layer.cornerRadius = cornerRadius;
    self.buttonIcon.layer.masksToBounds = YES;
}

/**
 * TODO: 初始化控件内容
 */
-(UILabel *)buttonLab{
    if (!_buttonLab) {
        _buttonLab = [[UILabel alloc]init];
    }
    return _buttonLab;
}

/**
 * TODO: 按钮icon
 */
-(UIImageView *)buttonIcon{
    if (!_buttonIcon) {
        _buttonIcon = [[UIImageView alloc]init];
        _buttonIcon.transform = CGAffineTransformIdentity;
    }
    return _buttonIcon;
}

/**
 * TODO: 加载中icon
 */
-(UIImageView *)loadingImage{
    if (!_loadingImage) {
        _loadingImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-(20/2), self.frame.size.height/2-(20/2), 20, 20)];
        _loadingImage.image = [UIImage imageNamed:@"loadingIcon"];
        _loadingImage.hidden = YES;
    }
    return _loadingImage;
}


// 开始动画
-(void)startButtonAnimationWithImage:(NSString *)imageName{
//    self.buttonIcon.transform =  CGAffineTransformIdentity;
//    self.buttonIcon.transform =  CGAffineTransformMakeScale(0.1, 0.1);
//    [UIView animateWithDuration:5 animations:^{
//
//    } completion:^(BOOL finished) {
////        self.buttonIcon.image = [UIImage imageNamed:imageName];
////        [UIView animateWithDuration:5 animations:^{
////            self.buttonIcon.transform =  CGAffineTransformIdentity;
////        } completion:^(BOOL finished) {
////        }];
//    }];
}

// 消失动画
-(void)dismissAnimation{
}
@end
