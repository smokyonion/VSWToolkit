//
//  NSString+Additions.m
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import "NSString+Additions.h"


@implementation NSString (Additions)

- (const char *)cstring
{
	return [self UTF8String];
}

- (BOOL)isEmpty
{
	return [self isEqual:@""];
}

- (BOOL)containsSpace
{
	NSRange s = [self rangeOfString:@" "];
	if (!(s.location == NSNotFound)) return YES;
	return NO;
}

- (BOOL)isEmptyOrContainsSpace
{
	if ([self isEmpty]) return YES;
	if ([self containsSpace]) return YES;
	return NO;
}

- (BOOL)containsString:(NSString *)aString
{
	NSRange s = [self rangeOfString:aString];
	if (!(s.location == NSNotFound)) return YES;
	return NO;
}
@end
