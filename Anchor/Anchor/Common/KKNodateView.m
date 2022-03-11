//
//  KKNodateView.m
//  KK
//
//  Created by 小鱼 on 2021/8/3.
//

#import "KKNodateView.h"
@interface KKNodateView ()
@property (nonatomic, strong) UIView *noDateView;
@property (nonatomic, strong) UIImageView *noDataImageV;
@property (nonatomic, strong) UILabel* topText;
@property (nonatomic, strong) UIButton *botoomText;
@end
@implementation KKNodateView
-(instancetype)initWithFrame:(CGRect)frame WithIsLoadFailState:(KKLoadFailState)loadFailState withAssignLoadBlock:(asginLoadBlock)asginLoadBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.loadFailState = loadFailState;
        self.loadBlock = asginLoadBlock;
        [self showNoDataViewWithIsFail:YES];
    }
    return self;
    
}
-(instancetype)initWithFrame:(CGRect)frame WithIsLoadfail:(BOOL)isFaile withAssignLoadBlock:(asginLoadBlock)asginLoadBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.loadBlock = asginLoadBlock;
        [self showNoDataViewWithIsFail:YES];
    }
    return self;
}
///展示无数据页面
-(void)showNoDataViewWithIsFail:(BOOL)isFail{

    self.noDateView = [[UIView alloc] init];
    [self addSubview:self.noDateView];
    
    [self.noDateView addSubview:self.noDataImageV];
      
    [self.noDateView addSubview:self.topText];
    
    [self.noDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(@200);
    }];
    
    [self.noDataImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@120);
        make.top.equalTo(self.noDateView);
        make.centerX.equalTo(self.noDateView);
    }];
    
    [self.topText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.noDateView);
        make.height.equalTo(@25);
        make.top.equalTo(self.noDataImageV.mas_bottom);
    }];
    
    if (self.loadFailState == KKLoadFail) {
        UIButton *botoomText = [[UIButton alloc] init];
        [botoomText.layer setMasksToBounds:YES];
        [botoomText.layer setCornerRadius:17];
        [botoomText setBackgroundColor:[KKColor getColor:colorSecondBtnBg]];
        [botoomText addTarget:self action:@selector(assginReloadDate) forControlEvents:UIControlEventTouchUpInside];
        [botoomText setTitle:@"点击重试" forState:UIControlStateNormal];
        [botoomText setTitleColor:[KKColor getColor:colorSecondBtnText] forState:UIControlStateNormal];
        [botoomText.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.noDateView addSubview:botoomText];
        [botoomText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.noDateView);
                make.top.equalTo(self.topText.mas_bottom).offset(20);
                make.height.equalTo(@34);
                make.width.equalTo(@118);
        }];
        self.botoomText = botoomText;
    }
}
-(void)assginReloadDate{
    if (self.loadBlock) {
        self.loadBlock();
    }
    [self removeAsginLoadView];
}
-(void)showAsginLoadView{
   
}
-(void)removeAsginLoadView{
    [self removeFromSuperview];
}
-(void)setLoadFailState:(KKLoadFailState)loadFailState{
    _loadFailState = loadFailState;
    NSArray *imageArr = @[@"icon_nodata_search", //1
                          @"icon_nodata_video",  //2
                          @"icon_nodata_follow", //3
                          @"icon_nodata_fans",   //4
                          @"icon_nodata_praise", //5
                          @"icon_nodata_video",  //6
                          @"icon_nodata_default",//7
                          @"icon_nodata_video",  //8
                          @"icon_nodata_video",  //9
                          @"icon_nodata_default",//10
                          @"icon_nodata_default",//11
                          @"icon_nodata_default",//12
                          @"loadFail",//13
                          @"icon_nodata_default",//14
                          @"icon_nodata_praise",//15
                          @"icon_nodata_default",//16
                          @"icon_nodata_default",//17
                          @"icon_nodata_default",//18
                          @"icon_nodata_default" //19
    ];
    NSArray *titleArr = @[@"没有这个搜索结果，换一个试试",//1
                          @"视频列表空空!",//2
                          @"关注列表空空，快去关注有兴趣的人吧",//3
                          @"你还没有粉丝",//4
                          @"你还没有点赞视频，快去点赞吧",//5
                          @"你还没有发布视频快去发布吧",//6
                          @"你还没有收藏视频，快去收藏吧",//7
                          @"该用户还没有发布视频",//8
                          @"你还没有邀请用户",//9
                          @"你还没有下载视频，快去下载吧",//10
                          @"暂无评论数据",//11
                          @"你还没有工单",//12
                          @"加载失败",//13
                          @"空空如也~",//14
                          @"你还没有点赞帖子，快去点赞吧",//15
                          @"你还没有收藏帖子，快去收藏吧",//16
                          @"你还没有发布帖子，快去发布吧",//17
                          @"该用户还没有发布帖子",//18
                          @"空空如也~",//19
                          
    ];

    [self.noDataImageV setImage:[UIImage imageNamed:imageArr[loadFailState]]];
    [self.topText setText:titleArr[loadFailState]];
    
}
-(UIImageView *)noDataImageV{
    if (!_noDataImageV) {
        _noDataImageV = [[UIImageView alloc] init];
    }
    return _noDataImageV;
}
-(UILabel *)topText{
    if (!_topText) {
        _topText = [[UILabel alloc] init];
        _topText.textColor = [KKColor getColor:appHintTextColor];
        [_topText setTextAlignment:NSTextAlignmentCenter];
        [_topText setFont:[UIFont systemFontOfSize:14]];
    }
    return _topText;
}

