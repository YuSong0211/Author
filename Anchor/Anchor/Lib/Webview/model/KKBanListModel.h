//
//  KKBanListModel.h
//  richers
//
//  Created by 小草 on 2021/12/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKBanListModel : NSObject

@property (nonatomic,strong) NSString * bankName; // 银行名称
@property (nonatomic,strong) NSString * secondChar; // 第二个字
@property (nonatomic,assign) NSInteger secondCharIndex; // 当前第二字的字母在26字母中的下标
@property (nonatomic,strong) NSString * pinyin;


@end

NS_ASSUME_NONNULL_END
