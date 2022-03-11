//
//  HeadPools.m
//  KK
//
//  Created by hk on 2021/8/3.
//

#import "HeadPools.h"


static HeadPools* instance = NULL;

@interface HeadPools()
    


@end



@implementation HeadPools
    
//单例存在。
+ (HeadPools *)getHeadPool{
    if(instance == NULL){
        instance = [[HeadPools alloc] init];
    }
    return instance;
}

//初始化方法
- (instancetype)init
{
    self = [super init];
    NSLog(@"==============%@",[KKUserInfo share].ucToken);
    self.xTokenHead = [[HeadItem alloc] initWithDataKey:@"x-token" value:[KKUserInfo share].ucToken type:xToken];
    self.xUcChannelKeyHead = [[HeadItem alloc] initWithDataKey:@"x-uc-channel-key" value:@"ios1001" type:xUcChannel];
    self.netCoreHead = [[HeadItem alloc] initWithDataKey:@"x-netcore_test" value:[KKUserInfo share].uid type:xNetCore];
    self.contentType = [[HeadItem alloc] initWithDataKey:@"Content-Type" value:@"application/x-protobuf" type:ContentType];
    self.apiHead = [[HeadItem alloc] initWithDataKey:@"x-token" value:[KKUserInfo share].apiToken type:ApiToken];
    self.appvlink = [[HeadItem alloc]initWithDataKey:@"x-applink-app-key" value:@"appv" type:Applink];
    return self;
}


//修改值实现
- (void)updateHeadVal:(HeadType)type :(NSString *)val{
    switch (type) {
        case xToken:
            self.xTokenHead.value = val;
            break;
            
        case xUcChannel:
            self.xUcChannelKeyHead.value = val;
            break;
            
        case xNetCore:
            self.netCoreHead.value = val;
            break;
            
        case ApiToken:
            self.apiHead.value = val;
            break;
            
        case ContentType:
            self.contentType.value = val;
            break;
    }
}

//获取head type
- (HeadItem *)getHeadByType:(HeadType)type{
    switch (type) {
        case xToken:
            return self.xTokenHead;
        case xUcChannel:
            return self.xUcChannelKeyHead;
        case xNetCore:
            return self.netCoreHead;
        case ContentType:
            return self.contentType;
        case ApiToken:
            return self.apiHead;
    }
    return NULL;
}

//获取所有head
- (NSMutableArray<HeadItem *> *)getHeadList:(NSMutableArray *)types{
    NSMutableArray<HeadItem*>* array = [[NSMutableArray alloc] init];
    for(int i=0;i<types.count;i++){
        HeadType type = types[i];
        HeadItem *item = [self getHeadByType:type];
        if(item!=NULL){
            [array addObject:item];
        }
    }
    return array;
}

//填充网络层需要的head。主核心代码
- (NSMutableURLRequest *)setNetWillSendHead:(NSMutableURLRequest *)request :(NSString *)packageName:(BOOL)useToken{
    [request setValue:self.contentType.value forHTTPHeaderField:self.contentType.key];
    //[request setValue:self.xUcChannelKeyHead.value forHTTPHeaderField:self.xUcChannelKeyHead.key];
    [request setValue:self.netCoreHead.value forHTTPHeaderField:self.netCoreHead.key];
//    [request setValue:self.appvlink.value forHTTPHeaderField:self.appvlink.key];
    if(useToken){
        if([packageName isEqualToString:@"serviceuc"]){
            [request setValue:self.xTokenHead.value forHTTPHeaderField:self.xTokenHead.key];
        }
        else{
            [request setValue:self.apiHead.value forHTTPHeaderField:self.apiHead.key];
        }
    }
   
    if([packageName isEqualToString:@"serviceuc"]){
//        [request setValue:@"uc-appv-dev" forHTTPHeaderField:self.xUcChannelKeyHead.key];
        [request setValue:self.xUcChannelKeyHead.value forHTTPHeaderField:self.xUcChannelKeyHead.key];
    }
    else if([packageName isEqualToString:@"appvapi"]){
//        [request setValue:@"applink-appv-dev" forHTTPHeaderField:self.apiHead.key];
    }
    else if([packageName isEqualToString:@"servicechat"]){
        [request setValue:self.xTokenHead.value forHTTPHeaderField:self.xTokenHead.key];
        [request setValue:@"chat-appv" forHTTPHeaderField:@"x-chat-app-key"];
    }
    else if([packageName isEqualToString:@"serviceapplink"]){
        [request setValue:self.xTokenHead.value forHTTPHeaderField:self.xTokenHead.key];
        [request setValue:@"applink-appv-dev" forHTTPHeaderField:self.appvlink.key];
    }
    else {
        
    }
    
    if ([KKUserInfo share].uid) {
        [request setValue:[KKUserInfo share].uid forHTTPHeaderField:@"X_MOMENTS_TOKEN"];
    }
    NSDictionary* req_heads = request.allHTTPHeaderFields;
    NSLog(@"请求head===>%@\n---------",req_heads);
    return request;
}
//x-app-key=uc-appv-dev
@end
