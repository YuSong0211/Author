//
//  NaviagtionBarCtrl.m
//  KK
//
//  Created by hk on 2021/6/24.
//

#import "NaviagtionBarCtrl.h"

@implementation NaviagtionBarCtrl
    
- (NaviagtionBarCtrl *)initBar:(NSString *)title :(NSString *)submit :(BarEvent)barEvent{
    self.barEve = barEvent;
    [self settv_title:title];
    [self set_backbtn];
    [self set_submit:submit];
    return self;
}

-(void)settv_title :(NSString*)title{
    CGFloat view_height = self.view.frame.size.height;
    UILabel *tv_title = [[UILabel alloc] initWithFrame:CGRectMake(0, (view_height-16)/2, KK_SCREEN_WIDTH, 16)];
    tv_title.textAlignment = NSTextAlignmentCenter;
    tv_title.font = [UIFont systemFontOfSize:16];
    tv_title.textColor = [KKColor getColor:appMainTextColor];
    tv_title.text = title;
    [self.view addSubview:tv_title];
}

//设置推出按钮
-(void)set_backbtn{
    CGFloat view_height = self.view.frame.size.height;
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(5, 0, 24.0, view_height)];
    [button1 addTarget:self action:@selector(onBackbtn) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [self.view addSubview:button1];
}

- (void)setSubmitTitle:(NSString *)submit{
    if(self.btn_sumbit == nil) {
        [self set_submit:submit];
        return;
    }
    [self.btn_sumbit setTitle:submit forState:UIControlStateNormal];
}

//设置右侧区域
-(void)set_submit:(NSString*)submit_title{
    
    CGFloat view_height = self.view.frame.size.height;
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(KK_SCREEN_WIDTH-110, 0, 100, view_height)];
    [button1 addTarget:self action:@selector(onSubmitbtn) forControlEvents:UIControlEventTouchUpInside];
  //  [button1 setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [button1 setTitle:submit_title forState:UIControlStateNormal];
    [button1 setTitleColor:[KKColor getColor:appMainTextColor] forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:16]];
    button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.btn_sumbit = button1;
    [self.view addSubview:button1];
}

-(void)onSubmitbtn{
    self.barEve(navSubmit);
}

-(void)onBackbtn{
    self.barEve(navFinish);
}

- (void)createBar{
    
    
    
}

-(UIView*)view{
    if(_view==NULL){
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, 44)];
    }
    return _view;
}


    

@end
