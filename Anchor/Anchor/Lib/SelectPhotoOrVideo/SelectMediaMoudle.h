//
//  SelectMediaMoudle.h
//  selectPhotoVideo
//
//  Created by 小草 on 2021/7/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 媒体所选类型
typedef NS_ENUM(NSUInteger, SelectImageOrVideoType) {
    SelectOnlyImageType, // 只显示图片
    SelectMoreImageType, // 显示多张图片
    SelectOnlyVideoType // 只显示视频
};

@interface SelectMediaMoudle : NSObject

// 选择进入媒体类型 视频还是图片
@property (nonatomic,assign) SelectImageOrVideoType mediaType;

@property (nonatomic,assign) NSInteger ImageNumMax;
// show
-(void)showMedia:(UIViewController *)vc;

// 选择了单张图片,回调
@property (nonatomic, copy) void (^didSelectSingleImage)(UIImage * image);

// 选择了多张进行回调
@property (nonatomic, copy) void (^didSelectMoreImages)(NSArray *images,NSArray *aeests);

// 选择了单个视频，回调视频地址
@property (nonatomic, copy) void (^didSelectSingleVideo)(NSString * videoPath);

// 选择了单个视频完成回调
@property (nonatomic, copy) void (^didSelectSingleVideoComplete)(void);

// 保存图片到相册
-(void)saveCurrentImage:(UIImage *)saveImage;

// 保存视频到相册
-(void)saveCurrentVideo:(NSString *)VideoPath;

// 获取当前控制器
- (UIViewController *)getCurrentVC;

/// 点击网络图片查看图片详情
/// @param photoDataSource 图片数据
/// @param selectIndex 当前选择的下标
/// @param superView 父视图
/// @param imageArr 视图数组
/// @param type 传值类型 0图片父视图是cell  1图片父视图是imageView
-(void)showPhotoArray:(NSMutableArray<NSString *> *)photoDataSource
          selectIndex:(NSInteger)selectIndex
            superView:(UIView *)superView
            imageViewArr:(NSMutableArray*)imageArr
             withType:(NSString *)type
             withPictureThumbnailsArray:(NSMutableArray *)ThumbnailsArray;

/// 点击本地图片查看图片详情
/// @param photoArr 图片数据
/// @param selectIndex 当前选择的下标
/// @param superView 父视图
/// @param imageArr 视图数组
-(void)showLocalPhotoArray:(NSMutableArray<UIImage *> *)photoArr
          selectIndex:(NSInteger)selectIndex
            superView:(UIView *)superView
            imageViewArr:(NSMutableArray*)imageArr;

/// 点击本地图片查看图片详情
/// @param photoArr 图片数据
/// @param selectIndex 当前选择的下标
/// @param superView 父视图
/// @param imageArr 视图数组
/// @param isPublish 是否是发布
-(void)showLocalPhotoArray:(NSMutableArray<UIImage *> *)photoArr
          selectIndex:(NSInteger)selectIndex
            superView:(UIView *)superView
            imageViewArr:(NSMutableArray*)imageArr
            isPublish:(BOOL)isPublish;

@end

// 调用示例
// SelectMediaMoudle * seleMedia = [[SelectMediaMoudle alloc]init];
// seleMedia.mediaType = SelectOnlyVideoType;  选择视频传入
// seleMedia.mediaType = SelectOnlyImageType;  选择图片传入
// seleMedia.mediaType = SelectMoreImageType;  选择多张图片传入
// [seleMedia showMedia];
