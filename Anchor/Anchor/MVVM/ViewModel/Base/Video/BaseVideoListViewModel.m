//
//  BaseVideoListViewModel.m
//  KK
//
//  Created by hk on 2021/8/4.
//

#import "BaseVideoListViewModel.h"


@interface BaseVideoListViewModel()<mVideoListDelegate>



@end


@implementation BaseVideoListViewModel

//init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.videoList = [[NSMutableArray alloc] init];
        self.videoLikeList = [[NSMutableArray alloc] init];
        self.videoPlayList = [[NSMutableArray alloc] init];
        self.videoCollectionList = [[NSMutableArray alloc] init];
        self.videoNewestList = [[NSMutableArray alloc]init];
        self.feedArr = [[NSMutableArray alloc]init];
        self.userListArray = [[NSMutableArray alloc]init];
        self.startIndex = 0;
    }
    return self;
}


//获取下个视频ID
- (NSString *)getLastId {
    if (kArrayIsEmpty(self.videoList)) {
        return @"";
    }
    if (![self.videoList.lastObject isKindOfClass:[AvModel class]]) {
        return @"";
    }
    return self.videoList.lastObject.lastId;
}


//获取视频id
- (void)requestVideoList:(NSString *)lastId :(onComplete)complete{
    
}

//加载更多视频
- (void)getLevelMoreVideo:(NSString *)lastId{
    [self requestWithIsRefresh:NO withLastId:lastId];
}

//下拉刷新
- (void)refreshVideo {
    [self requestWithIsRefresh:YES withLastId:nil];
}

- (void)requestWithIsRefresh:(BOOL)isRefresh withLastId:(nullable NSString *)lastId {
    
}

//请求刷新二级页面
- (void)refehLevelVideo:(NSMutableArray<AvModel *> *)vList{
    if ([self.levelVideoCtrl.videoListdelegate respondsToSelector:@selector(onReveiveNewVideoListCompltte:)]) {
        [self.levelVideoCtrl.videoLeveldelegate onReveiveNewVideoListCompltte:vList];
    }
}

//启动二级页面,并不能按照以前的方式写
//流程如下
//制作一个单例,用来管理生命周期，以及继承等关系
- (void)startLevelVideo:(NSInteger)startIndex{
    self.startIndex = startIndex;
    self.levelVideoCtrl = [[LevelVideoDriverCtrl getInstance] createLevelCtrl];
    self.levelVideoCtrl.videoListdelegate = self;
    [self.levelVideoCtrl startLevelVideo:startIndex];
}

//追加信息
- (void)appendVideoList:(NSMutableArray<AvModel *> *)vList :(videoEventType)type{
    [self.videoList addObjectsFromArray:vList];
    [self setFunEvent:type :vList];
}

/// 通用追加数据
/// @param vList 追加数据内容
/// @param type 刷新内容
- (void)appendList:(NSMutableArray *)vList type:(videoEventType)type{
    [self.videoList addObjectsFromArray:vList];
    [self setFunEvent:type :vList];
}

//添加对象
- (void)addItem:(id)param :(NSInteger)playIndex{

}

//删除对象
- (void)removeItem:(id)param :(NSInteger)playIndex{

}

///删除某个元素 (收藏)
-(void)collection_removeItem:(id)param
                   playIndex:(NSInteger)playIndex {
    
}

///在某个位置添加某个元素 (收藏)
-(void)collection_addItem:(id)param
                playIndex:(NSInteger)playIndex {
    
}

//自动更新到某个坐标
- (void)finish:(NSInteger)playIndex {
    if (self.videoList.count <= playIndex) {
        self.startIndex = self.videoList.count - 1;
    }else {
        self.startIndex = playIndex;
    }
    [self setFunEvent:location :@""];
}

//请求失败
- (void)requestError {
    if ([self.requestType isEqualToString:@"choiceness"]) {
        if (!kArrayIsEmpty(self.feedArr)) {
            [SVProgressHUD showMessage:@"网络连接失败，请检查网络"];
        }
    }else if ([self.requestType isEqualToString:@"watch"]){
        if (!kArrayIsEmpty(self.videoPlayList)) {
            [SVProgressHUD showMessage:@"网络连接失败，请检查网络"];
        }
    }else if ([self.requestType isEqualToString:@"like"]){
        if (!kArrayIsEmpty(self.videoLikeList)) {
            [SVProgressHUD showMessage:@"网络连接失败，请检查网络"];
        }
    }else if ([self.requestType isEqualToString:@"collection"]){
        if (!kArrayIsEmpty(self.videoCollectionList)) {
            [SVProgressHUD showMessage:@"网络连接失败，请检查网络"];
        }
    }else if ([self.requestType isEqualToString:@"public"]){
        if (!kArrayIsEmpty(self.videoNewestList)) {
            [SVProgressHUD showMessage:@"网络连接失败，请检查网络"];
        }
    }else if ([self.requestType isEqualToString:@"intelligent"]){
        if (!kArrayIsEmpty(self.userListArray)) {
            [SVProgressHUD showMessage:@"网络连接失败，请检查网络"];
        }
    }else if (kStringIsEmpty(self.requestType)){
        if (!kArrayIsEmpty(self.videoList)) {
            [SVProgressHUD showMessage:@"网络连接失败，请检查网络"];
        }
    }
    [self setFunEvent:requestError :@""];
}

//发送结果回调
-(void)setFunEvent:(videoEventType)type
                  :(id)dataSource{
    if ([self.delegate respondsToSelector:@selector(didReceiveEvent:dataSource:)]) {
        [self.delegate didReceiveEvent:type dataSource:dataSource];
    }else{
//        NSAssert(NO, @"请在控制器的viewModel中设置代理！！！！");
    }
}

//获取播放下表
- (NSInteger)getCurrentPlayIndex{
    return self.startIndex;
}


/**
 /// 追加的短视频视频列表，
 @param vList  追加的视频列表
 @param type  刷新内容
 */
-(void)appendVideoList:(NSMutableArray<AvModel*>*)vList
                      :(videoEventType)type withPlayType:(NSInteger)rankType{
    if (rankType == 0) {
        [self.videoPlayList addObjectsFromArray:vList];
        [self setFunEvent:type :vList];
    }else if (rankType == 1){
        
        [self.videoLikeList addObjectsFromArray:vList];
        [self setFunEvent:type :vList];
        
    }else if (rankType == 2){
        [self.videoCollectionList addObjectsFromArray:vList];
        [self setFunEvent:type :vList];
    }else if (rankType == 3){
        [self.videoNewestList addObjectsFromArray:vList];
        [self setFunEvent:type :vList];
    }
   
}


@end
