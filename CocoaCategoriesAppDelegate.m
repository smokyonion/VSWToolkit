//
//  CocoaCategoriesAppDelegate.m
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import "CocoaCategoriesAppDelegate.h"
#import "SCToolkit.h"

@implementation CocoaCategoriesAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (IBAction)openSysPrefPane:(id)sender
{
	NSWorkspace *ws = [NSWorkspace sharedWorkspace];
	[ws openSystemPreference:kSCSystemPrefencesUniversalAccess];
}

@end
