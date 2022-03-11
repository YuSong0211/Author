//
//  NaviagtionBarCtrl.h
//  KK
//
//  Created by hk on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    navFinish = -1,
    navSubmit = 1
} navBarEvent;

//点击完成事件
typedef void (^BarEvent)(navBarEvent navEvent);

 

@interface NaviagtionBarCtrl : NSObject
        
@property (strong,nonatomic) UIView* view;

//default ---> 白色
//black。->黑色
-(NaviagtionBarCtrl*)initBar :(NSString*)title :(NSString*)submit :(BarEvent)barEvent;

-(void)createBar;

//设置提交内容
-(void)setSubmitTitle :(NSString*)submit;

//事件
@property (strong,nonatomic) BarEvent barEve;

//提交按钮
@property (strong,nonatomic) UIButton *btn_sumbit;

@end

NS_ASSUME_NONNULL_END
