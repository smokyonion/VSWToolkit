//
//  NSImage+Additions.m
//  seksi
//
//  Created by vincent on 8/17/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import "NSImage+Additions.h"

// Remember to import QuickLook framework into your project!
#import <QuickLook/QuickLook.h>


@implementation NSImage (Additions)



#pragma mark CGImage to NSImage and vice versa

+ (NSImage*)imageFromCGImageRef:(CGImageRef)image
{
#if MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_5
	// This is 10.6 only
    NSImage *newImage = [[[NSImage alloc] initWithCGImage:image 
													 size:NSZeroSize] autorelease];
#else
    NSRect imageRect = NSMakeRect(0.0, 0.0, 0.0, 0.0);
    CGContextRef imageContext = nil;
    NSImage *newImage = nil;
	
    // Get the image dimensions.
    imageRect.size.height = CGImageGetHeight(image);
    imageRect.size.width = CGImageGetWidth(image);
	
    // Create a new image to receive the Quartz image data.
    newImage = [[[NSImage alloc] initWithSize:imageRect.size] autorelease];
    [newImage lockFocus];
	
    // Get the Quartz context and draw.
    imageContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextDrawImage(imageContext, *(CGRect*)&imageRect, image);
    [newImage unlockFocus];
#endif
	
    return newImage;
}

- (CGImageRef)cgImageRef
{
	NSData *imageData = [self TIFFRepresentation];
    CGImageRef imageRef;
    
	if(imageData) {
#if MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_5		
		imageRef = [self CGImageForProposedRect:NULL context:nil hints:nil]; //10.6
#else
		imageRef = [[NSBitmapImageRep imageRepWithData:imageData] CGImage]; //10.5
#endif
		return imageRef;
    }
	
	// original approach
	//if (imageData) {
		
		//CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
		//imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
		//CFRelease(imageSource);
		
		// [(id)aCGImageRef autorelease];
		// Be carefull when you mix CFType memory management, and obj-c memory management. 
		// It works well when you do not use GC, but may become problematic if you do not take special care with GC code.
		// If I'm not wrong, it should be something like this:
		// [NSMakeCollectable(aCGImageRef) autorelease]
		
		// bad: memory leak
		//return imageRef;
		
		// good: no memory leak
		//[NSMakeCollectable(imageRef) autorelease];
		//return imageRef;
	//}
	
	return NULL;
}



#pragma mark Quicklook Preview

+ (NSImage *)imageWithPreviewOfFileAtPath:(NSString *)path ofSize:(NSSize)size asIcon:(BOOL)icon
{
	
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    if (!path || !fileURL) {
        return nil;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:icon] 
                                                     forKey:(NSString *)kQLThumbnailOptionIconModeKey];
    CGImageRef ref = QLThumbnailImageCreate(kCFAllocatorDefault, 
                                            (CFURLRef)fileURL, 
                                            CGSizeMake(size.width, size.height),
                                            (CFDictionaryRef)dict);
    
    if (ref != NULL) {
        // Take advantage of NSBitmapImageRep's -initWithCGImage: initializer, new in Leopard,
        // which is a lot more efficient than copying pixel data into a brand new NSImage.
        // Thanks to Troy Stephens @ Apple for pointing this new method out to me.
        NSBitmapImageRep *bitmapImageRep = [[NSBitmapImageRep alloc] initWithCGImage:ref];
        NSImage *newImage = nil;
        if (bitmapImageRep) {
            newImage = [[NSImage alloc] initWithSize:[bitmapImageRep size]];
            [newImage addRepresentation:bitmapImageRep];
            [bitmapImageRep release];
            
            if (newImage) {
				CFRelease(ref);
                return [newImage autorelease];
            }
        }
        CFRelease(ref);
    } else {
        // If we couldn't get a Quick Look preview, fall back on the file's Finder icon.
        NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:path];
        if (icon) {
            [icon setSize:size];
        }
        return icon;
    }
	
    return nil;
}



#pragma mark Resizing Image


+ (NSImage *)resizedImage:(NSImage *)sourceImage 
				  newSize:(NSSize)size 
		  lockAspectRatio:(BOOL)lock // pass YES if you want to lock aspect ratio
   lockAspectRatioByWidth:(BOOL)flag // pass YES to lock aspect ratio by width or passing NO to lock by height
{
	NSSize oldSize = [sourceImage size];
	CGFloat ratio = oldSize.width / oldSize.height;
	// if new size is equal to or larger than the original image, we won't resize it
	if (size.height >= oldSize.height || size.width >= oldSize.width) 
		return sourceImage;
	
	if (lock) {
		if (flag)
			size.height = size.width / ratio;
		else
			size.width = size.height * ratio;
	}
	
	NSImage *resizedImage = [[NSImage alloc] initWithSize:size];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[resizedImage lockFocus];
	
	[sourceImage drawInRect:NSMakeRect(0.0, 0.0, size.width, size.height) 
				   fromRect:NSMakeRect(0.0, 0.0, [sourceImage size].width, [sourceImage size].height) 
				  operation:NSCompositeSourceOver fraction:1.0];
	
	[resizedImage unlockFocus];
	
	return [resizedImage autorelease];
}



#pragma mark Cropping Image

- (NSImage *)croppedImage:(CGRect)bounds
{
	NSImage *image = [self retain];
	[image lockFocus];
    CGImageRef imageRef = CGImageCreateWithImageInRect([image cgImageRef], bounds);
	NSImage *croppedImage = [NSImage imageFromCGImageRef:imageRef];
    CGImageRelease(imageRef);
	[image unlockFocus];
	[image release];
    return croppedImage;
}



#pragma mark Save Image

- (BOOL)saveImage:(NSString *)path fileName:(NSString *)name fileType:(NSBitmapImageFileType)type
{	
	// deal with the file type and assign the filename suffix by the file type
	NSString *suffix;
	NSString *filename = [NSString stringWithString:name];;
	switch (type) {
		case NSTIFFFileType:
			suffix = @".tiff";
			if (![name hasSuffix:suffix]) 
				filename = [name stringByAppendingString:suffix];
			break;
		case NSBMPFileType:
			suffix = @".bmp";
			if (![name hasSuffix:suffix]) 
				filename = [name stringByAppendingString:suffix];
			break;
		case NSGIFFileType:
			suffix = @".gif";
			if (![name hasSuffix:suffix]) 
				filename = [name stringByAppendingString:suffix];
			break;
		case NSJPEGFileType:
			suffix = @".jpg";
			if (![name hasSuffix:suffix]) 
				filename = [name stringByAppendingString:suffix];
			break;
		case NSPNGFileType:
			suffix = @".png";
			if (![name hasSuffix:suffix]) 
				filename = [name stringByAppendingString:suffix];
			break;
		case NSJPEG2000FileType:
			suffix = @".jp2";
			if (![name hasSuffix:suffix]) 
				filename = [name stringByAppendingString:suffix];
			break;
		default:
			break;
	}

	NSString *destination = [path stringByAppendingPathComponent:filename];
	NSBitmapImageRep *bmpImageRep = [[NSBitmapImageRep alloc] initWithData:[self TIFFRepresentation]];
	NSData *data = [bmpImageRep representationUsingType:type properties:nil];
	[bmpImageRep release];
	
	return [data writeToFile:destination atomically:NO];
}

@end
