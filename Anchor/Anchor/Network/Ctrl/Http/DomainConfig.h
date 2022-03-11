//
//  DomainConfig.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    
    Uc = 1,
    Api = 2,
    NetCore = 3,
    DomainAppLinks =  4
    
}DomainType;
@interface DomainConfig : NSObject
     

//设置域名
+(DomainConfig*)initWithUrlList:(DomainType)domainType :(NSArray<NSString*>*)list;

//域名列表
@property (nonatomic,strong) NSArray<NSString*>* urlList;

//域名类型
@property(nonatomic,assign)DomainType domainType;

//获取一个可用域名
-(NSString*) getDomain;

@end

NS_ASSUME_NONNULL_END
