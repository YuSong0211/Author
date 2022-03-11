//
//  LevelVideoCtrl.h
//  KK
//
//  Created by hk on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "AvModel.h"
NS_ASSUME_NONNULL_BEGIN

//视频列表需要监听的回调
@protocol mVideoListDelegate <NSObject>

@optional

//获取更多视频列表
-(void)getLevelMoreVideo:(NSString *)lastId;

//关闭界面并显示播放下标
-(void)finish:(NSInteger)playIndex;

//删除某个元素
-(void)removeItem:(id)param
                 :(NSInteger)playIndex;

//在某个位置添加某个元素
-(void)addItem:(id)param
              :(NSInteger)playIndex;

///删除某个元素 (收藏)
-(void)collection_removeItem:(id)param
        playIndex:(NSInteger)playIndex;

///在某个位置添加某个元素 (收藏)
-(void)collection_addItem:(id)param
                playIndex:(NSInteger)playIndex;

@end


//二级界面需要监听回调
@protocol mVideoLevelDelegate <NSObject>

@optional

//接收到新的视频列表,只要处理这一个就好了。暂时不用处理别的请求。
-(void)onReveiveNewVideoListCompltte:(NSMutableArray<AvModel*>*) videoList;

@end




//视频控制器
@interface LevelVideoCtrl : NSObject

//创建
+(LevelVideoCtrl*)initWithLevelId:(NSInteger)levelId;

//实例id
@property(nonatomic,assign)NSInteger levelId;

//销毁一个实例
-(void)releaseVideo;

//启动的视频下标
-(void)startLevelVideo:(NSInteger)startIndex;

/**
 ///  视频列表回调通知
 */
@property (weak,nonatomic) id<mVideoListDelegate> videoListdelegate;


/**
 ///  二级播放页回调结果
 */
@property (weak,nonatomic) id<mVideoLevelDelegate> videoLeveldelegate;

@end

NS_ASSUME_NONNULL_END
