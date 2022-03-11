//
//  KKMySelfVC.m
//  KK-
//
//  Created by 小鱼 on 2021/6/24.
//

#import "KKMySelfVC.h"
#import "MineHeaderView.h"
#import "MineTableviewCell.h"
#import "KKMineMsgView.h"
#import "MinCellModel.h"
#import "KKMyEditUserInfoVC.h" // 编辑用户资料

#import "KKMySelfViewModel.h"

#import "LoginViewController.h"
#import "KKMineGetLikeAlerterView.h"
#import "KKUserInfo.h"

#import "KKMineMemberCell.h"
#import "KKMineShareCell.h"

#import "KKPubTagVCModel.h"
#import "KKMinewallteCell.h"
#import "KKCoustomPayWebVC.h"
#import "KKWebViewController.h"
#import "KKMainWebView.h"

#import "KKPublishVC.h"
static NSString * cellid = @"MineTableviewCell";
@interface KKMySelfVC ()<UITableViewDelegate,UITableViewDataSource,KKMySelfListHeaderViewDelegate,UINavigationControllerDelegate>

// 我的列表
@property (nonatomic,strong) UITableView * tableview;

// 我是信息视图（tableviewheaderView）
@property (nonatomic,strong) MineHeaderView * tableviewHeaderView;

// cellModel
@property (nonatomic,strong) MinCellModel * cellModelData;

@property (nonatomic,strong) UIImageView * publishIcon;

@property (nonatomic,strong) UIButton * publishIconButtonMask;

// 消息
@property (nonatomic,strong) KKMineMsgView * msgView;

@property (nonatomic, strong)NSIndexPath *indexPath ;

// 用户资料
@property (nonatomic,strong)appvapiUserInfoBasic *basic;

@property (nonatomic,strong)KKMySelfViewModel *myViewModel;


@property (nonatomic,strong)NSString * walletMoney;

@property (nonatomic,assign) BOOL isFirstFrom; // 是否首次进入，首次进入不向webview传递参数

@end

@implementation KKMySelfVC

-(appvapiUserInfoBasic *)basic{
    
    if (!_basic) {
        _basic = [[appvapiUserInfoBasic alloc]init];
    }
    return _basic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstFrom = YES;
    self.view.backgroundColor = [KKColor getColor:appBgColor];
    [self createData];
    [self.view addSubview:self.tableview];
    if ([KKPubTagVCModel shareToolGetManager].enablePublishContent == true) {
        [self.view addSubview:self.publishIcon];
        [self.view addSubview:self.publishIconButtonMask];
    }
   
    [self.view addSubview:self.msgView];
    // 通知刷新用户信息
    [kNotificationCenter addObserver:self selector:@selector(updataUserInfoNotificationCenter) name:KKUpdataUserInfoNotificationCenter object:nil];
    [kNotificationCenter addObserver:self selector:@selector(updataUserInfoAvterNotificationCenter) name:KKUpdataUserInfoAvterNotificationCenter object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReloadTable) name:VIPBACKRELOADDATACENTER object:nil];

    // 从后台进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appFormBacToFront) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.basic.nickname = [KKUserInfo share].nickname;
    self.basic.intro = [KKUserInfo share].intro;
    self.basic.gender = (int)[KKUserInfo share].gender;
    
    WS
    [[KKUserInfo share] setChangeUserInForBlock:^{
      SS
        [self.tableviewHeaderView.headerMsgView userInfo];
        self.basic.nickname = [KKUserInfo share].nickname;
        self.basic.intro = [KKUserInfo share].intro;
        self.basic.gender = (int)[KKUserInfo share].gender;
    }];

    [KKConfig share].mainTabbatViewController = (KKTabbarVC *)self.tabBarController;


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
    [self initListener];
    [self.tableview reloadData];
    self.navigationController.delegate = self;
    [self ReloadTable];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isFirstFrom == NO) {
        // 每次进入刷新webview，获取最新的余额
        [self reloadWallet];
    }
    self.isFirstFrom = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

// 从后台进入前台
-(void)appFormBacToFront{
    [self reloadWallet];
}

// 刷新钱包余额
- (void)reloadWallet {
    if (self.indexPath) {
        if ([[KKTool getCurrentVC] isMemberOfClass:[KKMySelfVC class]]) {
            KKMinewallteCell *cell = [self.tableview cellForRowAtIndexPath:self.indexPath];
            [cell reloadWeb];
        }
    }
}

