//
//  DomainMgr.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "DomainConfig.h"
NS_ASSUME_NONNULL_BEGIN


typedef enum {
    
    KK_DEV, //外网正式服
    KK_DEV_TEST,  //外网测试服
    KK_DEBUG,   //内网测试服
    KK_Dalao,   //内网测试服
    
}BUILD_TYPE;

//此类为域名管理器。主要操作域名相关数据请求
@interface DomainMgr : NSObject

+(DomainMgr*)getDomainInstance;

//初始化配置
-(void)initConfig;

//所有的域名列表
@property(strong,nonatomic) NSMutableArray<DomainConfig*>* domainList;

//通过package 接口，查找域名
-(NSString*) getDomain:(NSString*)packageName:(BOOL)useNetCore;

@end

NS_ASSUME_NONNULL_END
