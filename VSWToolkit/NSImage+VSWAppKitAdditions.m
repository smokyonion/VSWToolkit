//
//  NSImage+VSWAppKitAdditions.m
//  VSWToolkit
//
//  Created by Vincent Wang on 10/18/13.
//  Copyright (c) 2013 Vincent Wayne. All rights reserved.
//

#import "NSImage+VSWAppKitAdditions.h"

@implementation NSImage (VSWAppKitAdditions)

- (CGImageRef)vsw_CGImage
{
    return [self CGImageForProposedRect:NULL context:nil hints:nil];
}

@end

CGImageRef VSWCreateThumbnailImageFromURL(NSURL *fileURL, CGFloat maxDimension, BOOL createAlways)
{
    if (maxDimension < 0) {
        NSLog(@"max dimension should not be smaller than 1");
        return nil;
    }
    
    CFStringRef createOption = kCGImageSourceCreateThumbnailFromImageAlways;
    if (!createAlways) createOption = kCGImageSourceCreateThumbnailFromImageIfAbsent;
    
    
    NSDictionary *options = @{ (NSString *)kCGImageSourceShouldAllowFloat               : (id)kCFBooleanTrue,
                               (NSString *)kCGImageSourceCreateThumbnailWithTransform   : (id)kCFBooleanTrue, // conforms to orientation
                               (NSString *)kCGImageSourceThumbnailMaxPixelSize          : @(maxDimension),
                               (__bridge NSString *)createOption                        : (id)kCFBooleanTrue };
    
    CGImageSourceRef src = CGImageSourceCreateWithURL((__bridge CFURLRef)fileURL, NULL);
    CGImageRef thumbnail = CGImageSourceCreateThumbnailAtIndex(src, 0, (__bridge CFDictionaryRef)options);
    CFRelease(src);
    
    return thumbnail;

}