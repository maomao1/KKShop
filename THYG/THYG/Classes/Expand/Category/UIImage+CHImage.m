//
//  UIImage+CHImage.m
//  CheHu
//
//  Created by Victory on 2017/6/12.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import "UIImage+CHImage.h"

@implementation UIImage (CHImage)

+ (UIImage*)systemImageToGray:(UIImage*)image {
    int width = image.size.width;
    int height = image.size.height;
    
    //第一步：开辟颜色空间
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    //第二步：创建颜色空间的上下文
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0,colorSpaceRef, kCGImageAlphaNone);
    
    if (contextRef == nil) {
        return nil;
    }
    
    //第三步：渲染图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), image.CGImage);
    
    //第四步：创建图片 将绘制的颜色空间转成CGImage
    CGImageRef grayImageRef = CGBitmapContextCreateImage(contextRef);
    
    //第五步：将C/C++图片转成UIImage
    UIImage * newImage = [UIImage imageWithCGImage:grayImageRef];
    
    //释放内存
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
    CGImageRelease(grayImageRef);
    return newImage;
}

+ (UIImage *)imageWithOrignalImageNamed:(NSString *)image {
    UIImage *img = [UIImage imageNamed:image];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage*)imageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (instancetype)circleImage {
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将裁剪的图片绘制上去
    [self drawInRect:rect];
    // 获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    return  image;
}

+ (instancetype)circleImageWithName:(NSString *)name {
    return [[self imageNamed:name] circleImage];
}

+ (UIImage *)imgCompressed:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        
        NSAssert(!newImage,@"图片压缩失败");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)stretchableImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image  = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    return image;
}

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}

// 改变图像的尺寸
- (UIImage *)scaleToSize:(CGSize) size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO ,0.0);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  创建占位图片
 *
 *  @param size  创建的图片的大小
 *  @param image 水印图片
 *  @param color 背景颜色
 */
+ (UIImage *)placeholderImageWithSize:(CGSize)size image:(UIImage *)image backgroundColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = color;
    UIImageView *placeholderImgView = [[UIImageView alloc] initWithImage:image];
    placeholderImgView.center = view.center;
    [view addSubview:placeholderImgView];
    
    UIGraphicsBeginImageContext(size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *placeholderImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return placeholderImage;
}

+ (UIImage *)createPlaceholderImageWithSize:(CGSize)size
{
//    Color_G7
    return [self placeholderImageWithSize:size image:[UIImage imageNamed:@"ad_normal"] backgroundColor:BGColor];
}

- (void)setImgAndSizeWithImg:(UIImage *)img{
    
}

@end
