//
//  KKAltView.m
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import "KKAltView.h"

@implementation KKAltView

/// 创建弹窗样式
/// @param viewConfig 当前view的配置
+(void)showAltViewWithConfigModel:(KKAltStyleConfig *)viewConfig  WithClickBlock:(alertViewClickBlock)alertBlock{
    //全屏背景
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.tag = 13001;
    // 背景
    if (viewConfig.backGroundRGBColor != nil) {
        backView.backgroundColor = viewConfig.backGroundRGBColor;
    }else{
        backView.backgroundColor = [UIColor colorWithHexString:viewConfig.backGroundColor];
    }
    // 根视图指向
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    // 添加到根视图
    [window addSubview:backView];
    
    CGFloat x = 52;
    CGFloat h = 150;
    CGFloat w = window.bounds.size.width - 2*x;
    CGFloat y = (window.bounds.size.height -h)/2;
    
//    NSString *str = @"<font color=\"#6c6c6c\">满20<font color=\"#ff9147\">113天 <font color=\"#6c6c6c\">满20减5 满40减15，还剩<font color=\"#ff9147\">113天";
    
//    viewConfig.content = str;
    CGFloat conHeight = 30;
    NSMutableAttributedString *mAstr;
    if ([viewConfig.content hasPrefix:@"<"]) {
      
//        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[viewConfig.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        CGSize maxSize = CGSizeMake(w-20, MAXFLOAT);

      mAstr = [self setTextFontWithStr:viewConfig.content Font:[UIFont regularWithSize:15] Range:NSMakeRange(0,  viewConfig.content.length)];

    //计算attributedString的rect
        CGRect rect = [mAstr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        if (rect.size.height>30) {
            conHeight = rect.size.height+5;
            h = h+ rect.size.height-30;
        }
    }
    // 背景
    KKAltShowView *alertbackView = [[KKAltShowView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    if (viewConfig.backGroundRGBColor !=nil) {
        alertbackView.backgroundColor = [KKColor getColor:colorDialogBg];
    }else{
        alertbackView.backgroundColor = [KKColor getColor:colorDialogBg];// [UIColor colorWithHexString:viewConfig.viewBackgroundColor];
    }
    [alertbackView.layer setMasksToBounds:YES];
    [alertbackView.layer setCornerRadius:viewConfig.cornerRadius];
    alertbackView.alpha = 1.0;
    [backView addSubview:alertbackView];
    alertbackView.alertBlock = alertBlock;
    
    alertbackView.center = backView.center;
    
    // 标题
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, alertbackView.frame.size.width, 20)];
    titleLab.font = [UIFont regularWithSize:15];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textColor = [KKColor getColor:appMainTextColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = viewConfig.title;
    [alertbackView addSubview:titleLab];
    
    if (viewConfig.titleColor.length>0) {
        titleLab.backgroundColor = [UIColor colorWithHexString:viewConfig.titleColor];
    }
    
    // 内容
    UILabel * contentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLab.frame)+15, alertbackView.frame.size.width-20, 30)];
    contentLab.font = [UIFont regularWithSize:15];
    contentLab.numberOfLines = 2;
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.textColor = [UIColor whiteColor];
    contentLab.textColor = [KKColor getColor:appHintTextColor];

    if ([viewConfig.content hasPrefix:@"<"]) {
        contentLab.attributedText = mAstr;
    }
    else{
        contentLab.text = viewConfig.content;
    }
   
    [alertbackView addSubview:contentLab];
    
    if (viewConfig.contentColor.length>0) {
        contentLab.backgroundColor = [UIColor colorWithHexString:viewConfig.contentColor];
    }
    
    // 线条
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, alertbackView.frame.size.height - 40, w, 0.5)];
    [lineLabel setBackgroundColor:KKRGBA(255, 255, 255, 0.1)];
//    [lineLabel setBackgroundColor:[UIColor blackColor]];
//#545458
    lineLabel.backgroundColor = [KKTool isDarkMode] ? KKRGBA(255, 255, 255, 0.1) : KKRGBA(0, 0, 0, 0.1);
    [alertbackView addSubview:lineLabel];
    
    for (int i =0; i<viewConfig.itemConfigArray.count; i++) {
        CGFloat bx = alertbackView.frame.size.width/viewConfig.itemConfigArray.count * i;
        CGFloat bw = alertbackView.frame.size.width/viewConfig.itemConfigArray.count;
        CGFloat bh = 40;
        KKAltItemConfig * buttonConfig = viewConfig.itemConfigArray[i];
        UIButton * cenBtn = [[UIButton alloc] initWithFrame:CGRectMake(bx, alertbackView.frame.size.height-bh, bw, bh)];
        [cenBtn.titleLabel setFont:[UIFont regularWithSize:17]];
        [cenBtn setTitle:buttonConfig.buttonName forState:UIControlStateNormal];
//        [cenBtn setTitleColor:[[UIColor colorWithHexString:buttonConfig.buttonTextColor]] forState:UIControlStateNormal];
        [cenBtn setTitleColor:[KKColor getColor:colorPrimary] forState:UIControlStateNormal];

        cenBtn.tag = 1200+i;
        cenBtn.enabled = buttonConfig.buttonEnable;
        [cenBtn addTarget:alertbackView action:@selector(alerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [alertbackView addSubview:cenBtn];
        if (i != viewConfig.itemConfigArray.count) {
            UIView * buttonLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cenBtn.frame), alertbackView.frame.size.height - 40, 0.5, 40)];
            [buttonLineView setBackgroundColor:KKRGBA(255, 255, 255, 0.1)];
//            [buttonLineView setBackgroundColor:[UIColor blackColor]];
            buttonLineView.backgroundColor = [KKTool isDarkMode] ? KKRGBA(255, 255, 255, 0.1) : KKRGBA(0, 0, 0, 0.1);

            [alertbackView addSubview:buttonLineView];
        }
    }
    
    
    if (viewConfig.isClickDismss == YES) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backviewClick:)];
        [backView addGestureRecognizer:tap];
    }
}

+(void)backviewClick:(UITapGestureRecognizer *)sender{
    [sender.view removeFromSuperview];
    
}

+(void)dismiss{
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        UIView * view = [window viewWithTag:13001];
        if (view) {
            [view removeFromSuperview];
            break;
        }
    }
}

+ (NSMutableAttributedString *)setTextFontWithStr:(NSString *)str Font:(UIFont *)font Range:(NSRange)range{

     if (str == nil) return nil;
    NSMutableAttributedString *newStr=  [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[viewConfig.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//
//     NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:str];

    [newStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, newStr.length)];

    return newStr;

}
@end

@implementation KKAltShowView
-(void)alerBtnAction:(UIButton *)sender{
    if (self.alertBlock) {
        self.alertBlock(sender.tag-1200);
    }
   
    [sender.superview.superview removeFromSuperview];
}
@end
