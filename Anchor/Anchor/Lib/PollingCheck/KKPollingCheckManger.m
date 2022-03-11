//
//  KKPollingCheckManger.m
//  mt
//
//  Created by 小草 on 2021/9/23.
//

#import "KKPollingCheckManger.h"
static KKPollingCheckManger *manager;

@interface KKPollingCheckManger ()

@property (nonatomic,strong) NSTimer * timer;

@property (nonatomic,strong) NSMutableArray * resultArray;

@end

@implementation KKPollingCheckManger

// 创建单例
+(KKPollingCheckManger *)sharManger{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[KKPollingCheckManger alloc]init];
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

/// 开始轮询查询，间隔X秒执行一次，总共检查多少次
/// @param time 间隔时间
/// @param checkCount 检查次数
-(void)startPollingCheckTime:(CGFloat)time checkCount:(CGFloat)checkCount{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(pollingCheckCount) userInfo:nil repeats:YES];
    
    [self.timer  fire];
}

-(void)pollingCheckCount{
    
//    NSLog(@"开始轮询");
    // 暂停定时器
    //[self.timer setFireDate:[NSDate distantFuture]];
    
    // 开启线程
//    NSBlockOperation * blockOpertion = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i<self.commodityIdArray.count; i++) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSLog(@"开始轮询--%d",i);
//            });
//            serviceucPaymentApilookupPaymentLookupRequest * req = [serviceucPaymentApilookupPaymentLookupRequest createRequest];
//            req.request.prepayId.id_p = self.commodityIdArray[i];
//            NSMutableDictionary * headerResone = [[NSMutableDictionary alloc]init];
//            [headerResone setValue:self.commodityIdArray[i] forKey:@"x-reply-id"];
//            req.requestHeads = headerResone;
//            [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(serviceucPaymentLookupResponse * message) {
//                if (message.isSuccess == YES) {
//                    // 支付成功
//                    NSLog(@"支付成功");
//                }
//                [self resultCallBack:[req.resposeHeads objectForKey:@"x-reply-id"]];
//            } failed:^(requestErrorCode errorCode) {
//                [self resultCallBack:[req.resposeHeads objectForKey:@"x-reply-id"]];
//                NSLog(@"----  %u",errorCode);
//            }];
            
            
//        }
//    }];
//    // 开启线程
//    [blockOpertion start];
}

// 结果回调
-(void)resultCallBack:(NSString *)result{
    if (result) {
        // 将结果放入数组
        [self.resultArray addObject:result];
    }
    
    NSLog(@"------------  %@",self.resultArray);
    
    if (self.resultArray.count == self.commodityIdArray.count) {
        [self.resultArray removeAllObjects];
        // 再次开启定时器
        [self.timer setFireDate:[NSDate date]];
    }
}



// 初始化数组
-(NSMutableArray *)commodityIdArray{
    if (!_commodityIdArray) {
        _commodityIdArray = [[NSMutableArray alloc]init];
    }
    return _commodityIdArray;
}

-(NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}

@end
