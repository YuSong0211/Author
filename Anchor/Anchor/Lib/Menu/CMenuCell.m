//
//  CMenuCell.m
//  KK
//
//  Created by hk on 2021/6/24.
//

#import "CMenuCell.h"

@implementation CMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(MenuItem *)data{
    self.celldata = data;
}

@end
