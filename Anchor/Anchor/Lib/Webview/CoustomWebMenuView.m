//
//  CoustomWebMenuView.m
//  mt
//
//  Created by 小草 on 2021/9/22.
//

#import "CoustomWebMenuView.h"

@interface CoustomWebMenuView ()

@property (nonatomic,strong) NSMutableArray * buttonArray; // 按钮数组

@property (nonatomic,strong) NSMutableArray * buttonImageArray; // 图片数组

@property (nonatomic,assign) BOOL isLeft;

@property (nonatomic,assign) NSInteger buttonType; // 按钮类型

@end

@implementation CoustomWebMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KKRGBA(0, 0, 0, 0.5);
        UITapGestureRecognizer * tapSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelf)];
        [self addGestureRecognizer:tapSelf];
    }
    return self;
}

/// 显示功能按钮
/// @param buttonFrame 悬浮按钮的frame
-(void)showTheMenuViewWithButtonFrame:(CGRect)buttonFrame{
    
    CGFloat x = buttonFrame.origin.x;
    CGFloat y = buttonFrame.origin.y;
    CGFloat width = buttonFrame.size.width;
    
    // 是否在左边
    self.isLeft = x<KK_SCREEN_WIDTH/2?YES:NO;
    
    // 按钮图片
    NSString * webviewBackOrPay = @"webview_back_ic";
    if (self.buttonType == 1) {
        webviewBackOrPay = @"webview_menu_pay_ic";
    }
    self.buttonImageArray = [[NSMutableArray alloc]initWithObjects:@"webview_cancel_ic",@"webview_reload_ic",webviewBackOrPay, nil];
    for (int i = 0; i<3; i++) {
        KKClearButton * meunButton = [KKClearButton buttonWithType:UIButtonTypeSystem];
        meunButton.imageView.contentMode = UIViewContentModeScaleToFill;
        if (self.isLeft == YES) {
            meunButton.frame = CGRectMake(x+width+25+(i*68), y+3.5, 48, 48);
            meunButton.transform = CGAffineTransformMakeTranslation(-100, 0);
        }else{
            meunButton.frame = CGRectMake(x-48-25-(i*68), y+3.5, 48, 48);
            meunButton.transform = CGAffineTransformMakeTranslation(100, 0);
        }
        meunButton.tag = 88888+i;
        meunButton.alpha = 0;
        [meunButton setBackgroundImage:[UIImage imageNamed:self.buttonImageArray[i]] forState:UIControlStateNormal];
        [meunButton addTarget:self action:@selector(clickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:meunButton];
        [self.buttonArray addObject:meunButton];
    }
    
    // 添加动画
    for (int i = 0; i < self.buttonArray.count; i++) {
        KKClearButton *button = self.buttonArray[i];
        [UIView animateWithDuration:0.5 delay:i*0.05 - i/self.buttonArray.count usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.alpha = 1;
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {}];
    }
}

/// 消失功能按钮
-(void)dismissTheMenuView{
    for (int i = 0; i<self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        [UIView animateWithDuration:0.5 delay:i*0.05 - i/self.buttonArray.count usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.alpha = 0;
            if (self.isLeft == YES) {
                button.transform = CGAffineTransformMakeTranslation(-100, 0);
            }else{
                button.transform = CGAffineTransformMakeTranslation(100, 0);
            }
        } completion:^(BOOL finished) {
            [button removeFromSuperview];
        }];
    }
    [self.buttonArray removeAllObjects];
    // 延迟消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

// 点击功能按钮
-(void)clickMenuButton:(UIButton *)sender{
    NSString * buttonName =  self.buttonImageArray[sender.tag - 88888];
    CoustomWebMenuViewType buttonType = CoustomWebMenuViewCancelType;
    
    if ([buttonName isEqualToString:@"webview_cancel_ic"]) {
        buttonType = CoustomWebMenuViewCancelType;
        NSLog(@"退出");
    }else if ([buttonName isEqualToString:@"webview_reload_ic"]){
        buttonType = CoustomWebMenuViewReloadType;
        NSLog(@"刷新");
    }else if ([buttonName isEqualToString:@"webview_back_ic"]){
        buttonType = CoustomWebMenuViewBackType;
        NSLog(@"返回");
    }else if ([buttonName isEqualToString:@"webview_menu_pay_ic"]){
        buttonType = CoustomWebMenuViewPay;
    }
    // 消失视图
    [self dismissTheMenuView];
    
    // 代理传送
    if ([self.delegate respondsToSelector:@selector(clickMeunButtonType:)]) {
        [self.delegate clickMeunButtonType:buttonType];
    }
}

// 按钮类型 0.默认的返回  1.充值
-(void)changeButtonIcon:(NSInteger)buttonType{
    UIButton * changeButtonStyle;
    if (self.buttonArray.count>0) {
        changeButtonStyle = self.buttonArray[2];
    }
    self.buttonType = buttonType;
    if (buttonType == 0) {
        // 默认
        [changeButtonStyle setImage:[UIImage imageNamed:@"webview_back_ic"] forState:UIControlStateNormal];
    }else{
        // 充值
        [changeButtonStyle setImage:[UIImage imageNamed:@"webview_menu_pay_ic"] forState:UIControlStateNormal];
    }
}


-(void)clickSelf{
    [self dismissTheMenuView];
    
    // 代理传送
    if ([self.delegate respondsToSelector:@selector(clickMeunButtonType:)]) {
        [self.delegate clickMeunButtonType:CoustomWebMenuViewSelfHiddenType];
    }
}

-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc]init];
    }
    return _buttonArray;
}
@end
