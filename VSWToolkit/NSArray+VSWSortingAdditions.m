//
//  NSArray+VSWSortingAdditions.m
//  VSWToolkit
//
//  Created by Vincent Wayne on 10/18/13.
//  Copyright (c) 2013 Vincent Wayne. All rights reserved.
//

#import "NSArray+VSWSortingAdditions.h"

@implementation NSArray (VSWSortingAdditions)

- (NSArray *)vsw_reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end
