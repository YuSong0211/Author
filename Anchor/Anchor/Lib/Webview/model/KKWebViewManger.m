//
//  KKWebViewManger.m
//  mt
//
//  Created by 小草 on 2021/10/19.
//

#import "KKWebViewManger.h"

static KKWebViewManger *manager;
@implementation KKWebViewManger


// 创建单例
+(KKWebViewManger *)sharManger{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[KKWebViewManger alloc]init];
    });
    return manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    
    return manager;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone{
    return manager;
}


-(void)deallocBlock{
    self.payResult = nil;
    self.callPay = nil;
}
@end
