//
//  AppDelegate.m
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "MyDocument.h"

@implementation AppDelegate

- (IBAction)showMainWindow:(id)sender
{
	[self applicationShouldOpenUntitledFile:NSApp];
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	NSArray *docs = [[NSDocumentController sharedDocumentController] documents];
	if([docs count] > 0) {
		MyDocument *mainDoc = [docs objectAtIndex:0];
		[mainDoc showWindow];
		return NO;
	}
	
	return YES;
}

@end
