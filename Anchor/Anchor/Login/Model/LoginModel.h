//
//  LoginModel.h
//  KK
//
//  Created by 小草 on 2021/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    
    BindPhone = 1, //绑定手机号
    ChangePhone = 2, //切换绑定手机
    ChangeAccont = 3, //切换账户
    
}LoginType;

@interface LoginModel : NSObject

@end

NS_ASSUME_NONNULL_END
