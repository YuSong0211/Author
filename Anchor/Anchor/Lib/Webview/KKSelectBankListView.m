//
//  KKSelectBankListView.m
//  richers
//
//  Created by 小草 on 2021/12/27.
//

#import "KKSelectBankListView.h"
#import "KKBanListModel.h"
// 索引样式
#import "TTIndexBar.h"
#import "ICPinyinGroup.h" // 按照拼音进行排序
static NSString * KKSelectBankListViewid = @"KKSelectBankListViewid";
@interface KKSelectBankListView ()<UITableViewDelegate,UITableViewDataSource,TTIndexBarDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView * tableview;

@property (nonatomic,strong) NSMutableArray * attendanceDateilArray;
@property (nonatomic,strong) NSMutableArray * sectionIndexTitleArray;

@property (strong, nonatomic) TTIndexBar *sectionIndexView; // 索引说明


@end


@implementation KKSelectBankListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer * tapSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfClick)];
        tapSelf.delegate = self;
        [self addGestureRecognizer:tapSelf];
        [self addSubview:self.tableview];
        [self addSubview:self.sectionIndexView];
        
    }
    return self;
}



// 银行数据
-(void)setBanksArray:(NSMutableArray *)banksArray{

    NSMutableArray * conversionDataArray = [[NSMutableArray alloc]init];
    for (NSString * bankNameList in banksArray) {
        KKBanListModel * model = [[KKBanListModel alloc]init];
        model.bankName = bankNameList;
        [conversionDataArray addObject:model];
    }
    // 使用的是自己对首字母进行排序的
    NSDictionary * dic = [ICPinyinGroup group:conversionDataArray key:@"bankName"];
    self.attendanceDateilArray = [dic objectForKey:LEOPinyinGroupResultKey];
    self.sectionIndexTitleArray = [dic objectForKey:LEOPinyinGroupCharKey];
    
    [self.sectionIndexView setIndexes:self.sectionIndexTitleArray];
    
    // 根据第二个字排序组内的顺序
    [self arrStringSecondCharSort];
    
    [self.tableview reloadData];
    
    self.tableview.transform = CGAffineTransformIdentity;
    self.tableview.alpha = 1;
   
    __block NSIndexPath *indexPath;
    // 如果有选中的数据就定位到之前选中的行
    if (self.locationStr.length > 0) {
        [self.attendanceDateilArray enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger section, BOOL * _Nonnull sectionStop) {
            [obj enumerateObjectsUsingBlock:^(KKBanListModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([self.locationStr isEqualToString:obj.bankName]) {
                    NSLog(@"当前分区为  %ld   当前行数为  %ld",section,idx);
                    indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
                    *sectionStop = YES;
                    *stop = YES;
                    return;
                }
            }];
        }];
    }else{
        indexPath = [NSIndexPath indexPathForRow:0 inSection:self.attendanceDateilArray.count-1];
    }

    if (indexPath) {
        [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}


// 根据数组中第二个字重新排序
-(void)arrStringSecondCharSort{

//    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
//    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
//    [self.attendanceDateilArray enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger section, BOOL * _Nonnull sectionStop) {
//        [obj enumerateObjectsUsingBlock:^(KKBanListModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            // 取出每一个值的第二个汉字取出首字母
//            if (obj.bankName.length>=2) {
//                // 截取第二个字符串
//                obj.secondChar = [obj.bankName substringWithRange:NSMakeRange(1, 1)];
//                // 取出首字母
//                obj.secondCharIndex = [collation sectionForObject:obj collationStringSelector:NSSelectorFromString(@"secondChar")];
//                NSLog(@"%@    %ld",obj.secondChar,obj.secondCharIndex);
//            }
//        }];
//    }];
//
//    // 排序
//    [self.attendanceDateilArray enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger section, BOOL * _Nonnull sectionStop) {
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"secondCharIndex" ascending:YES];
//        [obj sortUsingDescriptors:[NSArray arrayWithObject:sort]];
//    }];
    
    [self.attendanceDateilArray enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger section, BOOL * _Nonnull sectionStop) {
        [obj enumerateObjectsUsingBlock:^(KKBanListModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 取出每一个值的拼音
            // 拼音字段
            NSMutableString *tempNamePinyin = [obj.bankName mutableCopy];
            CFStringTransform((__bridge CFMutableStringRef)tempNamePinyin, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)tempNamePinyin, NULL, kCFStringTransformStripDiacritics, NO);
            NSLog(@"----  %@",tempNamePinyin);
            obj.pinyin  = [tempNamePinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
        }];
    }];
    
    // 排序
    [self.attendanceDateilArray enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger section, BOOL * _Nonnull sectionStop) {
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES];
        [obj sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    }];
  
}

// 移除本类
-(void)tapSelfClick{
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tableview.transform = CGAffineTransformMakeTranslation(0, 100);
        self.tableview.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(15, 0, view.frame.size.width, 30);
    lab.text = self.sectionIndexTitleArray[section];
    lab.textColor = [UIColor lightGrayColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [view addSubview:lab];
    return view;
}

// 组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;//section头部高度
}

// 组尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.attendanceDateilArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.attendanceDateilArray objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"AttendanceDateilTableviewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    NSMutableArray * sectionArray = self.attendanceDateilArray[indexPath.section];
    KKBanListModel * model = sectionArray[indexPath.row];
    cell.textLabel.text = model.bankName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * sectionArray = self.attendanceDateilArray[indexPath.section];
    KKBanListModel * model = sectionArray[indexPath.row];
    if (self.bankBlock) {
        self.bankBlock(model.bankName);
    }
    [self tapSelfClick];
}

#pragma mark - TTIndexBarDelegate
- (void)indexDidChanged:(TTIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title
{
    if (index < self.attendanceDateilArray.count) {
        NSArray * arrcount = self.attendanceDateilArray[index];
        if (arrcount.count>0) {
          [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.sectionIndexView.onTouch) return;
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+30)];
    if (indexPath) {
        [self.sectionIndexView setSelectedLabel:indexPath.section];
    }
}


#pragma mark-手势代理，解决和tableview点击发生的冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] ||[NSStringFromClass([touch.view class]) isEqualToString:@"TTIndexBar"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/4-40, KK_SCREEN_WIDTH, (self.frame.size.height - self.frame.size.height/4)+40) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedRowHeight = 0;
        _tableview.rowHeight = 50;
        _tableview.layer.cornerRadius = 8;
        _tableview.layer.masksToBounds = YES;
        _tableview.transform = CGAffineTransformMakeTranslation(0, 100);
        _tableview.alpha = 0;
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    }
    return _tableview;
}

-(TTIndexBar *)sectionIndexView{
    if (!_sectionIndexView) {
        _sectionIndexView = [[TTIndexBar alloc]initWithFrame:CGRectMake(self.frame.size.width-30, CGRectGetMinY(self.tableview.frame), 30, self.tableview.frame.size.height)];
        _sectionIndexView.textColor = KKRGBA(204, 204, 204, 1);
        _sectionIndexView.selectedTextColor = KKRGBA(26, 102, 255, 1);
        _sectionIndexView.selectedBackgroundColor = [UIColor clearColor];
        _sectionIndexView.delegate = self;
    }
    return _sectionIndexView;
}

@end
