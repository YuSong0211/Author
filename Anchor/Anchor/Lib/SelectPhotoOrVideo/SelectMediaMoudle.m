//
//  SelectMediaMoudle.m
//  selectPhotoVideo
//
//  Created by 小草 on 2021/7/2.
//

#import "SelectMediaMoudle.h"
#import "TZImagePickerController.h"
#import "NSObject+Privacy.h"
#import "LBPhotoBrowserManager.h"
// 屏幕的宽高
#define KK_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define KK_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SelectMediaMoudle ()<TZImagePickerControllerDelegate>

@end

@implementation SelectMediaMoudle

// 显示
-(void)showMedia:(UIViewController *)vc{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.allowCameraLocation = NO;
    imagePickerVc.allowTakeVideo = YES; // 允许编辑视频
    // 是否显示选中的遮罩蒙版
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    // 选中的遮罩蒙版透明度
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    // 最少选择几张图片
    imagePickerVc.minImagesCount = 1;
    // 是否可以多选视频和图片
    imagePickerVc.allowPickingMultipleVideo = NO;
    // 在单选模式下，照片列表页中，显示选择按钮,默认为NO
    imagePickerVc.showSelectBtn = NO;
    // 当前选择的类型
    if (self.mediaType == SelectOnlyImageType) {
        // 是否需要选择视频
        imagePickerVc.allowPickingVideo = NO;
        // 是否选择图片
        imagePickerVc.allowPickingImage = YES;
        // 允许裁剪师不能选原图和gif
        imagePickerVc.allowCrop = YES;
    }else if (self.mediaType == SelectMoreImageType){
        // 是否需要选择视频
        imagePickerVc.allowPickingVideo = NO;
        // 是否选择图片
        imagePickerVc.allowPickingImage = YES;
        // 最大选择几张
        imagePickerVc.maxImagesCount = self.ImageNumMax;
        // 是否可以多选
        imagePickerVc.allowPickingMultipleVideo = YES;
        // 允许裁剪，不能选原图和gif
        imagePickerVc.allowCrop = NO;
        // 在单选模式下，照片列表页中，显示选择按钮,默认为NO
        imagePickerVc.showSelectBtn = YES;
    }else if(self.mediaType == SelectOnlyVideoType){
        // 是否需要选择视频
        imagePickerVc.allowPickingVideo = YES;
        // 是否选择图片
        imagePickerVc.allowPickingImage = NO;
    }
    // 默认为YES，如果设置为NO,原图按钮将隐藏，用户不能选择发送原图
    imagePickerVc.allowPickingOriginalPhoto = NO;
    // 是否可以选中动图
    imagePickerVc.allowPickingGif = NO;
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    // 是否需要圆形裁剪框
    imagePickerVc.needCircleCrop =  NO;
    // 导航相关设置
    imagePickerVc.naviBgColor = [UIColor colorWithRed:20 / 255.0 green:21 / 255.0 blue:27 / 255.0 alpha:1.0]; // 导航栏颜色
    imagePickerVc.naviTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = KK_SCREEN_WIDTH - 2 * left;
    NSInteger top = KK_SCREEN_HEIGHT /2 -(widthHeight / 2);
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (self.mediaType == SelectOnlyImageType) {
            if (photos.count > 0 && self.didSelectSingleImage) {
                // 选择返回图片
                self.didSelectSingleImage(photos[0]);
            }
        }else{
            if (self.didSelectMoreImages) {
                self.didSelectMoreImages(photos,assets);
            }
        }
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:imagePickerVc animated:YES completion:nil];
}

// 当前选择视频回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    if (self.didSelectSingleVideoComplete) {
        self.didSelectSingleVideoComplete();
    }
    //     给视频压缩过的路径可以直接使用
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetHighestQuality success:^(NSString *outputPath) {
            if (self.didSelectSingleVideo) {
                self.didSelectSingleVideo(outputPath);
            }
        } failure:^(NSString *errorMessage, NSError *error) {
            UIAlertView * altView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"导出视频出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [altView show];
        }];
    
    //    直接给视频在相册的路径
//    [[TZImageManager manager]requestVideoURLWithAsset:asset success:^(NSURL *videoURL) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSString * videoUrl = [NSString stringWithFormat:@"%@",videoURL];
//            if (self.didSelectSingleVideo) {
//                self.didSelectSingleVideo(videoUrl);
//            }
//        });
//    } failure:^(NSDictionary *info) {
//        UIAlertView * altView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"导出视频出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        [altView show];
//    }];
}

// 获取当前控制器
//获取View所在的Viewcontroller
- (UIViewController *)getCurrentVC{
    // 定义一个变量存放当前屏幕显示的viewcontroller
    UIViewController *result = nil;
    // 得到当前应用程序的主要窗口
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // windowLevel是在 Z轴 方向上的窗口位置，默认值为UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal)
    {
        // 获取应用程序所有的窗口
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            // 找到程序的默认窗口（正在显示的窗口）
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                // 将关键窗口赋值为默认窗口
                window = tmpWin;
                break;
            }
        }
    }
    // 获取窗口的当前显示视图
    UIView *frontView = [[window subviews] objectAtIndex:0];
    
    // 获取视图的下一个响应者，UIView视图调用这个方法的返回值为UIViewController或它的父视图
    id nextResponder = [frontView nextResponder];
    
    // 判断显示视图的下一个响应者是否为一个UIViewController的类对象
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}


