//
//  MyLikesViewModel.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "MyLikesViewModel.h"
//#import "appvapiUserSocialApilikesAppendIdEncode.h"
 
@interface MyLikesViewModel()<mVideoListDelegate>

//我的点赞。
@property(strong,nonatomic) MyLikeModel* myLikeModel;

@end


@implementation MyLikesViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.myLikeModel = [[MyLikeModel alloc] init];
    }
    return self;
}

//重写请求逻辑
- (void)requestVideoList:(NSString *)lastId :(onComplete)complete{
    
    //模拟
    [[HeadPools getHeadPool] updateHeadVal:xNetCore :@"rzl"];
    
//    voyageapiUserSocialApilikesAppendIdEncode* req = [voyageapiUserSocialApilikesAppendIdEncode createRequest];
//    req.request.lastId = [self getLastId];
//    [[NetWorkMgr createMgrWithMessage:req] sendRequestWithNetCore:^(voyageapiMyContentSvideoAppendList*  message) {
//        NSMutableArray<AvModel*>* videoList = [AvModel convertAvModel:message];
//        [self appendVideoList:videoList :addItems];
//    
//        if(complete){
//            complete(videoList);
//        }
//        
//    } failed:nil];
}
 
 
//二级联动公共请求部分。
-(void)getLevelMoreVideo:(NSString *)lastId{
    //lastid 为0的情况， 是二级界面第一次请求数据的时候，所以直接将列表返回即可
    if (lastId.length==0) {
       //直接操作二级界面
        [self refehLevelVideo:self.videoList];
    }
    else{
        //因为刷新数据接口是一样的， 所以直接调用加载更多接口是一样的
        [self requestVideoList:lastId :^(NSMutableArray<AvModel*>*  message) {
            //异步操作二级界面
            [self refehLevelVideo:message];
        }];
    }
}



- (void)startLevelVideo:(NSInteger)startIndex{
    self.startIndex = startIndex;
    self.levelVideoCtrl = [[LevelVideoDriverCtrl getInstance] createLevelCtrl];
    self.levelVideoCtrl.videoListdelegate = self;
    [self.levelVideoCtrl startLevelVideo:startIndex];
}


@end
