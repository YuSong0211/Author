//
//  KKMyLikeViewModel.m
//  KK
//
//  Created by Gwynne on 2021/8/6.
//  我的-点赞

#import "KKMyLikeViewModel.h"
#import "appvapiUserContentSocialApilikesShortVideoListAppendIdEncode.h"

@implementation KKMyLikeViewModel


- (void)requestWithIsRefresh:(BOOL)isRefresh withLastId:(nullable NSString *)lastId {
    appvapiUserContentSocialApilikesShortVideoListAppendIdEncode *req = [appvapiUserContentSocialApilikesShortVideoListAppendIdEncode createRequest];
    if (!isRefresh) {
        req.request.lastId = lastId;
    }
    // 调用请求
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiLikesShortVideoListResponse *  _Nonnull message) {
        if (isRefresh) {
            [self.videoList removeAllObjects];
        }
        NSMutableArray *array = [AvModel convertAvModelwithLikesShortVideoList:message];
        [self appendVideoList:array :refehScene];
    } failed:^(requestErrorCode errorCode) {
        [self requestError];
    }];
}

- (void)getLevelMoreVideo:(NSString *)lastId {
    if ([lastId isEqualToString:@""]) {
        [self.levelVideoCtrl.videoLeveldelegate onReveiveNewVideoListCompltte:self.videoList];
        return;
    }
    
    // 调用请求
    appvapiUserContentSocialApilikesShortVideoListAppendIdEncode *req = [appvapiUserContentSocialApilikesShortVideoListAppendIdEncode createRequest];
    req.request.lastId = lastId;
    [[NetWorkMgr createMgrWithMessage:req] sendRequest:^(appvapiLikesShortVideoListResponse *  _Nonnull message) {
        NSMutableArray *array = [AvModel convertAvModelwithLikesShortVideoList:message];
        [self appendVideoList:array :refehScene];
        [self.levelVideoCtrl.videoLeveldelegate onReveiveNewVideoListCompltte:array];
    } failed:^(requestErrorCode errorCode) {
        [self requestError];
    }];
    
}



- (void)removeItem:(id)param :(NSInteger)playIndex {
    AvModel *model = (AvModel*)param;
    for (AvModel *item in self.videoList) {
        if ([item.video.svideoId.id_p isEqualToString:model.video.svideoId.id_p]) {
            [self.videoList removeObject:item];
            [self setFunEvent:removeItem :@""];
            break;
        }
    }
}

- (void)addItem:(id)param :(NSInteger)playIndex {
//    [self.videoList addObject:(AvModel *)param];
    [self.videoList insertObject:(AvModel *)param atIndex:0];
    [self setFunEvent:addItem :@""];
}

@end
