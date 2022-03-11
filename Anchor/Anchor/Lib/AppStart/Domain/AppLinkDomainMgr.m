//
//  AppLinkDomainMgr.m
//  KK
//
//  Created by hk on 2021/8/31.
//
#define MrHuan @"http://192.168.31.195:9000/c2c/"


#import "AppLinkDomainMgr.h"

@interface AppLinkDomainMgr()

@property(nonatomic,assign)OnBoolComplete complete;

@property(nonatomic,strong)AppLinkDomainConfig* appLinkDomainConfig;

@end

@implementation AppLinkDomainMgr

+ (AppLinkDomainMgr *)shareMgr{
    
    static dispatch_once_t once;
    static AppLinkDomainMgr *manager;
    dispatch_once(&once, ^{
        manager = [AppLinkDomainMgr new];
    });
    return manager;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.appLinkDomainConfig = [[AppLinkDomainConfig alloc] init];
    }
    return self;
}



/// 读取并解析本地数据
-(void)runInit{
//    NSString* data = [self.appLinkDomainConfig start];
//    self.appLinkDomainItem =[AppLinkDomainItem yy_modelWithDictionary:[KKTool dictionaryWithJsonString:data]];
}


/// 检测域名
/// @param domainType 域名类型
/// @param complete 检测回调
-(void)checkItem:(OC_DomainType)domainType complete:(OnBoolComplete)complete{
    self.complete = complete;
  
    [richers checkItem:(OC_DomainType)domainType callback:^(bool ok) {
//        dispatch_async(dispatch_get_main_queue(), ^{
            if(ok){
                //to set and refeh data.
//                [self.appLinkDomainItem setItemUseByType:domainType index:model.index];
//                [self refehCache];
                complete(YES);
            }
            else{
              
                NSString *str = @"无网络连接!,请检查网络是否连接";
                if([[NetWrokStatesCtrl getInstance] networkIsAvailable]){
                    str = @"所有服务器域名均不可访问";
                }
//                [KKHub showMtTostWithTitle:@"提示" WithText:str WithBtnText:@"重试" WithClickBlock:^(NSInteger index) {
//                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                [self checkItem:domainType complete:complete];
//                    });
//                }];
//                todo:此处需要弹窗，网络错误提示，用户点击确定后调用,注意，确认之后调用即可!
                KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"重试" buttonEnable:YES];
                KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:str] setViewEnable:NO];
                [controller.itemConfigArray  addObject:item];
                [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
                    [self checkItem:domainType complete:complete];
                }];
//                complete(YES);
            }
//        });
    }];
//    AppLinkDomainModel* model = [self.appLinkDomainItem getItemByDomainModelByType:domainType];
//    [model check:^(BOOL isOk) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(isOk){
//                //to set and refeh data.
//                [self.appLinkDomainItem setItemUseByType:domainType index:model.index];
//                [self refehCache];
//                complete(YES);
//            }
//            else{
//                NSString *str = @"无网络连接!,请检查网络是否连接";
//                if([[NetWrokStatesCtrl getInstance] networkIsAvailable]){
//                    str = @"所有服务器域名均不可访问";
//                }
////                [KKHub showMtTostWithTitle:@"提示" WithText:str WithBtnText:@"重试" WithClickBlock:^(NSInteger index) {
////                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                                [self checkItem:domainType complete:complete];
////                    });
////                }];
////                todo:此处需要弹窗，网络错误提示，用户点击确定后调用,注意，确认之后调用即可!
//                KKAltItemConfig* item = [KKAltItemConfig initWithItemConfig:@"重试" buttonEnable:YES];
//                KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"提示" content:str] setViewEnable:NO];
//                [controller.itemConfigArray  addObject:item];
//                [KKAltView showAltViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
//                    [self checkItem:domainType complete:complete];
//                }];
////                complete(YES);
//            }
//        });
//    }];
}

///更新本地缓存
-(void)refehCache{

}


/// 根据域名获取数据
/// @param domainType 域名类型
//-(AppLinkDomainModel*)getDomainModelByType:(AppLinkDomainType)domainType{
//    return  [self.appLinkDomainItem getItemByDomainModelByType:domainType];
//}



/// 根据请求类型获取对应请求地址
/// @param domainType 域名类型
-(NSString*)getUrlByRequestType:(OC_DomainType)domainType{
    return [richers getCanUseUrl:domainType]; 
//    AppLinkDomainModel* model = [self.appLinkDomainItem getItemByDomainModelByType:domainType];
//    return [model getUrl];
}


/// 根据包名，获取请求地址
/// @param packageName 包名
-(OC_DomainType)getUrlByPackageName:(NSString*)packageName{
    
    OC_DomainType domainType = Ocdomain_update;
    if([packageName isEqualToString:@"serviceuc"]){
        return  Ocdomain_uc;
    }
    else if([packageName isEqualToString:@"appvapi"]){
        return  Ocdomain_api;
    }
    
    else if([packageName isEqualToString:@"serviceapplink"]){
      
        return  Ocdomain_update;
    }
    else if([packageName isEqualToString:@"servicechat"]){
        return Ocdomain_im;
    }
    else if([packageName isEqualToString:@"apimoments"]){
        return Ocdomain_moments;
    }
    return domainType;
}
 
@end
