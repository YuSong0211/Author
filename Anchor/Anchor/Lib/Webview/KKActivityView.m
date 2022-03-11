//
//  KKActivityView.m
//  richers
//
//  Created by Gwynne on 2022/1/23.
//

#import "KKActivityView.h"
#import "KKWebActiveCollectionCell.h"

@interface KKActivityView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation KKActivityView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

//字符串转数组

- (id)toArrayOrNSDictionary:(NSString *)jsonData{

    if (jsonData != nil) {

        NSData* data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];

        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        

        if (jsonObject != nil){

            return jsonObject;

        }else{

            // 解析错误

            return nil;

        }

    }

    return nil;

}

-(void)setParams:(NSDictionary *)params{
    _params = params;
    if ([params objectForKey:@"listJSON"]) {
        self.dataArray = [self toArrayOrNSDictionary:[params objectForKey:@"listJSON"]];
        //[self.collectionView reloadData];
        if (self.dataArray.count >0) {
            if (self.parmeToDataArrBlock) {
                self.parmeToDataArrBlock(YES);
            }
        }
    }
}


- (void)initSubViews {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[KKWebActiveCollectionCell class] forCellWithReuseIdentifier:@"KKWebActiveCollectionCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    return CGSizeMake((KK_SCREEN_WIDTH)/2, 153);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    KKWebActiveCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKWebActiveCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.dic = self.dataArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"activeSelectItem" object:[dic objectForKey:@"id"]];
}

@end
