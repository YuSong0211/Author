//
//  AppLinkDomainConfig.h
//  KK
//
//  Created by hk on 2021/9/1.
//

#import <Foundation/Foundation.h>
#import "FileMgr.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppLinkDomainConfig : FileMgr

/// 读取域名配置文件
//-(NSString*)start;
    

///更新本地缓存
-(void)refehCache:(NSString*)content;
@end

NS_ASSUME_NONNULL_END
