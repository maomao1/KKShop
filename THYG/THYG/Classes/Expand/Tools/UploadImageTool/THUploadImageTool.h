//
//  THUploadImageTool.h
//  THYG
//
//  Created by Victory on 2018/5/25.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
// ** 宏定义单例模式方便外界调用
#define UPLOAD_IMAGE [THUploadImageTool shareUploadImage]

@protocol THUploadImageToolDelegate <NSObject>

@optional
/** 处理图片的方法*/
- (void)uploadImageToServerWithImage:(UIImage *)image;
@end

@interface THUploadImageTool : NSObject <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) id <THUploadImageToolDelegate> uploadImageDelegate;
@property(nonatomic,strong) UIViewController * fatherViewController;

// ** 单例方法
+ (THUploadImageTool *)shareUploadImage;

// ** 弹出选项窗口的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC delegate:(id<THUploadImageToolDelegate>)aDelegate;

@end
