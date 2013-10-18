//
//  VSWNSArrayExceptionFreeTest.m
//  VSWToolkit
//
//  Created by Vincent Wang on 10/18/13.
//  Copyright (c) 2013 Vincent Wayne. All rights reserved.
//

#import "VSWToolkit.h"
#import <XCTest/XCTest.h>

@interface VSWNSArrayExceptionFreeTest : XCTestCase

@end

@implementation VSWNSArrayExceptionFreeTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testOutOfBoundsIndex
{
    NSArray *cats = @[@"Cheeta", @"Tiger", @"Lion", @"Meow"];
    NSString *cat = [cats vsw_objectAtIndex:4]; // should not crash and return nil
    XCTAssertNil(cat, @"there should be no cats");
}

@end
