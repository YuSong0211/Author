//
//  HeadsConfig.m
//  KK
//
//  Created by hk on 2021/6/23.
//

#import "HeadsConfig.h"

@implementation HeadsConfig

-(HeadsConfig*)initWithDataKey:(NSString*)key value:(NSString*)value{
    self.key = key;
    self.value = value;
    return self;
}
+(NSMutableArray *)getReuqestHeadeUcToken {
    HeadsConfig *config = [[HeadsConfig alloc] initWithDataKey:@"x-uc-channel-key" value:@"voyage-dev"];
    HeadsConfig *config1 = [[HeadsConfig alloc] initWithDataKey:@"x-token" value:[KKUserInfo share].ucToken];
    HeadsConfig *config2 = [[HeadsConfig alloc] initWithDataKey:@"x-netcore_test" value:[KKUserInfo share].uid];
    NSMutableArray *configList = [NSMutableArray arrayWithObjects:config,config1,config2, nil];
    return configList;
}
+(NSMutableArray *)getReuqestHeadeApiToken {

    HeadsConfig *config = [[HeadsConfig alloc] initWithDataKey:@"x-netcore_test" value:[KKUserInfo share].uid];
    HeadsConfig *config1 = [[HeadsConfig alloc] initWithDataKey:@"x-token" value:[KKUserInfo share].apiToken];
    NSMutableArray *configList = [NSMutableArray arrayWithObjects:config1,config, nil];
    return configList;
}
@end
