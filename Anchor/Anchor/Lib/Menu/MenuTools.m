//
//  MenuTools.m
//  KK
//
//  Created by hk on 2021/6/24.
//

#import "MenuTools.h"

@interface MenuTools()<IOnClickEvent,UITableViewDelegate,UITableViewDataSource>
    
    //存放的tableview
    @property (strong,nonatomic) UITableView *tableview;
    @property (strong,nonatomic) NSString* identifierclass;
    
@end

@implementation MenuTools

 

- (MenuTools *)initWithParam:(NSMutableArray<MenuItem *> *)array :(Class)cellclass :(int)cellheight{
    self.cellclass = cellclass;
    self.cellheight = cellheight;
    self.menuList = array;
    return self;
}

- (void)addItem:(MenuItem *)menu{
    if(self.menuList == nil){
        self.menuList = [[NSMutableArray alloc] init];
    }
    [self.menuList addObject:menu];
}

- (void)addRangeItem:(NSMutableArray<MenuItem *> *)array{
    if(self.menuList == nil){
        self.menuList = [[NSMutableArray alloc] init];
    }
    [self.menuList addObjectsFromArray:array];
}

- (UIView *)create{
     
    self.identifierclass = NSStringFromClass(self.cellclass);
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KK_SCREEN_WIDTH, KK_SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.tableview registerClass:self.cellclass forCellReuseIdentifier:self.identifierclass];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.backgroundColor = [UIColor blackColor];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableview setTableFooterView:[UIView new]];
    [view addSubview:self.tableview];
    return view;
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CMenuCell* cell = [self.tableview dequeueReusableCellWithIdentifier:self.identifierclass forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:self.menuList[indexPath.row]];
    cell.delegate = self;
    
    return  cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"pppp");
    return  self.menuList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellheight;
}

- (void)onClick:(int)index{
    NSLog(@"click");
}

- (void)onLongClick:(int)index{
    
    NSLog(@"on long click");
}

@end