- (void)initData{
    self.myViewModel = [[KKMySelfViewModel alloc] init];
    [self.myViewModel reqRefehUserInfo];
}
- (void)updataUserInfoNotificationCenter {
    [self initData];
    [self initListener];
}
- (void)updataUserInfoAvterNotificationCenter {
    self.tableviewHeaderView.headerMsgView.avterUrl = self.basic.avatarURL.URL;
}
///购买完会员刷新数据
-(void)ReloadTable{

    [KKMySelfModel reqRefehUserBaseInfo:^(appvapiUserInfoBasic  *_Nonnull message) {
        //[KKUserInfo share].vip = message.vip;
        [KKUserInfo share].member_level = message.memberLevel;
        [KKUserInfo share].member_expiration_time = message.memberExpirationTime;
        [KKUserInfo share].vipProductId = message.vipProductId;
        [[KKPubTagVCModel shareToolGetManager]getMemberReloadInfo:^{
            [self.tableview reloadData];
            [self.tableviewHeaderView.headerMsgView userInfo];
        }];
       
       
    } :^(requestErrorCode errorCode) {
        
    }];
    
}
- (void)initListener{
    [self.myViewModel.signalUpdateUserInfo subscribeNext:^(appvapiUserInfoBasic *  _Nullable x) {
        NSLog(@"刷新用户信息吧！");
        self.basic = x;
        [self.tableviewHeaderView.headerMsgView userInfo];
    }];
}

-(void)createData{
    
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc]initWithDictionary:@{
        @"dataSource":@[@{@"iconName":@"icon_mine_setting",@"titleName":@"设置",@"controllerClass":@"KKMysettingViewController"}]}];
    
    [self.cellModelData modelSetWithDictionary:dataDic];
}

// 分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([KKPubTagVCModel shareToolGetManager].enableVip == false) {
        return 1;
    }else{
        return 4;
    }
   
}

// 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([KKPubTagVCModel shareToolGetManager].enableVip == false) {
        if (section == 0) {
            return self.cellModelData.dataSource.count;
        }
        return 1;
    }else{
        
        if (section == 3) {
            return self.cellModelData.dataSource.count;
        }
        return 1;
    }
}

// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([KKPubTagVCModel shareToolGetManager].enableVip == false) {
    
            MineTableviewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[MineTableviewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.dataModel = self.cellModelData.dataSource[indexPath.row];
            return cell;
        
    }else{
        if (indexPath.section == 0) {
            KKMineMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKMineMemberCell" forIndexPath:indexPath];
            [cell reloadVIPData];
            WS
            cell.btnActionCallBack = ^{
                SS
                [self pushToMemberCenterPage];
            };
            return cell;
        }else if (indexPath.section == 1) {
            KKMineShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKMineShareCell" forIndexPath:indexPath];
            return cell;
        }else if (indexPath.section == 2){
            KKMinewallteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKMinewallteCell" forIndexPath:indexPath];
            self.indexPath = indexPath;
            WS
            [cell setClickWebViewCallBack:^{
                SS
                [self jumpToWebViewWallet];
            }];
            return cell;
        }
        else {
            MineTableviewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[MineTableviewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.dataModel = self.cellModelData.dataSource[indexPath.row];
            return cell;
        }
        
    }

}

// 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([KKPubTagVCModel shareToolGetManager].enableVip  == false) {
            MinCellModelDataSource * source = self.cellModelData.dataSource[indexPath.row];
            if (![[[NSClassFromString(source.controllerClass) alloc] init] isKindOfClass:[LoginViewController class]]) {
                id selectVC = [[NSClassFromString(source.controllerClass) alloc] init];
                [self.navigationController pushViewController:selectVC animated:YES];
            }
    }else{
        
        if (indexPath.section == 0) {
            [self pushToMemberCenterPage];
        }else if (indexPath.section == 1) {
            
        }else if (indexPath.section == 2){
            [self jumpToWebViewWallet];
        }
        else {
            MinCellModelDataSource * source = self.cellModelData.dataSource[indexPath.row];
            if (![[[NSClassFromString(source.controllerClass) alloc] init] isKindOfClass:[LoginViewController class]]) {
                id selectVC = [[NSClassFromString(source.controllerClass) alloc] init];
                [self.navigationController pushViewController:selectVC animated:YES];
            }
        }
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    CGFloat pictureHeight = 150;
    if (Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = pictureHeight - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / pictureHeight;
        CGFloat width = KK_SCREEN_WIDTH;
        // 拉伸后图片位置
        self.tableviewHeaderView.headerIcon.frame = CGRectMake(-(width * scale - width) / 2, Offset_y, width * scale, totalOffset);
    }
}

#pragma mark -- KKMySelfListHeaderViewDelegate

/// 点击编辑用户信息
-(void)clickEditUserInfo{
    // 点击编辑信息
    if ([[KKUserInfo share] hasBindingTelephone]) {
        // 绑定手机号
        KKMyEditUserInfoVC * editUserInfo = [[KKMyEditUserInfoVC alloc]init];
        editUserInfo.basic = self.basic;
        [self.navigationController pushViewController:editUserInfo animated:YES];
    }else {
        // 未绑定手机号
        LoginViewController *login = [[LoginViewController alloc]init];
        login.loginType = BindPhone;
        login.isBingDingPhone = YES;
        [self.navigationController pushViewController:login animated:YES];
    }
}

