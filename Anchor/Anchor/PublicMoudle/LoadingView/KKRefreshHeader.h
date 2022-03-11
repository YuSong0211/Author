//
//  KKRefreshHeader.h
//  KK
//
//  Created by Gwynne on 2021/7/7.
//

#import <MJRefresh/MJRefresh.h>
@class KKRefreshFooter;


NS_ASSUME_NONNULL_BEGIN

@interface KKRefreshHeader : MJRefreshHeader //下拉刷新

@property (nonatomic,strong) KKRefreshFooter * footer;


@end

NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN

@interface KKRefreshFooter : MJRefreshAutoFooter //上拉加载

-(void)removeLoadingView;

@property (nonatomic,strong) UILabel * noMoreDataLab; // 没有更多数据
 
@end

NS_ASSUME_NONNULL_END

