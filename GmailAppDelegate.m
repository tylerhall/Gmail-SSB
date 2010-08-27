//
//  GmailAppDelegate.m
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "GmailAppDelegate.h"
#import "GmailWindowController.h"

@implementation GmailAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	mainWindowController = [[GmailWindowController alloc] initWithWindowNibName:@"GmailWindow"];
	[mainWindowController showWindow:self];
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender {
	[self showMainWindow:self];
	return NO;
}

- (IBAction)showMainWindow:(id)sender {
	[[mainWindowController window] setIsVisible:YES];
}

@end
