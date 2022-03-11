//
//  KKAltStyleConfig.m
//  KK
//
//  Created by 小草 on 2021/9/1.
//

#import "KKAltStyleConfig.h"

@implementation KKAltStyleConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cornerRadius = 13;
        self.viewBackgroundColor = @"#1E1E1E";
        self.backGroundColor = @"#000000";
        self.isClickDismss = YES;
        self.itemConfigArray = [[NSMutableArray alloc] init];
    }
    return self;
}

/// 构造
/// @param title 标题
/// @param content 内容
+ (KKAltStyleConfig *)initWithTitleAndContent:(NSString *)title content:(NSString *)content{
    KKAltStyleConfig* model = [[KKAltStyleConfig alloc] init];
    model.title = title;
    model.content = content;
    return model;
}

/// 设置是否可以点击
/// @param enable 是否可以点击
- (KKAltStyleConfig *)setViewEnable:(BOOL)enable{
    self.isClickDismss = enable;
    return self;
}

@end
