//
//  AvModel.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "AvModel.h"

@implementation AvModel
    
//初始化视频信息
+ (AvModel *)initWithVideoMessage:(appvapiContentSvideo *)video{
    AvModel* model = [[AvModel alloc] init];
    model.video = video;
    return model;
}

//将返回的视频列表，转换为可用的信息
+(NSMutableArray<AvModel *> *)convertAvModel:(appvapiMyContentSvideoAppendList *)videoList{
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiMyContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item.basicInfo];
        av.audit = item.audit;
        av.lastId = item.basicInfo.svideoId.id_p;
        [newList addObject:av];
    }
    return newList;
}


+(NSMutableArray<AvModel *> *)convertAvModelwithSvideoList:(appvapiContentSvideoAppendList *)videoList{
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item];
        av.lastId = item.svideoId.id_p;
        [newList addObject:av];
    }
    return newList;
}

+(NSMutableArray<AvModel *> *)convertAvModelwithSearchSvideoList:(appvapiSearchSVideoByKeywordsResponse *)videoList{
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item];
        av.lastId = item.svideoId.id_p;
        [newList addObject:av];
    }
    return newList;
}

+(NSMutableArray<AvModel *> *)convertAvModelwithLikesShortVideoList:(appvapiLikesShortVideoListResponse * _Nonnull)videoList{
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiLikesContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item.video];
        av.lastId = item.likeId.id_p;
        [newList addObject:av];
    }
    return newList;
}

+(NSMutableArray<AvModel *> *)convertAvModelwithCollectionShortVideoList:(appvapiFavoritesShortVideoListResponse * _Nonnull)videoList{
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiFavoritesContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item.video];
        av.lastId = item.favoritesId.id_p;
        [newList addObject:av];
    }
    return newList;
}

//最新
+(NSMutableArray<AvModel *> *)convertAvModelwithNewestShortVideoList:(appvapiContentSvideoAppendList * _Nonnull)videoList{
    
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item];
        av.lastId = item.svideoId.id_p;
        [newList addObject:av];
    }
    return newList;
}
+(NSMutableArray<AvModel *> *)convertAvModelwithFollowedVideosResponse:(appvapiContentSvideoAppendList * _Nonnull)videoList{
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];

    for(appvapiContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item];
        av.avCount = videoList.videosArray_Count;
        av.lastId = item.svideoId.id_p;
        [newList addObject:av];
    }
    return newList;
}

+(NSMutableArray<AvModel *> *)convertAvModelwithChooseVideosResponse:(appvapiTopicFeed *)videoList{
    NSMutableArray<AvModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiContentSvideo* item in videoList.videosArray){
        AvModel* av = [AvModel initWithVideoMessage:item];
        av.avCount = videoList.videosArray_Count;
        av.lastId = item.svideoId.id_p;
        [newList addObject:av];
    }
    return newList;
}

@end
