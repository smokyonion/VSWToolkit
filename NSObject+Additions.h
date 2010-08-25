//
//  NSObject+Additions.h
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSObject (Additions)

/*!
    @method     
    @abstract   Performs the selector only if the object responds to it.
    @discussion 
	@param selector The selector to perform.
*/
- (id)performSelectorIfRespond:(SEL)selector;

- (id)performSelectorIfRespond:(SEL)selector withObject:(id)object;

// http://github.com/andymatuschak/NSObject-AssociatedObjects
// A wrapper for 10.6 associated object API
// http://blog.andymatuschak.org/post/173646741/your-new-friends-obj-c-associated-objects
// By Andy Matuschak
- (void)associateValue:(id)value withKey:(void *)key; // Strong reference
- (void)weaklyAssociateValue:(id)value withKey:(void *)key;
- (id)associatedValueForKey:(void *)key;

@end