+(void)showMTLoadFailViewWithLoadState:(KKLoadFailState)loadFailState withShowView:(UIView*)showView withAssignLoadBlock:(nullable asginLoadBlock)asginLoadBlock{
    KKNodateView *showV =  [[KKNodateView alloc]initWithFrame:CGRectZero WithIsLoadFailState:loadFailState withAssignLoadBlock:^{
        if (loadFailState == KKLoadFail) {
            if (asginLoadBlock) {
                asginLoadBlock();
            }
        }
    }];
    [showView addSubview:showV];
    [showV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(showView);
        make.centerY.mas_equalTo(showView);
        make.size.mas_equalTo(CGSizeMake(showView.frame.size.width, showView.frame.size.height));
    }];
   
    // 无数据时隐藏fotterview
    if ([showView isMemberOfClass:[UICollectionView class]]) {
        UICollectionView * collection = (UICollectionView *)showView;
        collection.mj_footer.hidden = YES; // 隐藏
    }if ([showView isMemberOfClass:[UITableView class]]) {
        UITableView * tableview = (UITableView *)showView;
        tableview.mj_footer.hidden = YES;// 隐藏
    }
}

//个人中心使用
+(void)showMySelfLoadFailViewWithLoadState:(KKLoadFailState)loadFailState withShowView:(UIView*)showView withAssignLoadBlock:(nullable asginLoadBlock)asginLoadBlock{
    KKNodateView *showV =  [[KKNodateView alloc]initWithFrame:CGRectZero WithIsLoadFailState:loadFailState withAssignLoadBlock:^{
        if (loadFailState == KKLoadFail) {
            if (asginLoadBlock) {
                asginLoadBlock();
            }
        }
    }];
    [showView addSubview:showV];
    [showV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(showView);
        make.centerY.mas_equalTo(showView).offset(-100);
        make.size.mas_equalTo(CGSizeMake(showView.frame.size.width, showView.frame.size.height));
    }];
    if ([showView isMemberOfClass:[UICollectionView class]]) {
        UICollectionView * collection = (UICollectionView *)showView;
        collection.mj_footer.hidden = YES; // 隐藏
    }if ([showView isMemberOfClass:[UITableView class]]) {
        UITableView * tableview = (UITableView *)showView;
        tableview.mj_footer.hidden = YES;// 隐藏
    }
}

+(KKNodateView *)showPlayerViewLoadFailViewWithLoadState:(KKLoadFailState)loadFailState withShowView:(UIView*)showView withAssignLoadBlock:(nullable asginLoadBlock)asginLoadBlock{
    KKNodateView *showV =  [[KKNodateView alloc]initWithFrame:CGRectZero WithIsLoadFailState:loadFailState withAssignLoadBlock:^{
        if (loadFailState == KKLoadFail) {
            if (asginLoadBlock) {
                asginLoadBlock();
            }
        }
    }];
    [showView addSubview:showV];
    [showV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(showView);
        make.centerY.mas_equalTo(showView);
        make.size.mas_equalTo(CGSizeMake(showView.frame.size.width, showView.frame.size.height));
    }];
    return showV;
   
}
+(void)disMissWithLoadFailViewWithShowView:(UIView*)showView{
    for (UIView * view in showView.subviews) {
        if ([view isKindOfClass:[KKNodateView class]]) {
            [view removeFromSuperview];
        }
    }
    
    // 有数据时显示
    if ([showView isMemberOfClass:[UICollectionView class]]) {
        UICollectionView * collection = (UICollectionView *)showView;
        collection.mj_footer.hidden = NO; // 显示
        collection.mj_footer.state = MJRefreshStateIdle; // 置为闲置状态
    }if ([showView isMemberOfClass:[UITableView class]]) {
        UITableView * tableview = (UITableView *)showView;
        tableview.mj_footer.hidden = NO;// 显示
        tableview.mj_footer.state = MJRefreshStateIdle;// 置为闲置状态
    }
    
}
-(void)setTextColor:(BOOL)isfaile{
    if (isfaile) {
        [_botoomText setBackgroundColor:KKRGBA(56, 58, 68, 1)];
        [_botoomText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _topText.textColor = [UIColor whiteColor];
    }
    else{
        _topText.textColor = [UIColor whiteColor];
    }
}
@end
