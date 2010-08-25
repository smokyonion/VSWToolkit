//
//  NSImage+Additions.h
//  seksi
//
//  Created by vincent on 8/17/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface NSImage (Additions)

/*!
    @method     
    @abstract   converting a CGImageRef to NSImage
    @discussion 
*/
+ (NSImage*)imageFromCGImageRef:(CGImageRef)image;



/*!
    @method     
    @abstract   converting a NSImage to CGImageRef
    @discussion 
*/
- (CGImageRef)cgImageRef;



// Borrowed from Matt Legend Gemmell
// http://mattgemmell.com/source/
// A category on NSImage allowing you to get an image containing 
// a Quick Look preview of the file at a given path. You can specify the size, 
// and whether the preview should be rendered as an icon (i.e. with a document border, 
// drop-shadow, page-curl and file type/extension label superimposed). 
// If Quick Look can’t generate a preview for the specified file, 
// you’ll be given the file’s Finder icon instead 
// (which is how the Quick Look panel itself behaves in Leopard).
+ (NSImage *)imageWithPreviewOfFileAtPath:(NSString *)path 
								   ofSize:(NSSize)size 
								   asIcon:(BOOL)icon;


/*!
    @method     
    @abstract   converting the input NSImage to a new size
    @discussion 
*/
+ (NSImage *)resizedImage:(NSImage *)sourceImage 
				  newSize:(NSSize)size 
		  lockAspectRatio:(BOOL)lock // pass YES if you want to lock aspect ratio
   lockAspectRatioByWidth:(BOOL)flag; // pass YES to lock aspect ratio by width or passing NO to lock by height



/*!
    @method     
    @abstract   returning an cropped NSImage
    @discussion 
*/
- (NSImage *)croppedImage:(CGRect)bounds;



/*!
    @method     
    @abstract   save image to disk
    @discussion 
*/
- (BOOL)saveImage:(NSString *)path 
		 fileName:(NSString *)name 
		 fileType:(NSBitmapImageFileType)type;

@end
