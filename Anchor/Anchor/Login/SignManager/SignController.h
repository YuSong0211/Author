//
//  SignController.h
//  KK
//
//  Created by hk on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface SignController : NSObject
    


//登陆成功信号
@property (strong,nonatomic) RACSubject* loginSignilCallBack;

    
//app 启动登录流程
-(void)sign;


//切换账号
-(void)telephoneLogin:(long)sms_id
             sms_code:(NSString*)sms_code
               region:(NSString*)region
            telephone:(NSString*)telephone
                 uuid:(NSString*)uuid;
+(void)loginApiLogin;

@end

NS_ASSUME_NONNULL_END
