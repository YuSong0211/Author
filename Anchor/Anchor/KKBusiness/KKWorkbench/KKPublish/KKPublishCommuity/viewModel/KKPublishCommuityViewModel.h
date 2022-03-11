//
//  KKPublishCommuityViewModel.h
//  mt
//
//  Created by 小草 on 2021/11/8.
//

#import <Foundation/Foundation.h>
#import "KKUploadSuperModel.h"
#import "KKUploadInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol KKPublishCommuityViewModelDelegate <NSObject>


/// 单文本上传完成
/// @param commuityType 网络返回状态  成功 || 失败
-(void)singleTextUploadComplte:(KKUploadState)commuityType;


/// 媒体资源上传完成
/// @param commuityType 网络返回状态  成功 || 失败
-(void)mediaSourceUploadComplte:(KKUploadState)commuityType
                       progress:(CGFloat)progress
                  isGetProgress:(BOOL)isGetProgress
                    uploadModel:(KKUploadInfoModel* )uploadModel;

@end

@interface KKPublishCommuityViewModel : NSObject

// 代理
@property (nonatomic,weak)id<KKPublishCommuityViewModelDelegate>delegate;

/// 单文本上传
/// @param singleText 需要发布的文字
/// @param tagArray 标签数据
-(void)singleTextToUpload:(NSString *)singleText
                 tagArray:(NSMutableArray *)tagArray;


/// 媒体资源上传
/// @param content 文本
/// @param tagArray 标签数据
/// @param fileModel 文件model
-(void)mediaSourceUploadWithText:(NSString *)content
                        tagArray:(NSMutableArray *)tagArray
                       fileModel:(KKUploadInfoModel *)fileModel;



-(void)commuityCancelUpload:(BOOL)isNofiService;
@end

NS_ASSUME_NONNULL_END
