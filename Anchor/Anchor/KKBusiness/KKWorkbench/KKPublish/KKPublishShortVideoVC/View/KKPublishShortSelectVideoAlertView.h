//
//  KKPublishShortSelectVideoAlertView.h
//  KK
//
//  Created by ProgramMa on 2021/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKPublishShortSelectVideoAlertView : UIView
// 当前上传进度 （包含上传图像 上传视频，回调我们自己的服务器）
@property (nonatomic, assign)CGFloat uploadProgress;
@property (nonatomic, assign)CGFloat uploadProgressone;
// 选择的icon
@property (nonatomic, strong)UIImage *selectImage;
//
@property(nonatomic, copy) void (^releseSueccesBlock) (void); //

@property(nonatomic, copy) void (^cancelButtonClickBlock) (void);//

- (void)showInView;
- (void)dissmisView;

@end

NS_ASSUME_NONNULL_END