-(void)saveCurrentImage:(UIImage *)saveImage{
    [self checkPrivacyEnableWithAlert:YES WithType:PhotoLibraryPrivacy withResult:^(BOOL result) {
        if (result == YES) {
            UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
    } withCancel:^{
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (error) {
        // 失败
        [SVProgressHUD showMessage:@"保存失败"];
    } else {
        // 成功
        [SVProgressHUD showMessage:@"保存成功"];
    }
}


-(void)saveCurrentVideo:(NSString *)VideoPath{
    [self checkPrivacyEnableWithAlert:YES WithType:PhotoLibraryPrivacy withResult:^(BOOL result) {
        if (result == YES) {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum(VideoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    } withCancel:^{}];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        // 失败
        [SVProgressHUD showMessage:@"保存失败"];
    } else {
        // 成功
        [SVProgressHUD showMessage:@"保存成功"];
    }
}

/// 点击图片查看图片详情
/// @param photoDataSource 图片数据
/// @param selectIndex 当前选择的下标
/// @param superView 父视图
/// @param type 传值类型 0图片父视图是cell  1图片父视图是imageView
-(void)showPhotoArray:(NSMutableArray<NSString *> *)photoDataSource
          selectIndex:(NSInteger)selectIndex
            superView:(UIView *)superView
         imageViewArr:(NSMutableArray *)imageArr
             withType:(NSString *)type withPictureThumbnailsArray:(NSMutableArray *)ThumbnailsArray{
    LBPhotoBrowserManager.defaultManager.isPublishPreview = NO;
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    NSMutableArray * localArr= [NSMutableArray array];
    if (LBPhotoBrowserManager.defaultManager.photoBrowserView) {
        return;
    }
//    if ([type isEqualToString:@"1"]) {
//        for (int i =0; i<photoDataSource.count; i ++) {
//            NSString *imageUrl = photoDataSource[i];
//            [localArr addObject:imageUrl];
//            KKChatWorkOrderCollectionViewCell *cell = imageArr[i];
//            LBPhotoWebItem * item = [[LBPhotoWebItem alloc]initWithURLString:imageUrl frame:cell.frame];
//            [imageArray addObject:item];
//        }
//        [LBPhotoBrowserManager.defaultManager showImageWithWebItems:imageArray selectedIndex:selectIndex fromImageViewSuperView:superView withEasyArr:localArr];
//    }else{
//        for (int i =0; i<photoDataSource.count; i ++) {
//            NSString *imageUrl = photoDataSource[i];
//            UIImageView *imageView = imageArr[i];
//            LBPhotoWebItem * item = [[LBPhotoWebItem alloc]initWithURLString:imageUrl frame:imageView.frame];
//            [imageArray addObject:item];
//        }
//
//
//        [LBPhotoBrowserManager.defaultManager showImageWithWebItems:imageArray selectedIndex:selectIndex fromImageViewSuperView:superView withEasyArr:ThumbnailsArray];
//    }
}
/// 点击本地图片查看图片详情
/// @param photoArr 图片数据
/// @param selectIndex 当前选择的下标
/// @param superView 父视图
/// @param imageArr 视图数组
-(void)showLocalPhotoArray:(NSMutableArray<UIImage *> *)photoArr
          selectIndex:(NSInteger)selectIndex
            superView:(UIView *)superView
              imageViewArr:(NSMutableArray*)imageArr{
    
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    
    for (int i =0; i<photoArr.count; i ++) {
        UIImage *image = photoArr[i];
        UIImageView *imageView = imageArr[i];
        LBPhotoLocalItem *item = [[LBPhotoLocalItem alloc]initWithImage:image frame:imageView.frame];
        [imageArray addObject:item];
    }
    LBPhotoBrowserManager.defaultManager.isPublishPreview = NO;
    [LBPhotoBrowserManager.defaultManager showImageWithLocalItems:imageArray selectedIndex:selectIndex fromImageViewSuperView:superView];
}

-(void)showLocalPhotoArray:(NSMutableArray<UIImage *> *)photoArr
          selectIndex:(NSInteger)selectIndex
            superView:(UIView *)superView
            imageViewArr:(NSMutableArray*)imageArr
                 isPublish:(BOOL)isPublish {
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    
    for (int i =0; i<photoArr.count; i ++) {
        UIImage *image = photoArr[i];
        UIImageView *imageView = imageArr[i];
        LBPhotoLocalItem *item = [[LBPhotoLocalItem alloc]initWithImage:image frame:imageView.frame];
        [imageArray addObject:item];
    }
    LBPhotoBrowserManager.defaultManager.isPublishPreview = isPublish;
    [LBPhotoBrowserManager.defaultManager showImageWithLocalItems:imageArray selectedIndex:selectIndex fromImageViewSuperView:superView];
}


@end
