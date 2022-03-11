//
//  KKMyEditUserInfoListView.h
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import <UIKit/UIKit.h>
#import "appvUser.pbobjc.h"// 用户信息类
#import "appvBasic.pbobjc.h"// 用户信息内容类
NS_ASSUME_NONNULL_BEGIN

@interface KKMyEditUserInfoListView : UIView
// 编辑资料列表
@property (nonatomic,strong) UITableView * tableview;
// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;
@property (nonatomic,copy)NSString *nikeName;// 昵称
@property (nonatomic,strong)UIImage *selectImage;// 头像
@property (nonatomic,copy)NSString *phone;// 手机号
@property (nonatomic,copy)void (^UpdataBingPhoneBlock) (void);// 修改手机号
@property (nonatomic,copy)void (^editUserInfoNikeNameBlock)(void);// 编辑昵称
@property (nonatomic,copy)void (^SelectGenderBlock) (appvapiGenders isMan);// 选择性别
@property (nonatomic,copy)void (^textViewTextDidChangeNotificationBlock)(NSString *content);// 简介
@property (nonatomic,copy)void (^textViewTextDidEndNotificationBlock)(NSString *content);// 简介
@property (nonatomic,copy)void (^updataAvterBlock)(UIImage *selectImage);// 修改头像
@end

NS_ASSUME_NONNULL_END
