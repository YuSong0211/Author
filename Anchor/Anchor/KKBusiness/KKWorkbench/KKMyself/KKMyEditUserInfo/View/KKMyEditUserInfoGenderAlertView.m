//
//  KKMyEditUserInfoGenderAlertView.m
//  KK
//
//  Created by ProgramMa on 2021/7/16.
//

#import "KKMyEditUserInfoGenderAlertView.h"
#define bottomHeight 227
@interface KKMyEditUserInfoGenderAlertView ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic , strong) UITapGestureRecognizer *selfTap;
@end
@implementation KKMyEditUserInfoGenderAlertView
-(instancetype)init{
   if (self = [super initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT)]) {
       [self showInView];
   }
   return self;
}
- (void)showInView {
    self.tag = 545;
    [self addGestureRecognizer:self.selfTap];
    self.backgroundColor = KKRGBA(0, 0, 0, 0.64);
    [KK_GET_WINDOWS addSubview:self];
    [self addSubview:self.bottomView];
    [self setTingFrame];
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(0);
//        make.height.mas_equalTo(2);
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(self.keepView.mas_top).offset(0);
//    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
   if ([touch.view isDescendantOfView:self] && touch.view.tag == 545) {
       return YES;
   }
   return NO;
}
- (void)didsTap {
    [self dissmisView];
}
- (void)setTingFrame {
    self.bottomView.frame = CGRectMake(0, KK_SCREEN_HEIGHT, KK_SCREEN_WIDTH, bottomHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self.bottomView setFrame:CGRectMake(0, KK_SCREEN_HEIGHT - bottomHeight, KK_SCREEN_WIDTH, bottomHeight)];
    } completion:nil];
}

- (void)dissmisView {
    [UIView animateWithDuration:0.3f
                     animations:^{
         [self.bottomView setFrame:CGRectMake(0, KK_SCREEN_HEIGHT + bottomHeight, KK_SCREEN_WIDTH, bottomHeight)];
        self.alpha = 0.0;
     }
     completion:^(BOOL finished){
        [self removeFromSuperview];
     }];
}
- (UITapGestureRecognizer *)selfTap{
    if (!_selfTap) {
        _selfTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didsTap)];
        _selfTap.delegate = self;
    }
    return _selfTap;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = KKRGBA(37, 39, 47, 1);
    }
    return _bottomView;
}

@end
