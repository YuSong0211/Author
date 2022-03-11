//
//  KKMyLikeCommunityVController.m
//  mt
//
//  Created by ProgramMa on 2021/10/9.
//

#import "KKMyLikeCommunityVController.h"
#import "CommunityVideoTableCell.h"
#import "CommunityTextTableViewCell.h"
#import "CommunityPhotoTableViewCell.h"
#import "KKDynamicDetailsVC.h"
#import "KKCommunityListModel.h"
@interface KKMyLikeCommunityVController ()
@property (nonatomic,strong) NSMutableArray * dataSource; // 数据源
@property (nonatomic, strong)KKCommunityListModel *cModel;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic,assign)BOOL isLike;
@property (nonatomic,assign)BOOL isCollection;
@end

@implementation KKMyLikeCommunityVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addLike:) name:COMMUNITYLIKECENTER object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeLike:) name:COMMUNITYUNLIKECENTER object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(followOther:) name:COMMUNITYFOLLOWRELOADCENTER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelFollow:) name:CANAELFOLLOWCOMMUNITYCENTER object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addCollection:) name:COMMUNITYCOLLECTIONCENTER object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeCollection:) name:COMMUNITYUNCOLLECTIONCENTER object:nil];
    // Do any additional setup after loading the view.
}

///点赞通知
-(void)addLike:(NSNotification *)notifition{
    self.isLike = YES;
    [self setIsLike:YES withCommunityID:notifition.object];

}
-(void)setIsLike:(BOOL)islike withCommunityID:(KKCommunityModel *)itemModel{
    _isLike = islike;
    if (!_isLike) {
        for (KKCommunityModel *model in self.cModel.MyLikeCommnityList) {
            if ([model.communityItem.id_p.id_p isEqualToString:itemModel.communityItem.id_p.id_p]) {
                if (!_isLike) {
                    if (!model.communityItem.isLike) {
                        [self.cModel.MyLikeCommnityList removeObject:model];
                        break;
                    }
                    model.communityItem.starNumber -= 1;
                    model.communityItem.isLike = NO;
                    [self.cModel.MyLikeCommnityList removeObject:model];
                    break;
                }
            }
        }
    }else{
        
//        itemModel.communityItem.likes += 1;
//        itemModel.communityItem.isLike = YES;
        if (![self.cModel.MyLikeCommnityList containsObject:itemModel]) {
            [self.cModel.MyLikeCommnityList insertObject:itemModel atIndex:0];
        }
     
    }
    [self.cModel setFunEvent:refehCommunityScene :self.cModel.MyLikeCommnityList];
}
//取消点赞
-(void)removeLike:(NSNotification *)notifition{
    self.isLike = NO;
    [self setIsLike:NO withCommunityID:notifition.object];
}

//收藏
-(void)addCollection:(NSNotification *)notifition{
    self.isCollection = YES;
    [self setIsCollection:self.isCollection WithCommentID:notifition.object];
    
}
//取消收藏
-(void)removeCollection:(NSNotification *)notifition{
    
    self.isCollection =NO;
    [self setIsCollection:self.isCollection WithCommentID:notifition.object];
}

-(void)setIsCollection:(BOOL)iscollection WithCommentID:(KKCommunityModel *)commentID{
    
    _isCollection = iscollection;
    for (KKCommunityModel *model in self.cModel.MyLikeCommnityList) {
        if ([model.communityItem.id_p.id_p isEqualToString:commentID.communityItem.id_p.id_p]) {
            if (_isCollection) {
                if (model.communityItem.isCollection) {
                    break;
                }
                model.communityItem.collectNumber += 1;
                model.communityItem.isCollection = YES;
                break;
            }else {
                if (!model.communityItem.isCollection) {
                    break;
                }
                model.communityItem.collectNumber -= 1;
                model.communityItem.isCollection = NO;
                break;
            }
        }else{
            
        }
    }
    [self.tableView reloadData];
    
}


