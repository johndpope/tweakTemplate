//
//  UIImage.m
//  M-SecretChat
//
//  Created by 洪阳熠 on 15/3/16.
//  Copyright (c) 2015年 洪阳熠. All rights reserved.
//
#import "UIImage+ARGBData.h"


@implementation UIImage(UIImage_ARGBData)

- (unsigned char*) ARGBData;
{
    
    int width = (int)CGImageGetWidth(self.CGImage);
    int height = (int)CGImageGetHeight(self.CGImage);
    if(width == 0 || height == 0)
        return 0;
    unsigned char* imageData = (unsigned char *) malloc(4 * width * height);
    
    CGColorSpaceRef cref = CGColorSpaceCreateDeviceRGB();
    CGContextRef gc = CGBitmapContextCreate(imageData,
                                            width,height,
                                            8,width*4,
                                            cref,MT_ALPHALOCATION);
    CGColorSpaceRelease(cref);
    UIGraphicsPushContext(gc);
    
    CGRect rect = CGRectMake(0, 0, width, height);//{{ 0 , 0 }, {width, height }};
    CGContextDrawImage( gc, rect, self.CGImage );
    UIGraphicsPopContext();
    CGContextRelease(gc);
    
    
    return imageData;// CGBitmapContextGetData(gc);
}


+ (UIImage *)initwithImageData:(unsigned char *)imagedata size:(CGSize )size orientation:(UIImageOrientation)orientation;
{
    return [[UIImage alloc] initwithImageData:imagedata size:size orientation:orientation];
}

-(id)initwithImageData:(unsigned char *)imagedata size:(CGSize )size orientation:(UIImageOrientation)orientation;
{
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, imagedata, size.width * size.height * 4, nil);
    
    
    CGColorSpaceRef defaultRGBColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef cgImageFromBytes = CGImageCreate((int)size.width, (int)size.height, 8, 32, 4 * (int)size.width, defaultRGBColorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaLast, dataProvider, NULL, NO, kCGRenderingIntentDefault);
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgImageFromBytes];
    
   // UIImage *finalImage = [UIImage imageWithCGImage:cgImageFromBytes];
    
    CGImageRelease(cgImageFromBytes);
    CGDataProviderRelease(dataProvider);
    CGColorSpaceRelease(defaultRGBColorSpace);
    return finalImage;
}

@end

