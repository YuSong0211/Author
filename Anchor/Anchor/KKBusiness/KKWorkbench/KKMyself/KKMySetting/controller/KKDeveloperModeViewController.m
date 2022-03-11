//
//  KKDeveloperModeViewController.m
//  mt
//
//  Created by Gwynne on 2021/10/19.
//

#import "KKDeveloperModeViewController.h"
#import "KKKKDeveloperModeCell.h"
#import "KKWebViewEventModel.h"
#import "AppDelegate.h"
#import "KKLayoutViewAlertView.h"
#import "UITextView+Placeholder.h"
@interface KKDeveloperModeViewController ()

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong)NSString *uuidStr;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong) UIImageView *arrowsView;
@end

@implementation KKDeveloperModeViewController

- (NSMutableArray *)dataArray {
    return @[@{@"title":@"清理UUID",@"value":self.uuidStr},
             @{@"title":@"获取Webview参数",@"value":@""},
             @{@"title":@"灰度模式",@"value":[KKUserInfo share].grayscale ? @"开启" : @"关闭"}].mutableCopy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    self.title = @"开发者模式";
}

- (void)createUI {
    self.uuidStr = kStringIsEmpty([KKTool getUUIDByKeyChain])?@"":[KKTool getUUIDByKeyChain] ;
    [self addTableViewWithIdentifiers:@[@"KKKKDeveloperModeCell"] isConfigRefresh:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KKKKDeveloperModeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKKKDeveloperModeCell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.titleLabel.text = dict[@"title"];
    cell.valueLabel.text = dict[@"value"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
        [KKTool showSystemAlertWithTitle:@"警告" message:@"确定清除UUID吗？" leftText:@"清除" rightText:@"取消" isShowCancel:YES leftAction:^{
         
            [KKTool clearUDID];
            self.uuidStr = @"";
            [self.tableView reloadData];
            [KKTool showSystemAlertWithTitle:@"警告" message:@"清除成功后请重启app" leftText:@"重新登陆" rightText:@"退出" isShowCancel:YES leftAction:^{
                
               
                AppDelegate *dele =(AppDelegate*) [UIApplication sharedApplication].delegate;
                [dele setTingWindow];
            } rightAction:^{
                exit(0);
            }];
        } rightAction:^{
            
        }];
    }else if (indexPath.row == 1) {
        NSString *webviewParams = [KKWebViewEventModel callbackTwoWebviewConversionData:YES];
//        UIPasteboard * copyLink = [UIPasteboard generalPasteboard];
//        copyLink.string = webviewParams>0?webviewParams:@"未能复制Webview参数";
//        if (copyLink == nil) {
//            [SVProgressHUD showMessage:@"复制失败"];
//        }else{
//            [SVProgressHUD showMessage:webviewParams];
            KKAltItemConfig* cancle = [KKAltItemConfig initWithItemConfig:@"取消" buttonEnable:YES];
            KKAltItemConfig* ok = [KKAltItemConfig initWithItemConfig:@"复制" buttonEnable:YES];
            KKAltStyleConfig* controller = [[KKAltStyleConfig initWithTitleAndContent:@"Webview参数" content:webviewParams] setViewEnable:NO];
            [controller.itemConfigArray addObject:cancle];
            [controller.itemConfigArray  addObject:ok];
           
            [KKLayoutViewAlertView showAltLayoutViewWithConfigModel:controller WithClickBlock:^(NSInteger clickIndex) {
                if (clickIndex ==KKAltItemStateCancle) {
                    [KKLayoutViewAlertView dismiss];
                    return;
                }else{
                    UIPasteboard * copyLink = [UIPasteboard generalPasteboard];
                    copyLink.string = webviewParams>0?webviewParams:@"未能复制Webview参数";
                    if (copyLink.string.length >0) {
                        [SVProgressHUD showMessage:@"复制成功"];
                    }else{
                        [SVProgressHUD showMessage:@"复制失败"];
                    }
                    [KKLayoutViewAlertView dismiss];
                }
            }];
//        }
    }else if (indexPath.row == 2) {
     
        [KKTool showSystemAlertWithTitle:@"警告" message:@"确定要开启或关闭灰度模式吗？" leftText:@"确定" rightText:@"取消" isShowCancel:YES leftAction:^{
            [KKUserInfo share].grayscale = ![KKUserInfo share].grayscale;
          
          
            ///重启app
            AppDelegate *dele =(AppDelegate*) [UIApplication sharedApplication].delegate;
            [dele setTingWindow];
        } rightAction:^{
            //to do
        }];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [KKColor getColor:appBgColor];
    UILabel *label = [[UILabel alloc]init];
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    label.text = @"切换地址";
    label.textColor = [KKColor getColor:appMainTextColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(15);
        make.right.equalTo(view.mas_right).offset(-80);
        make.centerY.mas_equalTo(view);
        make.height.mas_equalTo(40);
    }];
    [view addSubview:self.arrowsView];
    [self.arrowsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).inset(15);
        make.height.width.equalTo(@10);
        
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    label1.text = @"切换";
    label1.textAlignment = NSTextAlignmentRight;
    label1.textColor = [KKColor getColor:appHintTextColor];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowsView.mas_left).offset(-10);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    label1.userInteractionEnabled = YES;
    [label1 addGestureRecognizer:tap];
    return view;
    
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        [_textView setFont:[UIFont mediumWithSize:14]];
        _textView.placeholder = @"请输入地址";
        _textView.layer.masksToBounds = YES;
        [_textView.layer setCornerRadius:8];
        _textView.placeholderColor = [KKColor getColor:appHintTextColor];
        _textView.textColor = [KKColor getColor:appMainTextColor];
        _textView.backgroundColor = [KKColor getColor:appEditTextBgColor];
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
        _textView.contentInset = UIEdgeInsetsMake(0,0,10, 0);
        _textView.layoutManager.allowsNonContiguousLayout=NO;
    }
    return _textView;
}

- (UIImageView *)arrowsView {
    if (!_arrowsView) {
        _arrowsView = [[UIImageView alloc] init];
        UIImage *img=[UIImage imageNamed:@"mine_cell_arrow_ic"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrowsView.image =img;
        [_arrowsView setTintColor:[KKColor getColor:appHintTextColor]];
    }
    return _arrowsView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 60;
}

-(void)click:(UITapGestureRecognizer*)sender{
    
    NSLog(@"%@",self.textView.text);
    
    
    
}

@end