/// 点击用户信息中的模块
/// @param clickType 点赞 关注 粉丝
-(void)clickBehaviorWithType:(KKMySelfClickType)clickType{
    if (clickType == KKMySelfClickLikeType) {
        [self pushLikeVC];
    }else if (clickType == KKMySelfClickAttentionType){
        [self pushAttentionVC];
    }else if (clickType == KKMySelfClickFansType){
        [self pushFansVC];
    }
}

// 跳转点赞页面
-(void)pushLikeVC{
    
    // 获赞页面
    KKMineGetLikeAlerterView * showPriceView = [[KKMineGetLikeAlerterView alloc]init];
    [showPriceView showInView:self.basic];
    
    // 线上测试
    //CustomWebViewController * cusvc = [[ CustomWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/index.html#!/apitest",[richers getCanUseUrl:Ocdomain_api]] title:@"" vcType:CustomWebViewNav];
    // boss 本地测试
    //CustomWebViewController * cusvc = [[CustomWebViewController alloc] initWithUrl:@"http://192.168.31.8:8083/?dev#!/apitest" title:@"" vcType:CustomWebViewNav];
    //[self.navigationController pushViewController:cusvc animated:YES];
}
// 跳转关注页面
-(void)pushAttentionVC{
  
}
// 跳转粉丝页面
-(void)pushFansVC{

}

//跳转到会员中心
- (void)pushToMemberCenterPage {
//    NSString *urlStr = @"http://192.168.31.9:8083/#!/membervip";
    NSString *urlStr =  [KKTool getMemberVipUrl];
    CustomWebViewController * newWeb = [[CustomWebViewController alloc]initWithUrl:urlStr title:@"" vcType:CustomWebViewNav];
    [self.navigationController pushViewController:newWeb animated:YES];
}

//跳转钱包
-(void)jumpToWebViewWallet{
    NSString *urlStr = [KKTool getWalletUrl];
    CustomWebViewController * cusvc = [[ CustomWebViewController alloc] initWithUrl:urlStr title:@"钱包余额" vcType:CustomWebViewNav];
    [self.navigationController pushViewController:cusvc animated:YES];
    cusvc.view.backgroundColor = [UIColor whiteColor];
}

// 跳转到发布页面
-(void)clickPublish{
    KKPublishVC * publish = [[KKPublishVC alloc]init];
    [self.navigationController pushViewController:publish animated:YES];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT - KK_TABBAR_BAR_HEIGHT)style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.backgroundColor = [UIColor clearColor];
        self.tableviewHeaderView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_NAV_BAR_HEIGHT +  241.5)];
        self.tableviewHeaderView.backgroundColor = [UIColor clearColor];
        self.tableviewHeaderView.headerMsgView.delegate = self;
        _tableview.tableHeaderView = self.tableviewHeaderView;
        [_tableview registerClass:[KKMineMemberCell class] forCellReuseIdentifier:@"KKMineMemberCell"];
        [_tableview registerClass:[KKMineShareCell class] forCellReuseIdentifier:@"KKMineShareCell"];
        [_tableview registerClass:[KKMinewallteCell class] forCellReuseIdentifier:@"KKMinewallteCell"];
        
    }
    return _tableview;
}

-(MinCellModel *)cellModelData{
    if (!_cellModelData) {
        _cellModelData = [[MinCellModel alloc]init];
    }
    return _cellModelData;
}

-(UIImageView *)publishIcon{
    if (!_publishIcon) {
        _publishIcon = [[UIImageView alloc]initWithFrame:CGRectMake(15, KK_NAV_BAR_HEIGHT - (36), 21, 21)];
        _publishIcon.image = [KKTool decodeResourceFileImageName:@"icon_tab_publish"];
    }
    return _publishIcon;
}

-(UIButton *)publishIconButtonMask{
    if (!_publishIconButtonMask) {
        _publishIconButtonMask = [[UIButton alloc]initWithFrame:CGRectMake(0, KK_NAV_BAR_HEIGHT - 44, 50, 50)];
        [_publishIconButtonMask addTarget:self action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishIconButtonMask;
}

-(KKMineMsgView *)msgView{
    if (!_msgView) {
        _msgView = [[KKMineMsgView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 44, KK_NAV_BAR_HEIGHT - 44, 44, 44)];
    }
    return _msgView;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHidden = [viewController isKindOfClass:[KKMySelfVC class]];
    [self.navigationController setNavigationBarHidden:isHidden animated:YES];
}

//收到vip变动
- (void)didReceiveVipRecharge {
    [self ReloadTable];
}

//收到钱包余额变化
- (void)didReceiveWalletRecharge {
    [self reloadWallet];
}


@end
