//
//  UIImage.h
//  M-SecretChat
//
//  Created by 洪阳熠 on 15/3/16.
//  Copyright (c) 2015年 洪阳熠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define MT_ALPHALOCATION (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#else
#define MT_ALPHALOCATION kCGImageAlphaPremultipliedLast//ARGB
#endif


@interface UIImage(UIImage_ARGBData)

- (unsigned char*) ARGBData;


+(UIImage *)initwithImageData:(unsigned char*) imagedata size:(CGSize )size orientation:(UIImageOrientation)orientation;

- (id)initwithImageData:(unsigned char*) imagedata size:(CGSize )size orientation:(UIImageOrientation)orientation;

@end
