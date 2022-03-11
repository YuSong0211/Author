//
//  KKHub.m
//  KK
//
//  Created by 小鱼 on 2021/8/9.
//

#import "KKHub.h"
#import  <Foundation/Foundation.h>
#import <objc/runtime.h>
static alertBtnAction alertBtnBlcok;
@implementation KKHub
+(void)showMtTostWithTitle:(NSString *)title WithText:(NSString *)text WithBtnText:(NSString *)btnText WithClickBlock:(nonnull alertBtnAction)alertBlock{
    ///全屏背景
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:backView];
    CGFloat x = 52;
    CGFloat h = 140;
    CGFloat w = window.bounds.size.width - 2*x;
    CGFloat y = (window.bounds.size.height -h)/2;
    //背景
    KKAllertView *alertbackView = [[KKAllertView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    [alertbackView setBackgroundColor:[UIColor blackColor]];
    [alertbackView setBackgroundColor:[KKColor getColor:appBgColor]];

    [alertbackView.layer setMasksToBounds:YES];
    [alertbackView.layer setCornerRadius:8];
    alertbackView.alpha = 1.0;
    [backView addSubview:alertbackView];
    alertbackView.aletBlock = alertBlock;
    //创建毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //创建毛玻璃视图
    UIVisualEffectView * visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
    visualView.frame = alertbackView.bounds;
    [visualView.layer setMasksToBounds:YES];
    [visualView.layer setCornerRadius:alertbackView.layer.cornerRadius];
    //添加到imageView上
    [alertbackView addSubview:visualView];
    //title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, w, 20)];
    [titleLabel setText:title];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    [titleLabel setTextColor:[KKColor getColor:appMainTextColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [alertbackView addSubview:titleLabel];
    //文本
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height+titleLabel.frame.origin.y, w, alertbackView.frame.size.height-titleLabel.frame.size.height-titleLabel.frame.origin.y-40)];
    [textLabel setText:text];
    [textLabel setFont:[UIFont systemFontOfSize:14]];
    [textLabel setTextColor:[KKColor getColor:appHintTextColor]];
//    [textLabel setTextColor:KKRGBA(204, 200, 193, 1)];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [alertbackView addSubview:textLabel];

    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, textLabel.frame.size.height+textLabel.frame.origin.y, w, 0.5)];
    [lineLabel setBackgroundColor:KKRGBA(40, 41, 42, 1)];
    [alertbackView addSubview:lineLabel];
    ///按钮处理
    NSArray *array = [btnText componentsSeparatedByString:@","];
    for (int i =0; i<array.count; i++) {
        CGFloat bx = alertbackView.frame.size.width/array.count * i;
        CGFloat bw = alertbackView.frame.size.width/array.count;
        CGFloat bh = 40;
        UIButton * cenBtn = [[UIButton alloc] initWithFrame:CGRectMake(bx, alertbackView.frame.size.height-bh, bw, bh)];
        [cenBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [cenBtn setTitle:array[i] forState:UIControlStateNormal];
//        [cenBtn setTitleColor:KKRGBA(0, 111, 255, 1) forState:UIControlStateNormal];
        [cenBtn setTitleColor:[KKColor getColor:colorSecondBtnText] forState:UIControlStateNormal];

        cenBtn.tag = 1200+i;
        [cenBtn addTarget:alertbackView action:@selector(alerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [alertbackView addSubview:cenBtn];
    }
}
-(void)alerBtnAction:(UIButton *)sender{}
@end

@implementation KKAllertView
-(void)alerBtnAction:(UIButton *)sender{
    self.aletBlock(sender.tag-1200);
    [sender.superview.superview removeFromSuperview];
}

@end
