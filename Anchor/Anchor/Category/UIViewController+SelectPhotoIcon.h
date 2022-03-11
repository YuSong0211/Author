//
//  UIViewController+SelectPhotoIcon.h
//  BBSelectUserIcon
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (SelectPhotoIcon)<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

- (UIImagePickerController *)imagePickerController;
/**
 *  调用相册
 */
- (void)showActionSheet;
- (void)useCamera;
- (void)usePhoto;



@end