- (void)createUI {
    [self addTableViewWithIdentifiers:@[NSStringFromClass([CommunityVideoTableCell class]),NSStringFromClass([CommunityTextTableViewCell class]),NSStringFromClass([CommunityPhotoTableViewCell class])] isConfigRefresh:YES];
}
-(void)didCommunityReceiveEvent:(CommunityEventType)eventType dataSource:(id)dataSource{
    
    [super didCommunityReceiveEvent:eventType dataSource:dataSource];
    [KKNodateView disMissWithLoadFailViewWithShowView:self.tableView];
    //展示空数据
    
    if (eventType == requestCommunityError) {
        if (kArrayIsEmpty(self.cModel.MyLikeCommnityList)) {
            [KKNodateView showMTLoadFailViewWithLoadState:KKLoadFail withShowView:self.tableView withAssignLoadBlock:^{
                [self refresh];
            }];
        }else{
            [self endRefreshing];
        }
    }else{
        if (kArrayIsEmpty(self.cModel.MyLikeCommnityList)) {
            [KKNodateView showMTLoadFailViewWithLoadState:KKCommunityNoLikeData withShowView:self.tableView withAssignLoadBlock:nil];
        }else {
            [KKNodateView disMissWithLoadFailViewWithShowView:self.tableView];
        }
    }
//    self.isShowFooter = !kArrayIsEmpty(self.cModel.MyLikeCommnityList);
   
}
- (void)refresh {
    self.cModel.cType = communityLike;
    [self.cModel refreshCommunityList];
}

- (void)loadMore {
    self.cModel.cType = communityLike;
    [self.cModel getLevelMoreCommunity:[self.cModel getLastId]];

}
-(KKCommunityListModel *)cModel{
    if (!_cModel) {
        _cModel = [[KKCommunityListModel alloc] init];
        _cModel.delegate = self;
    }
    return _cModel;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    KKCommunityModel *model = self.cModel.MyLikeCommnityList[indexPath.row];
    if (model.communityItem.communityPostResourceType == appvapiCommunityPostResourceType_CommunityPostResourceTypeUnspecified){
        CommunityTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommunityTextTableViewCell class]) forIndexPath:indexPath];
        cell.model = model;
        
        return cell;
    } else if(model.communityItem.communityPostResourceType == appvapiCommunityPostResourceType_CommunityPostResourceTypeVideo){
        CommunityVideoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommunityVideoTableCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if(model.communityItem.communityPostResourceType == appvapiCommunityPostResourceType_CommunityPostResourceTypePicture){
        CommunityPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommunityPhotoTableViewCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self jumpDynamicdetail:self.cModel.MyLikeCommnityList[indexPath.row] isComment:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cModel.MyLikeCommnityList.count;
}

// 跳转到动态详情
-(void)jumpDynamicdetail:(KKCommunityModel *)model isComment:(BOOL)isComment{
    // 动态详情
    KKDynamicDetailsVC * detailVc = [[KKDynamicDetailsVC alloc]init];
    detailVc.listModel = self.cModel;
    detailVc.dataModel = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(void)followOther:(NSNotification *)notifition{

    NSString  *userId = notifition.object;
    for (KKCommunityModel *item in self.cModel.MyLikeCommnityList) {
        if ([item.communityItem.userInfoBasic.uid.id_p isEqualToString:userId]) {
            item.communityItem.isFollow = YES;
        }
    }
}

//取消关注
-(void)cancelFollow:(NSNotification *)notifition{
    NSString *userId = notifition.object;
    for (KKCommunityModel *item in self.cModel.MyLikeCommnityList) {
        if ([item.communityItem.userInfoBasic.uid.id_p isEqualToString:userId]) {
            item.communityItem.isFollow = NO;
        }
    }
}

#pragma mark - JXPagerSmoothViewListViewDelegate
- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (UIView *)listView {
    return self.view;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
