//
//  AppLinkDomainModel.m
//  KK
//
//  Created by hk on 2021/8/31.
//

#import "AppLinkDomainModel.h"

@interface AppLinkDomainModel()

@property(nonatomic,assign)BOOL isSuccess;
@property(nonatomic,strong)NSString* useUrl;
@property(nonatomic,assign)AppLinkDomainType linkType;
@end

@implementation AppLinkDomainModel

 
+ (AppLinkDomainModel *)initWithDomainMessage:(NSMutableArray *)urlList :(int)index :(AppLinkDomainType)linkType{
    AppLinkDomainModel* model  = [[AppLinkDomainModel alloc] init];
    model.urlList = urlList;
    model.index = index;
    model.linkType = linkType;
    model.useUrl = @"";
    return model;
}

/// 检测域名是否可用
/// @param complete 回调
-(void)check:(OnBoolComplete)complete{
    self.isSuccess = NO;
    //开启线程，检测正在处理的那个。
    dispatch_async ( dispatch_get_global_queue ( DISPATCH_QUEUE_PRIORITY_DEFAULT , 0 ), ^{
        BOOL isOk = [self start:self.urlList[self.index]];
        if (isOk) {
            complete(YES);
            NSLog(@"域名检测成功!==>%@",self.urlList[self.index]);
            return;
        }
        //创建线程组:
        dispatch_queue_t queye_t = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group_t = dispatch_group_create();
        for (int i=0;i<self.urlList.count;i++) {
            if (i!= self.index) {
                dispatch_group_async(group_t, queye_t, ^{
                    BOOL childOk = [self start:self.urlList[i]];
                    //如果检测成功!
                    if (childOk && !self.isSuccess) {
                        self.index = i;
                        self.isSuccess = YES;
                        complete(YES);
                        NSLog(@"域名检测成功!==>%@",self.urlList[self.index]);
                    }
                    else{
                        NSLog(@"域名检测失败!==>%@",self.urlList[self.index]);
                    }
                });
            }
        }
        //线程全部执行完毕通知
        dispatch_group_notify(group_t, queye_t, ^{
            NSLog(@"全部线程执行完毕!");
            if(!self.isSuccess){
                complete(NO);
            }
        });
            
    });
}
/// 获取当前ok的域名
-(NSString*)getUrl{
    
    if ([self.useUrl isEqualToString:@""]) {
        
        switch (self.linkType) {
            case DomainTypeUpdate:
                self.useUrl =self.urlList[self.index];
//                self.useUrl =[NSString stringWithFormat:@"http://%@/c2c/",self.urlList[self.index]];
                break;
                
            case DomainTypeUc:
                self.useUrl =[NSString stringWithFormat:@"http://%@/c2c/",self.urlList[self.index]];
            break;
                
            case DomainTypeApi:
                self.useUrl =[NSString stringWithFormat:@"http://%@/c2c/",self.urlList[self.index]];
            break;
                
            case DomainTypeIm:
                self.useUrl =[NSString stringWithFormat:@"http://%@/c2c/",self.urlList[self.index]];
            break;
            
            case DomainTypeShare:
                self.useUrl =[NSString stringWithFormat:@"%@",self.urlList[self.index]];
                return self.useUrl;
            break;
                
            default:
                break;
        }
    }
    self.useUrl =[NSString stringWithFormat:@"%@/c2c/",self.urlList[self.index]];
    return self.useUrl;
}
///// 获取当前ok的域名
//-(NSString*)getUrl{
//
//    if ([self.useUrl isEqualToString:@""]) {
//
//        switch (self.linkType) {
//            case DomainTypeUpdate:
//                self.useUrl =[NSString stringWithFormat:@"http://%@/dev-applink-api/c2c/",self.urlList[self.index]];
//                break;
//
//            case DomainTypeUc:
//                self.useUrl =[NSString stringWithFormat:@"http://%@/dev-uc-api/c2c/",self.urlList[self.index]];
//            break;
//
//            case DomainTypeApi:
//                self.useUrl =[NSString stringWithFormat:@"http://%@/dev-appv-api/c2c/",self.urlList[self.index]];
//            break;
//
//            case DomainTypeIm:
//                self.useUrl =[NSString stringWithFormat:@"http://%@/chat-appv-dev/c2c/",self.urlList[self.index]];
//            break;
//
//            default:
//                break;
//        }
//    }
//
//    return self.useUrl;
//}


/// ping 地址检测
/// @param urlString 传入的地址
-(BOOL)start:(NSString*)urlString{
    NSString* srcUrl = [NSString stringWithFormat:@"%@/",urlString];
    NSURL *url = [NSURL URLWithString:srcUrl];
    NSError* error;
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3.0f];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    return error == nil?(YES):NO;
}

@end
