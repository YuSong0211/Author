//
//  BaseCollectionCell.m
//  KK
//
//  Created by hk on 2021/8/5.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}


- (void)layoutSubviews{
    
}

- (void)initSubViews {
    
}

- (void)setModel:(id)model{
    self.cellModel = model;
}

@end
