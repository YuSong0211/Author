//
//  SingleTimer.h
//  mt
//
//  Created by 小鱼 on 2021/9/30.
//
#import <Foundation/Foundation.h>



typedef void (^TimeoutCallBack)(NSString *text);
typedef void (^TimeinCallBack)(void);

@interface SingleTimer : NSObject

@property (nonatomic,assign) NSInteger    timeRange;             //计时时间
@property (nonatomic,assign) NSInteger    timeRest;              //计时时间
@property (nonatomic ,copy)  TimeinCallBack       TimeinCall;  //在计时时调用
@property (nonatomic ,copy)  TimeoutCallBack      TimeoutCall; //在计时结束时调用
@property (nonatomic,strong) dispatch_source_t   timer;         //计时器

+ (id)sharedTimerManager;
- (void) startTimer;
- (void) pauseTimer;
- (void) resumeTimer;
- (void) stopTimer;

@end

