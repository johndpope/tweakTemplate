//
//  UIImage+UIInage_GrayData.m
//  MTGLHOOK
//
//  Created by hongyangyi on 15/11/25.
//
//

#import "UIImage+UIInage_GrayData.h"

@implementation UIImage (UIInage_GrayData)
+ (UIImage*) imageWithGrayData:(unsigned char*) pGrayData width:(int)width height:(int) height
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (pGrayData,width,height,8,width,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGImageRef cgImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [[UIImage alloc] initWithCGImage:cgImageRef];
    CGImageRelease(cgImageRef);
    CGContextRelease(context);
    return grayImage;
}

@end
