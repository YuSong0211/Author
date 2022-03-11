//
//  KKMyEditUserInfoViewModel.m
//  KK
//
//  Created by ProgramMa on 2021/8/5.
//

#import "KKMyEditUserInfoViewModel.h"

#import "KKEditUserInfoModel.h"
@implementation KKMyEditUserInfoViewModel
/**
 ////// 修改用户信息
 @param nickname 昵称
 @param gender 用户性别
 @param intro 简介
 */
+ (void)apiUpdataUserInfo:(NSString * _Nullable)nickname
                   gender:(appvapiGenders )gender
                    intro:(NSString * _Nullable)intro {
    [KKEditUserInfoModel  changeUserInfo:nickname gender:gender intro:intro completion:^(BOOL completion) {
        if (completion) {
            if (nickname) {
                [[KKUserInfo share] setNickname:nickname];
            }
            if (gender) {
                [[KKUserInfo share] setGender:gender];
            }
            if (intro) {
                [[KKUserInfo share] setIntro:intro];
            }           
            [KKUserInfo userInforChange];
        }
    }];
}

-(RACSubject*)updateUserAvterSuccess{
    if(_updateUserAvterSuccess == nil){
        _updateUserAvterSuccess = [RACSubject subject];
    }
    return _updateUserAvterSuccess;
}


@end
