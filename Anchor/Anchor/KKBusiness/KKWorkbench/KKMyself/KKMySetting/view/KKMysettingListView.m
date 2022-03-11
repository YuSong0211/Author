//
//  KKMysettingListView.m
//  KK
//
//  Created by 小草 on 2021/6/29.
//

#import "KKMysettingListView.h"
#import "KKMySettingTableViewCell.h"
#import "AppVersionMgr.h"
#import <WebKit/WebKit.h>
static NSString * cellid = @"KKMySettingTableViewCell";
@interface KKMysettingListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableview;

@property (nonatomic,strong) UIButton * versionAltLab;

@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation KKMysettingListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableview];
        //        [self addSubview:self.versionAltLab];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2);
}

// 分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKMySettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[KKMySettingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.cellIndex = indexPath.row;
    cell.titleName = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        // 切换账号
        if (self.KKMysettingSwitchACcountBlock) {
            self.KKMysettingSwitchACcountBlock();
        }
    }else if (indexPath.row == 1){
        if (self.KKMysettingShareCodeBlock) {
            self.KKMysettingShareCodeBlock();
        }
    }else if(indexPath.row == 2){
        // 清除缓存
        
        [self.tableview reloadData];
        
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        /// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        /// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
            NSLog(@"清除缓存完毕");
        }];
        
        [SVProgressHUD showMessage:@"清除缓存成功"];
    }else if(indexPath.row == 3){
        
        [[AppVersionMgr shareMgr]retry];
    }
    else{
//        [KKTool clearUDID];
//        [KKUserInfo share].isReadShareCode = 0;
//        [SVProgressHUD showMessage:@"UDID清除成功,请重启APP"];
    }
    
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]initWithObjects:@"切换账号",@"绑定推广码",@"清除缓存",@"检测版本", nil];
    }
    return _dataSource;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.rowHeight = 51;
        _tableview.contentInset = UIEdgeInsetsMake(13, 0, 0, 0);
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.bounces = NO;
    }
    return _tableview;
}

@end


