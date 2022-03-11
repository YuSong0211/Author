//
//  UIViewController+SelectPhotoIcon.m
//  BBSelectUserIcon
//
//

#import "UIViewController+SelectPhotoIcon.h"

#define NAVBAR_COLOR    [UIColor whiteColor]

@implementation UIViewController (SelectPhotoIcon)


- (UIImagePickerController *)imagePickerController
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    return imagePickerController;
}

- (void)showActionSheet
{
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *addPhoneAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self useCamera];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self usePhoto];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [actionSheet addAction:addPhoneAction];
        [actionSheet addAction:photoAction];
        [actionSheet addAction:cancelAction];
        [self presentViewController:actionSheet animated:true completion:nil];
}

-(void)useCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = self.imagePickerController;
        //允许编辑
        imagePicker.allowsEditing=true;
        //设置图片源
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //模态弹出IamgePickerView
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }else{
        //    NSLog(@"模拟器不支持拍照功能");
    }
}

-(void)usePhoto{
    [UIApplication sharedApplication].statusBarHidden = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = self.imagePickerController;
        //允许编辑
        imagePicker.allowsEditing = true;
        //设置图片源
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //模态弹出IamgePickerView
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}





@end
