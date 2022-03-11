//
//  BaseVideoListViewModel.h
//  KK
//
//  Created by hk on 2021/8/4.
//

//####
//所有视频列表，需要和二级播放器交互的，均需要继承此类
#import <Foundation/Foundation.h>
#import "AvModel.h"
#import "LevelVideoDriverCtrl.h"
#import "BaseViewModel.h"
NS_ASSUME_NONNULL_BEGIN


typedef void (^onComplete)(id message);

typedef enum {
    refehScene=1,  //刷新UI界面
    addItem =2,     //添加元素
    addItems = 3,   //添加列表元素
    location = 4,   //定位到某个下标
    removeItem = 5, //移除某个元素
    loadMore = 6,   //加载更多回调
    requestError = 7, //请求失败
    
}videoEventType;

//监听回调
@protocol BaseVideoListViewModelDelegate <NSObject>

@optional
     
/**
 /// 回调给对应的控制器
 @param eventType 回调操作类型
 @param dataSource 回调的数据列表
 */
-(void)didReceiveEvent:(videoEventType)eventType
            dataSource:(id)dataSource;

@end


/**
 ///  vm实现功能
 */

@interface BaseVideoListViewModel : BaseViewModel
/*
 请求类型
 **/
@property(nonatomic,copy)NSString *requestType;

/**
 /// 存放当前视频列表
 */
@property (nonatomic,strong) NSMutableArray<AvModel*>* videoList;


/**
 ///  回调通知
 */
@property (weak,nonatomic) id<BaseVideoListViewModelDelegate> delegate;


/**
 ///  二级页面中控
 */
@property(strong,nonatomic) LevelVideoCtrl* levelVideoCtrl;

/**
 ///  请求播放视频的下标
 */
@property (nonatomic,assign) NSInteger startIndex;

/**
 /// 获取最后一个视频的ID
 */
- (NSString*)getLastId;

/**
 /// 加载更多视频, 二级播放器使用接口
 @param lastId 最后一个视频的id
 */
- (void)getLevelMoreVideo:(NSString*)lastId;

/**
 /// 下拉刷新
 */
- (void)refreshVideo;

/**
 /// 刷新列表
 */
- (void)requestWithIsRefresh:(BOOL)isRefresh withLastId:(nullable NSString *)lastId;


/**
 /// 请求失败
 */
- (void)requestError;


/**
 /// 刷新二级界面
 @param vList 刷新的列表
 */
-(void)refehLevelVideo:(NSMutableArray<AvModel*>*)vList;


/**
 /// 启动二级播放器，
 @param startIndex  从哪个视频启动
 */
-(void)startLevelVideo:(NSInteger)startIndex;


/**
 /// 追加的视频列表，
 @param vList  追加的视频列表
 @param type  刷新内容
 */
-(void)appendVideoList:(NSMutableArray<AvModel*>*)vList
                      :(videoEventType)type;


/// 通用追加数据
/// @param vList 追加数据内容
/// @param type 刷新内容
- (void)appendList:(NSMutableArray *)vList type:(videoEventType)type;

/**
 /// 首次,刷新视频列表, 此方法为当前视频列表使用
 @param lastId  从哪个视频启动
 */
-(void)requestVideoList:(NSString*)lastId
                       :(nullable onComplete)complete;



/**
 ///  获取启动时传给二级播放页的下标
 */
-(NSInteger)getCurrentPlayIndex;


/**
 ///  二级界面回调，添加某个物体
 @param param  添加的对象
 @param playIndex  播放的下标
 */
- (void)addItem:(id)param
               :(NSInteger)playIndex;

/**
 ///  二级界面回调，删除某个物体
 @param param  删除的对象
 @param playIndex  播放的下标
 */
- (void)removeItem:(id)param
                  :(NSInteger)playIndex;

///删除某个元素 (收藏)
-(void)collection_removeItem:(id)param
        playIndex:(NSInteger)playIndex;

///在某个位置添加某个元素 (收藏)
-(void)collection_addItem:(id)param
                playIndex:(NSInteger)playIndex;

/**
 ///  二级返回事件
 @param playIndex  播放的下标
 */
- (void)finish:(NSInteger)playIndex;


/**
 ///  回调控制器
 @param type  回调类型
 @param dataSource   回调数据源
 */
-(void)setFunEvent:(videoEventType)type
                  :(id)dataSource;



/**
 /// 存放最多观看视频列表
 */
@property (nonatomic,strong) NSMutableArray<AvModel*>* videoPlayList;

/**
 /// 存放最多点赞视频列表
 */
@property (nonatomic,strong) NSMutableArray<AvModel*>* videoLikeList;

/**
 /// 存放最多收藏视频列表
 */
@property (nonatomic,strong) NSMutableArray<AvModel*>* videoCollectionList;

/**
 /// 存放最新视频列表
 */
@property (nonatomic,strong) NSMutableArray<AvModel*>* videoNewestList;

@property (nonatomic,strong)NSMutableArray *feedArr;

@property(nonatomic,strong)NSMutableArray *userListArray;


/**
 /// 追加的短视频视频列表，
 @param vList  追加的视频列表
 @param type  刷新内容
 */
-(void)appendVideoList:(NSMutableArray<AvModel*>*)vList
                      :(videoEventType)type withPlayType:(NSInteger)rankType;



/**
 /// 存放专题精选视频列表
 */
@property (nonatomic,strong) NSMutableArray<AvModel*>* videoChooseList;

@end



NS_ASSUME_NONNULL_END
