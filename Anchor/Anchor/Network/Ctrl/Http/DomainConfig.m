//
//  DomainConfig.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "DomainConfig.h"

@implementation DomainConfig


//初始化with 域名
+ (DomainConfig *)initWithUrlList:(DomainType)domainType :(NSArray<NSString *> *)list{
    DomainConfig* domain = [[DomainConfig alloc] init];
    domain.urlList = list;
    domain.domainType = domainType;
    return domain;
}

//暂时只获取一个域名
- (NSString *)getDomain{
    
    if(self.urlList.count>0){
        return self.urlList[0];
    }
    return @"";
}

@end
