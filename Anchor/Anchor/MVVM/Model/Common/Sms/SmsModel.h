//
//  SmsModel.h
//  KK
//
//  Created by hk on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "NetWorkMgr.h"
NS_ASSUME_NONNULL_BEGIN

@interface SmsModel : NSObject

//准备ID
@property(nonatomic,assign) NSInteger reCaptchaId;

//手机号码
@property(nonatomic,strong) NSString* phoneNum;

//短信id
@property(nonatomic,assign) NSInteger smsId;

- (void)reqGetBindSmsCode:(NSString*)phoneNum
                      :(onRequestSuccess)success
                         :(onRequestFail)fail;


//请求获取切换账户验证码
-(void)reqGetChangeAccontCode:(NSString*)phoneNum
                             :(onRequestSuccess)success
                             :(onRequestFail)fail;

@end

NS_ASSUME_NONNULL_END
