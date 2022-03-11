//
//  AvModel.h
//  KK
//
//  Created by hk on 2021/8/4.
//视频播放器基类

#import <Foundation/Foundation.h>
#import "AppvPrimaryApiContent.pbobjc.h"
#import "AppvPrimaryBasic.pbobjc.h"
#import "appvBasic.pbobjc.h"
#import "appvPrimaryApiContent.pbobjc.h"
#import "appvPrimaryApiSocial.pbobjc.h"
#import "AppvPrimaryApiSearch.pbobjc.h"
#import "ApplinkPrimaryAdvertisement.pbobjc.h"
NS_ASSUME_NONNULL_BEGIN

@interface AvModel : NSObject
    
//构造
+(AvModel*)initWithVideoMessage:(appvapiContentSvideo*)video;

/**
 /// 视频信息
 */
@property(strong,nonatomic) appvapiContentSvideo *video;


/**
 /// 点赞信息
 */
@property(strong,nonatomic) appvapiContentAudit *audit;

/**
 /// lastId
 */
@property(copy,nonatomic) NSString *lastId;

@property(assign,nonatomic) NSInteger  avCount;
@property (nonatomic, assign)BOOL isAD;
@property (nonatomic, assign)BOOL isCache;  
@property (nonatomic, strong)serviceapplinkAdvertisement *Advertisement;
@property (nonatomic, assign)CGFloat progress;
//将voyageapiMyContentSvideoAppendList 转换为avmodel
+(NSMutableArray<AvModel*>*)convertAvModel:(appvapiMyContentSvideoAppendList*)videoList;

+(NSMutableArray<AvModel *> *)convertAvModelwithSvideoList:(appvapiContentSvideoAppendList *)videoList;

//我的点赞
+(NSMutableArray<AvModel *> *)convertAvModelwithLikesShortVideoList:(appvapiLikesShortVideoListResponse * )videoList;

//我的收藏
+(NSMutableArray<AvModel *> *)convertAvModelwithCollectionShortVideoList:(appvapiFavoritesShortVideoListResponse * _Nonnull)videoList;

//最新
+(NSMutableArray<AvModel *> *)convertAvModelwithNewestShortVideoList:(appvapiContentSvideoAppendList * _Nonnull)videoList;
//关注视频列表
+(NSMutableArray<AvModel *> *)convertAvModelwithFollowedVideosResponse:(appvapiContentSvideoAppendList * _Nonnull)videoList;

+(NSMutableArray<AvModel *> *)convertAvModelwithChooseVideosResponse:(appvapiTopicFeed *)videoList;
///搜索
+(NSMutableArray<AvModel *> *)convertAvModelwithSearchSvideoList:(appvapiSearchSVideoByKeywordsResponse *)videoList;
@end

NS_ASSUME_NONNULL_END
