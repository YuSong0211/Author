//
//  DoMainUrlItem.m
//  KK
//
//  Created by hk on 2021/8/31.
//

#import "DoMainUrlItem.h"

@implementation DoMainUrlItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.updateList = [[NSMutableArray alloc] init];
        self.ucList = [[NSMutableArray alloc] init];
        self.apiList = [[NSMutableArray alloc] init];
        self.appVlink = [[NSMutableArray alloc] init];
        self.noticeResource = [[NSMutableArray alloc] init];
        self.appvGrayscaleLink = [[NSMutableArray alloc] init];;
    }
    return self;
}

@end

