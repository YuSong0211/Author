//
//  KKSelectBankListView.h
//  richers
//
//  Created by 小草 on 2021/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KKSelectBankName)(NSString *bankName);

@interface KKSelectBankListView : UIView

@property (nonatomic,strong) NSString * locationStr; // 定位字符串

@property (nonatomic,strong) NSMutableArray * banksArray; // 银行数据列表

@property (nonatomic,strong) NSDictionary * params;

@property (nonatomic,copy)KKSelectBankName bankBlock; // 银行名称

@end

NS_ASSUME_NONNULL_END
