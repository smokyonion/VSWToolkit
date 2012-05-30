//
//  NSString+Additions.h
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * @file NSString+Additions.h
 *
 * Header file for NSString cocoa additions.
 */

/**
 * @class NSString
 *
 * Category additions to NSString.
 */

/**
 * Category additions to NSString.
 */
@interface NSString (Additions)

/**
 * Returns a c UTF8 string.
 */
- (const char *)cstring;

/**
 * Wether or not the string is equal to @"".
 */
- (BOOL)isEmpty;

/**
 * Whether or not the string contains a space.
 */
- (BOOL)containsSpace;

/**
 * Whether or not this string is empty or contains a space.
 */
- (BOOL)isEmptyOrContainsSpace;

/**
 * Whether or not the string contains passed string.
 */
- (BOOL)containsString:(NSString *)aString;

@end
