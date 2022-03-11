//
//  AppLinkDomainModel.h
//  KK
//
//  Created by hk on 2021/8/31.
//

#import <Foundation/Foundation.h>
#import "AppLinkDomainConfig.h"
#import "DoMainUrlItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppLinkDomainModel : NSObject


/// 构造model
/// @param urlList url list
/// @param index 选择的下标
+(AppLinkDomainModel*)initWithDomainMessage:(NSMutableArray*)urlList:(int)index: (AppLinkDomainType)linkType;

/// uc域名列表
@property (nonatomic,strong) NSMutableArray* urlList;


/// api域名列表
@property (nonatomic,assign) int index;


/// 检测域名是否可用
/// @param complete 回调
-(void)check:(OnBoolComplete)complete;


/// 获取当前ok的域名
-(NSString*)getUrl;


@end

NS_ASSUME_NONNULL_END
