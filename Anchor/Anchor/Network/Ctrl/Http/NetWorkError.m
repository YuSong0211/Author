//
//  NetWorkError.m
//  KK
//
//  Created by hk on 2021/8/5.
//

#import "NetWorkError.h"

static NetWorkError* instance;


@interface NetWorkError()

@property (strong,nonatomic) NSArray* errorCodeArray;

@end

@implementation NetWorkError


- (instancetype)init
{
    self = [super init];
    if (self) {
         self.errorCodeArray = @[@"成功"
                                ,@"账号被封禁"
                                ,@"云之讯短信发送失败"
                                ,@"图片验证码state校验错误"
                                ,@"短信发送太频繁"
                                ,@"短信验证码校验失败"
                                ,@"短信验证码信息未找到"
                                ,@"手机号格式不正确"
                                ,@"手机号被他人绑定"
                                ,@"改手机号为绑定账号"
                                ,@"手机号未注册不能登陆"
                                ,@"DeviceUuid格式错误"
                                ,@"自定义图片验证码校验错误"];
    }
    return self;
}

    
+ (NetWorkError *)getInstance{
    if(instance == NULL){
        instance = [[NetWorkError alloc] init];
    }
    return instance;
}

- (NSString*)getCode:(int)errorCode{
    if(errorCode>=self.errorCodeArray.count){
        return @"未知错误!";
    }
    return self.errorCodeArray[errorCode];
}

@end
