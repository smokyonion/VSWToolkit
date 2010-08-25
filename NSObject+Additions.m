//
//  NSObject+Additions.m
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import "NSObject+Additions.h"
#import <objc/runtime.h>

@implementation NSObject (Additions)

- (id)performSelectorIfRespond:(SEL)selector 
{
	if ([self respondsToSelector:selector]) return [self performSelector:selector];
	return nil;
}

- (id)performSelectorIfRespond:(SEL)selector withObject:(id)object 
{
	if ([self respondsToSelector:selector]) return [self performSelector:selector withObject:object];
	return nil;
}

- (void)associateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)weaklyAssociateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedValueForKey:(void *)key
{
	return objc_getAssociatedObject(self, key);
}

@end
