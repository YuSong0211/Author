//
//  KKAltCoustomView.m
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import "KKAltCoustomView.h"

@implementation KKAltCoustomView

/// 创建弹窗样式自定义型
/// @param viewConfig 当前view的配置
+(void)showAltCoustomViewWithConfigModel:(KKAltStyleConfig *)viewConfig  WithClickBlock:(alertViewClickBlock)alertBlock{
    
    //全屏背景
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.tag = 13002;
    // 背景
    backView.backgroundColor = [UIColor colorWithHexString:viewConfig.backGroundColor];
    // 根视图指向
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    // 添加到根视图
    [window addSubview:backView];
    
    
    // 展示的背景图片
    KKAltShowCoustomView * showCoustomView  = [[KKAltShowCoustomView alloc]initWithFrame:CGRectMake(20, 0, backView.frame.size.width-40, 200)];
    [backView addSubview:showCoustomView];
    showCoustomView.layer.cornerRadius = viewConfig.cornerRadius;
    showCoustomView.backgroundColor = [UIColor colorWithHexString:viewConfig.viewBackgroundColor];
    showCoustomView.alertBlock = alertBlock;
    
    // 标题
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, showCoustomView.frame.size.width, 20)];
    titleLab.font = [UIFont regularWithSize:15];
    titleLab.textColor = [KKColor getColor:appMainTextColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = viewConfig.title;
    [showCoustomView addSubview:titleLab];
    
    if (viewConfig.titleColor.length>0) {
        titleLab.backgroundColor = [UIColor colorWithHexString:viewConfig.titleColor];
    }
    
    // 内容
    UILabel * contentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLab.frame)+15, showCoustomView.frame.size.width-20, 30)];
    contentLab.font = [UIFont regularWithSize:15];
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.textColor = [KKColor getColor:appMainTextColor];
    contentLab.text = viewConfig.content;
    [showCoustomView addSubview:contentLab];
    
    if (viewConfig.contentColor.length>0) {
        contentLab.backgroundColor = [UIColor colorWithHexString:viewConfig.contentColor];
    }
    
    CGFloat viewheight = 0;
    
    for (int i = 0; i<viewConfig.itemConfigArray.count; i++) {
        CGFloat bh = 40;
        CGFloat bx = 15;
        CGFloat by = CGRectGetMaxY(contentLab.frame)+20+(bh+20)*i;
        CGFloat bw = showCoustomView.frame.size.width - 30;
        
        KKAltItemConfig * buttonConfig = viewConfig.itemConfigArray[i];
        UIButton * cenBtn = [[UIButton alloc] initWithFrame:CGRectMake(bx, by, bw, bh)];
        [cenBtn.titleLabel setFont:[UIFont regularWithSize:17]];
        [cenBtn setTitle:buttonConfig.buttonName forState:UIControlStateNormal];
        [cenBtn setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
        cenBtn.layer.cornerRadius = buttonConfig.cornerRadius;
        cenBtn.backgroundColor = [UIColor colorWithHexString:buttonConfig.buttonBackGroundColor];
        cenBtn.tag = 1200+i;
        cenBtn.enabled = buttonConfig.buttonEnable;
        [cenBtn addTarget:showCoustomView action:@selector(alerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [showCoustomView addSubview:cenBtn];
        viewheight = CGRectGetMaxY(cenBtn.frame)+20;
    }
    
    showCoustomView.frame = CGRectMake(20, backView.frame.size.height/2-(viewheight/2), backView.frame.size.width-40, viewheight);
    
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
        UIView * view = [window viewWithTag:13002];
        if (view) {
            [view removeFromSuperview];
            break;
        }
    }
}


@end


@implementation KKAltShowCoustomView
-(void)alerBtnAction:(UIButton *)sender{
    self.alertBlock(sender.tag-1200);
    [sender.superview.superview removeFromSuperview];
}
@end
