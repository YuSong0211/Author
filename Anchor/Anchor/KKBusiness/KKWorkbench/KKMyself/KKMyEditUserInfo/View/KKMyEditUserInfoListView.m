//
//  KKMyEditUserInfoListView.m
//  KK
//
//  Created by 小草 on 2021/6/30.
//

#import "KKMyEditUserInfoListView.h"
#import "KKMyEditUserInfoTableviewCell.h"
// headerview
#import "KKMyEditUserInfoListHeaderView.h"
// footview
#import "KKMyEditUserInfoListFooterView.h"

#import "CZHCustomCell.h"
#import "CZHAlertView.h"
#import "CZHHeader.h"

static NSString * cellid = @"KKMyEditUserInfoTableviewCell";
@interface KKMyEditUserInfoListView ()<UITableViewDelegate,UITableViewDataSource>

// headerview
@property (nonatomic,strong) KKMyEditUserInfoListHeaderView * headerView;

// footerview
@property (nonatomic,strong) KKMyEditUserInfoListFooterView * footerView;

// 数据源
@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation KKMyEditUserInfoListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableview];
    }
    return self;
}
-(void)setBasic:(appvapiUserInfoBasic *)basic {
    _basic = basic;
    self.headerView.basic = basic;
    self.footerView.basic = basic;
}
- (void)setNikeName:(NSString *)nikeName {
    _nikeName = nikeName;
    [self.tableview reloadData];
}
-(void)setSelectImage:(UIImage *)selectImage {
    self.headerView.selectImage = selectImage;
    [self.tableview reloadData];
}
-(void)setPhone:(NSString *)phone {
    _phone = phone;
    [self.tableview reloadData];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKMyEditUserInfoTableviewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[KKMyEditUserInfoTableviewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.cellIndex = indexPath.row;
    cell.titleName = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.basic = self.basic;
    if (!kStringIsEmpty(self.nikeName)) {
        cell.nikeName = self.nikeName;
    }
    if (!kStringIsEmpty(self.phone)) {
        cell.phone = self.phone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KKMyEditUserInfoTableviewCell *cell = (KKMyEditUserInfoTableviewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        if (self.editUserInfoNikeNameBlock) {
            self.editUserInfoNikeNameBlock();
        }
    }
    if (indexPath.row == 1) {
//        CZHCustomModel *model13 = [CZHCustomModel czh_modelWithContent:@"sheet从下往上显示,并且有一个取消类型的" selectHandler:^{
        CZHAlertView *alertView = [CZHAlertView czh_alertViewWithTitle:@"" message:@"" preferredStyle:CZHAlertViewStyleActionSheet animationStyle:CZHAlertViewAnimationStyleSlideFromBottom];
        alertView.viewBackgroundColor = [KKColor getColor:colorDialogBtnBg];
        CZHAlertItem *item = [CZHAlertItem czh_itemWithTitle:@"取消" titleFont:[UIFont mediumWithSize:16] titleColor: [KKColor getColor:appMainTextColor] backgroundColor:[KKColor getColor:colorDialogBtnBg] style:CZHAlertItemStyleCancel handler:^(CZHAlertItem *item) {
            
        }];
        CZHAlertItem *item1 = [CZHAlertItem czh_itemWithTitle:@"男" titleFont:[UIFont mediumWithSize:16] titleColor: [KKColor getColor:appMainTextColor] backgroundColor:[KKColor getColor:colorDialogBtnBg] style:CZHAlertItemStyleDefault handler:^(CZHAlertItem *item) {
           
            if ([[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
                cell.genderName = item.title;
                if (self.SelectGenderBlock) {
                    self.SelectGenderBlock(appvapiGenders_Male);
                }
            }else{
                [SVProgressHUD showMessage:@"网络连接失败，请检查网络重试"];
            }
            
        }];
        CZHAlertItem *item2 = [CZHAlertItem czh_itemWithTitle:@"女" titleFont:[UIFont mediumWithSize:16] titleColor: [KKColor getColor:appMainTextColor] backgroundColor:[KKColor getColor:colorDialogBtnBg] style:CZHAlertItemStyleDefault handler:^(CZHAlertItem *item) {
            
            if ([[NetWrokStatesCtrl getInstance] networkIsAvailable]) {
                cell.genderName = item.title;
                if (self.SelectGenderBlock) {
                    self.SelectGenderBlock(appvapiGenders_Female);
                }
            }else{
                [SVProgressHUD showMessage:@"网络连接失败，请检查网络重试"];
            }
            
        }];
            [alertView czh_addAlertItem:item];
            [alertView czh_addAlertItem:item1];
            [alertView czh_addAlertItem:item2];
            
            [alertView czh_showView];
//        }];
        
    }else if (indexPath.row == 2) {
        if (self.UpdataBingPhoneBlock) {
            self.UpdataBingPhoneBlock();
        }
    }
}
// 懒加载
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.rowHeight = 60;
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableview.backgroundColor = [UIColor clearColor];
        //_tableview.bounces = NO;
        // headerView
        self.headerView = [[KKMyEditUserInfoListHeaderView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, 147)];
        self.headerView.backgroundColor = [UIColor clearColor];
        _tableview.tableHeaderView = self.headerView;
        // footerView
        self.footerView = [[KKMyEditUserInfoListFooterView alloc]initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, 150)];
        WS
        [self.footerView setTextViewTextDidChangeNotificationBlock:^(NSString * _Nonnull content) {
            SS
            if (self.textViewTextDidChangeNotificationBlock) {
                self.textViewTextDidChangeNotificationBlock(content);
            }
        }];
        [self.footerView setTextViewTextDidEndNotificationBlock:^(NSString * _Nonnull content) {
            SS
            if (self.textViewTextDidEndNotificationBlock) {
                self.textViewTextDidEndNotificationBlock(content);
            }
        }];
        [self.headerView setSelectAvterImageBlock:^(UIImage * _Nonnull selectImage) {
            SS
            if (self.updataAvterBlock) {
                self.updataAvterBlock(selectImage);
            }
        }];
        self.tableview.tableFooterView = self.footerView;
    }
    return _tableview;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]initWithObjects:@"昵称",@"性别",@"绑定手机",@"简介", nil];
    }
    return _dataSource;
}

@end
