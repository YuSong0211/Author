//
//  MenuItemCell.m
//  KK
//
//  Created by hk on 2021/6/24.
//

#import "MenuItemCell.h"

@implementation MenuItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self addSubview:self.title];
        [self addSubview:self.content];
        [self addSubview:self.btn_forward];
    }
    return self;
    
}

-(UILabel*)title{
    if(_title == nil){
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10,(60-14)/2, 100,14 )];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textColor = [KKColor getColor:appMainTextColor];
        _title.text = self.celldata.title;
    }
    return _title;
}

-(UILabel*)content{
    if(_content == nil){
        _content = [[UILabel alloc] initWithFrame:CGRectMake(KK_SCREEN_WIDTH-120,(60-14)/2, 100,14 )];
        _content.font = [UIFont systemFontOfSize:14];
        _content.textAlignment = NSTextAlignmentRight;
        _content.textColor = [KKColor getColor:appMainTextColor];
        _content.text = self.celldata.content;
    }
    return _content;
}

-(UIImageView*)btn_forward{
    if(_btn_forward == nil){
        _btn_forward = [[UIImageView alloc] initWithFrame:CGRectMake(KK_SCREEN_WIDTH-20, (60-15)/2, 15, 15)];
        UIImage* image = [UIImage imageNamed:@"foward_btn"];
        [_btn_forward setImage:image];
        
    }
    return _btn_forward;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandlerAction:)];
    [self addGestureRecognizer:tap];
    
    
    
    UILongPressGestureRecognizer *taplong = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandlerlongAction:)];
    [ self addGestureRecognizer:taplong];
}

- (void)tapHandlerlongAction:(UITapGestureRecognizer *)sender
{
    if(self.delegate!=NULL){
        [self.delegate onLongClick:self.celldata.index];
    }
    
}

//单击
- (void)tapHandlerAction:(UITapGestureRecognizer *)sender
{
    if(self.delegate!=NULL){
        [self.delegate onClick:self.celldata.index];
    }
    
}

- (void)setData:(MenuItem *)data{
    self.celldata = data;
    self.title.text = data.title;
    self.content.text = data.content;
}

@end
