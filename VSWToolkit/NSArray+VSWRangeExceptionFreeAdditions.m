//
//  NSArray+VSWRangeExceptionFreeAdditions.m
//  VSWToolkit
//
//  Created by Vincent Wayne on 10/18/13.
//  Copyright (c) 2013 Vincent Wayne. All rights reserved.
//

#import "NSArray+VSWRangeExceptionFreeAdditions.h"

@implementation NSArray (VSWRangeExceptionFreeAdditions)

- (BOOL)vsw_containsIndex:(NSUInteger)index
{
    return NSLocationInRange(index, NSMakeRange(0, [self count]));
}

- (instancetype)vsw_firstObject
{
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
//    return [self firstObject];
//#elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_6
//    return [self firstObject];
//#endif
    return [self vsw_objectAtIndex:0];
}

- (instancetype)vsw_objectAtIndex:(NSUInteger)index
{
    return ([self vsw_containsIndex:index] ? self[index] : nil);
}

- (NSArray *)vsw_subarrayFromIndex:(NSUInteger)index
{
    NSUInteger count = [self count];
    NSUInteger length = count - index;
    
    if ([self vsw_containsIndex:index]) {
        //http://stackoverflow.com/questions/8592289/arc-the-meaning-of-unsafe-unretained
        id __unsafe_unretained objects[length];
        [self getObjects:objects range:NSMakeRange(index, length)];
        return [NSArray arrayWithObjects:&objects[index] count:length];
    }
    
    return nil;
}


@end
