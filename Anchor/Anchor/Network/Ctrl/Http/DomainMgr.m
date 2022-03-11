//
//  DomainMgr.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "DomainMgr.h"
static DomainMgr* instance = NULL;

 
@interface DomainMgr()
@property (assign,nonatomic) BUILD_TYPE buildType;
@end
      
@implementation DomainMgr
//单例
+ (DomainMgr *)getDomainInstance{
    
    if(instance==NULL){
        instance = [[DomainMgr alloc] init];
    }
    return instance;
}

//初始化配置
-(void)initConfig{
    
    self.buildType =KK_Dalao ;
    
    self.domainList = [[NSMutableArray alloc] init];
    if(self.buildType == KK_DEV){ //正式服环境

    }else if(self.buildType ==KK_DEV_TEST){ //外网测试服
      
    }else if(self.buildType == KK_DEBUG){  //内网

    }else if(self.buildType == KK_Dalao){  //内网
      
//        [self addConfig:Uc :ucList];
//        [self addConfig:Api :apiList];
//        [self addConfig:NetCore :netCore];
    }
    //to init uc...
}


-(void)addConfig:(DomainType)type :(NSArray*) urlList{
    DomainConfig *config = [DomainConfig initWithUrlList:type :urlList];
    [self.domainList addObject:config];
}

//根据类型获取数据
-(DomainConfig*)findConfigWithType:(DomainType)domainType{
    for (DomainConfig* domain in self.domainList) {
        if(domain.domainType == domainType){
            return domain;
        }
    }
    return nil;
}


//通过接口获取域名
- (NSString *)getDomain:(NSString *)packageName:(BOOL)useNetCore{
    if(useNetCore){
        return [[self findConfigWithType:NetCore] getDomain];
    }
    DomainType domainType = Uc;
    if([packageName isEqualToString:@"applink"]){
        domainType = DomainAppLinks;
    }
    else if([packageName isEqualToString:@"appvapi"]){
        domainType = Api;
    }
    DomainConfig* config = [self findConfigWithType:domainType];
    if(config==nil){
        return @"";
    }
    return [config getDomain];
}

@end
