//
//  NSArray+VSWRangeExceptionFreeAdditions.h
//  VSWToolkit
//
//  Created by Vincent Wayne on 10/18/13.
//  Copyright (c) 2013 Vincent Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (VSWRangeExceptionFreeAdditions)


- (BOOL)vsw_containsIndex:(NSUInteger)index;

/**
 *  Returns the first object in the array.
 *
 *  @return The first object in the array. If the array is empty, returns nil.
 */
- (instancetype)vsw_firstObject NS_DEPRECATED(10_0, 10_6, 2_0, 4_0, "Use -firstObject instead");

/**
 *  Returns the object located at the specified index. This method provides the same functionality as objectAtIndex: but is NSRangeException free.
 *
 *  @param index the index of the object
 *
 *  @return The object located at index.
            If index is beyond the end of the array (that is, if index is greater than or equal to the value returned by count), returns nil.
 */
- (instancetype)vsw_objectAtIndex:(NSUInteger)index;

- (NSArray *)vsw_subarrayFromIndex:(NSUInteger)index;


@end
