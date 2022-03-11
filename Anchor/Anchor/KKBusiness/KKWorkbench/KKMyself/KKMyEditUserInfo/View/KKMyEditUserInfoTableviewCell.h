//
//  KKMyEditUserInfoTableviewCell.h
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import <UIKit/UIKit.h>
#import "appvUser.pbobjc.h"// 用户信息类
#import "appvBasic.pbobjc.h"// 用户信息内容类
NS_ASSUME_NONNULL_BEGIN

@interface KKMyEditUserInfoTableviewCell : UITableViewCell

@property (nonatomic,strong) NSString * titleName;

@property (nonatomic,strong) NSString * genderName;// 性别

@property (nonatomic,assign) NSInteger cellIndex;
// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;
@property (nonatomic,copy)NSString *nikeName;// 昵称
@property (nonatomic,copy)NSString *phone;// 手机号
@end

NS_ASSUME_NONNULL_END
