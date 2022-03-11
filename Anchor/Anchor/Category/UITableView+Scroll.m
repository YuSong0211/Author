//
//  UITableView+Scroll.m
//  KK
//
//  Created by Gwynne on 2021/9/1.
//

#import "UITableView+Scroll.h"

@implementation UITableView (Scroll)

- (void)reloadDataNoScroll {
    CGPoint currentOffset = self.contentOffset;
    CGSize contentSizeBeforeInsert = self.contentSize;
    [self reloadData];
    CGSize contentSizeAfterInsert = self.contentSize;
    CGFloat deltaHeight = contentSizeAfterInsert.height - contentSizeBeforeInsert.height;
    currentOffset.y += (deltaHeight > 0 ? deltaHeight : 0);
    CGPoint finallOffset = CGPointMake(currentOffset.x, currentOffset.y);
    [self setContentOffset:finallOffset animated:NO];
}

@end
