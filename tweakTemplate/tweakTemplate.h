#ifndef __TWEAK_TEMPLATE__
#define __TWEAK_TEMPLATE__

#include <stdio.h>
#include "defs.h"
//cydia substrate
#include <substrate.h>
#include <logos/logos.h>
#include <mach/mach.h>
#include <mach-o/dyld.h>

//ios
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>


#import "YYHelper.h"
#import "UIImage+UIInage_GrayData.h"
#import "UIImage+ARGBData.h"

@interface ImageBuf : NSObject
{
    
}
- (void)releaseRGBAImageBuf;
@property(nonatomic) int64_t  bytesPerPixel;
@property(nonatomic) int64_t  height;
@property(nonatomic) int64_t  width;
@property(nonatomic) unsigned char*  rawData;


@end


@interface FacedpsEngine : NSObject
{
    
}

@end

@interface FaceDAInfo : NSObject
{
    
}
@property(nonatomic) int64_t  landmarkSize;
@property(nonatomic) float*  pfFaceLandmarks;
@end


#endif