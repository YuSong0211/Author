//
//  KKMinewallteCell.m
//  mt
//
//  Created by ProgramMa on 2021/10/18.
//

#import "KKMinewallteCell.h"
#import "KKMainWebView.h"

@interface KKMinewallteCell()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UIImageView * arrowIcon;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UIView *layerView;
@property (nonatomic,strong) UILabel * walletDetailLab; // 钱包余额标签
//@property (nonatomic,strong) KKMainWebView * webView;
@property (nonatomic,strong) UIButton *tempButton;


@end

@implementation KKMinewallteCell
-(void)reloadWeb{
    //[self.webView reloadWeb];

    
    WS
    [KKTool getWalleTotalAmount:^(CGFloat totalAmount) {
        SS
        self.walletLab.text = [NSString stringWithFormat:@" ￥%@",[KKTool changeFloatWithFloat:totalAmount]];
    }];
    
}

- (UIButton *)tempButton {
    if (!_tempButton) {
        _tempButton = [[UIButton alloc] init];
        _tempButton.backgroundColor = [UIColor clearColor];
        [_tempButton addTarget:self action:@selector(webViewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tempButton;
}

- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [[UIView alloc] init];
        _layerView.backgroundColor = [KKColor getColor:appMainCardBgColor];
        _layerView.layer.cornerRadius = 15;
        _layerView.layer.masksToBounds = YES;
    }
    return _layerView;
}
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
//        _iconView.image = KKImage(@"icon_main_wallet");
        UIImage *img=[KKTool decodeResourceFileImageName:@"icon_main_wallet"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _iconView.image =img;
        [_iconView setTintColor:[KKColor getColor:appHintTextColor]];
    }
    return _iconView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [KKColor getColor:appMainTextColor];
        _titleLab.font = [UIFont mediumWithSize:14];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.text = @"钱包余额";
    }
    return _titleLab;
}
-(UILabel *)walletLab{
    if (!_walletLab) {
        _walletLab = [[UILabel alloc]init];
        _walletLab.textColor = [KKColor getColor:colorPrimary];
        _walletLab.font = [UIFont mediumWithSize:16];
        _walletLab.textAlignment = NSTextAlignmentLeft;
    }
    return _walletLab;
}

//-(KKMainWebView *)webView{
//    if (!_webView) {
//        _webView = [[KKMainWebView alloc]init];
//        _webView.backgroundColor = [UIColor clearColor];
////        _webView.userInteractionEnabled = YES;
////        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webViewAction)];
////        [_webView addGestureRecognizer:tap];
//    }
//    return _webView;
//}


-(UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc]init];
        UIImage *img=[UIImage imageNamed:@"mine_cell_arrow_ic"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrowIcon.image =img;
        [_arrowIcon setTintColor:[KKColor getColor:appHintTextColor]];
    }
    return _arrowIcon;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
//        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.textColor = [KKColor getColor:appMainTextColor];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.text = @"提现";
    }
    return _descLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (void)webViewAction {
    if (self.clickWebViewCallBack) {
        self.clickWebViewCallBack();
    }
}

- (void)initSubViews {
    [self.contentView addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.height.equalTo(@(49 * KK_SCREEN_SCALE));
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).inset(15);
        make.bottom.equalTo(self.contentView).inset(0);
    }];
    [self.layerView addSubview:self.iconView];
    
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.layerView).offset(15);
        make.height.width.equalTo(@25);
        make.centerY.equalTo(self.layerView);
    }];
    
    [self.layerView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.centerY.equalTo(self.iconView);
        make.size.mas_equalTo(CGSizeMake(65, 20));
    }];
    
    [self.layerView addSubview:self.arrowIcon];
    [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.layerView).inset(15);
        make.height.width.equalTo(@(9.5));
        make.centerY.equalTo(self.layerView);
    }];
    
    [self.layerView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.layerView);
        make.right.equalTo(self.arrowIcon.mas_left).inset(10);
        make.width.equalTo(@50);
    }];
    
    [self.layerView addSubview:self.walletLab];
    [self.walletLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.layerView);
        make.left.equalTo(self.titleLab.mas_right);
        make.right.equalTo(self.descLabel.mas_left);
    }];
    
//    [self.layerView addSubview:self.webView];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.layerView);
//        make.left.equalTo(self.titleLab.mas_right);
//        make.right.equalTo(self.descLabel.mas_left);
//    }];
    
    [self.layerView addSubview:self.tempButton];
    [self.tempButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.walletLab);
    }];
    
    // 刷新钱包
    [self reloadWeb];
}

- (NSString *)changeFloatWithFloat:(CGFloat)floatValue
{
    return [self changeFloatWithString:[NSString stringWithFormat:@"%f",floatValue]];
}
- (NSString *)changeFloatWithString:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}
@end
