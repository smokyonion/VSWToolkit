//
//  NSUserDefaults+Additions.m
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import "NSUserDefaults+Additions.h"


@implementation NSUserDefaults (Additions)

+ (void)reset
{
	[[self standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
	[[self standardUserDefaults] synchronize];
}

@end
