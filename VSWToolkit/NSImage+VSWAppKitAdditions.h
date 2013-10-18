//
//  NSImage+VSWAppKitAdditions.h
//  VSWToolkit
//
//  Created by Vincent Wang on 10/18/13.
//  Copyright (c) 2013 Vincent Wayne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (VSWAppKitAdditions)

/**
 *  Simply a shorter version of -CGImageForProposedRect:NULL context:nil hints:nil;
 *
 *  @return The CGImageRef returned is guaranteed to live as long as the current autorelease pool.
 */
- (CGImageRef)vsw_CGImage;

@end

// must be after all #includes / #imports
CF_IMPLICIT_BRIDGING_ENABLED

CF_EXPORT CGImageRef VSWCreateThumbnailImageFromURL(NSURL *fileURL, CGFloat maxDimension, BOOL createAlways) CF_RETURNS_RETAINED;

CF_IMPLICIT_BRIDGING_DISABLED