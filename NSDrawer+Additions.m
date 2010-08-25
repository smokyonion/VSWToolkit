//
//  NSDrawer+Additions.m
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import "NSDrawer+Additions.h"


@implementation NSDrawer (Additions)

- (IBAction)toggleByFixedEdge:(id)sender
{
	//	typedef enum {
	//		NSMinXEdge = 0, // left
	//		NSMinYEdge = 1, // bottom
	//		NSMaxXEdge = 2, // right
	//		NSMaxYEdge = 3	// top
	//	} NSRectEdge;
	
	NSRect screenFrame = [[[NSScreen screens] objectAtIndex:0] visibleFrame];
	NSRect windowFrame = [_drawerParentWindow frame];
	NSRect drawerFrame = [[[self contentView] window] frame];
	
	//	NSLog(@"Screen Size H: %f", screenFrame.size.height);
	//	NSLog(@"Screen Size W: %f", screenFrame.size.width);
	//	NSLog(@"Screen X: %f", screenFrame.origin.x);
	//	NSLog(@"Screen Y: %f", screenFrame.origin.y);
	//	NSLog(@"Window Size H: %f", windowFrame.size.height);
	//	NSLog(@"Window Size W: %f", windowFrame.size.width);
	//	NSLog(@"Window X: %f", windowFrame.origin.x);
	//	NSLog(@"Window Y: %f", windowFrame.origin.y);
	//	NSLog(@"Draw Size H: %f", drawerFrame.size.height);
	//	NSLog(@"Draw Size W: %f", drawerFrame.size.width);
	//	NSLog(@"Draw X: %f", drawerFrame.origin.x);
	//	NSLog(@"Draw Y: %f", drawerFrame.origin.y);
	
	NSRectEdge edge = [self preferredEdge];
	if (NSDrawerOpenState == [self state]) {
        [self close];
	}
	else {
		if (NSMinXEdge == edge) {
			// left edge
			if (drawerFrame.size.width > windowFrame.origin.x && windowFrame.size.width != screenFrame.size.width ) {
				float offset = (drawerFrame.size.width) - windowFrame.origin.x;
				
				NSRect newRect = NSMakeRect(windowFrame.origin.x + offset, 
											windowFrame.origin.y,
											windowFrame.size.width,
											windowFrame.size.height);
				
				[_drawerParentWindow setFrame:newRect display:YES animate:YES];
			}
			else if (drawerFrame.size.width > windowFrame.origin.x && windowFrame.size.width == screenFrame.size.width ) {
				float offset = (drawerFrame.size.width) - windowFrame.origin.x;
				
				NSRect newRect = NSMakeRect(windowFrame.origin.x + offset, 
											windowFrame.origin.y,
											windowFrame.size.width - offset,
											windowFrame.size.height);
				
				[_drawerParentWindow setFrame:newRect display:YES animate:YES];
			}
			[self openOnEdge:NSMinXEdge];
		}
		else if (NSMinYEdge == edge) {
			//bottom edge
			if (drawerFrame.size.height > windowFrame.origin.y && windowFrame.size.height != screenFrame.size.height) {
				// when UI window was not expanded to max
				float offset = (drawerFrame.size.height) - windowFrame.origin.y;
				
				NSRect newRect = NSMakeRect(windowFrame.origin.x, 
											windowFrame.origin.y + offset,
											windowFrame.size.width,
											windowFrame.size.height);
				
				[_drawerParentWindow setFrame:newRect display:YES animate:YES];
			}
			else if (drawerFrame.size.height > windowFrame.origin.y && windowFrame.size.height == screenFrame.size.height) {
				// when UI window was expanded to max
				float offset = (drawerFrame.size.height) - windowFrame.origin.y;
				
				NSRect newRect = NSMakeRect(windowFrame.origin.x, 
											windowFrame.origin.y + offset,
											windowFrame.size.width,
											windowFrame.size.height - offset); //resize the window
				
				[_drawerParentWindow setFrame:newRect display:YES animate:YES];
			}
			
			[self openOnEdge:NSMinYEdge];
		}
		else if (NSMaxXEdge == edge) {
			// right edge
			if (windowFrame.size.width + 
				windowFrame.origin.x +
				drawerFrame.size.width > screenFrame.size.width) {
				float offset = (windowFrame.size.width + 
								windowFrame.origin.x + 
								drawerFrame.size.width) - screenFrame.size.width;
				
				NSRect newRect = NSMakeRect(windowFrame.origin.x - offset, 
											windowFrame.origin.y,
											windowFrame.size.width,
											windowFrame.size.height);
				
				[_drawerParentWindow setFrame:newRect display:YES animate:YES];
			}
			
			[self openOnEdge:NSMaxXEdge]; 
		}
		else if (NSMaxYEdge == edge) {
			//top edge
			if (windowFrame.size.height + 
				windowFrame.origin.y + 
				drawerFrame.size.height > screenFrame.size.height) {
				
				float offset = (windowFrame.size.height + 
								windowFrame.origin.y + 
								drawerFrame.size.height) - screenFrame.size.height;
				
				NSRect newRect = NSMakeRect(windowFrame.origin.x, 
											windowFrame.origin.y - offset,
											windowFrame.size.width,
											windowFrame.size.height);
				
				[_drawerParentWindow setFrame:newRect display:YES animate:YES];
			}
			[self openOnEdge:NSMaxYEdge]; 
		}
	}
	
}

@end
