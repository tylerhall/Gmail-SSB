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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingCall:) name:@"INCOMING_CALL" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingVideo:) name:@"INCOMING_VIDEO" object:nil];
	
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

- (void)incomingCall:(NSNotification *)notification {
	[self overlayImageNamed:@"phone"];
	[NSApp requestUserAttention:NSCriticalRequest];
}

- (void)incomingVideo:(NSNotification *)notification {
	[NSApp requestUserAttention:NSCriticalRequest];
}

- (void)overlayImageNamed:(NSString *)imageName {
	float size = [[NSApp dockTile] size].width * .5;
	float offset = [[NSApp dockTile] size].width - size;
	
	NSImage *overlay = [NSImage imageNamed:@"phone"];
	NSImage *icon = [NSApp applicationIconImage];
	[icon lockFocus];
	CGContextRef ctxt = [[NSGraphicsContext currentContext] graphicsPort];
	CGImageSourceRef source;
	source = CGImageSourceCreateWithData((CFDataRef)[overlay TIFFRepresentation], NULL);
	CGImageRef maskRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
	CGContextDrawImage(ctxt, NSMakeRect(offset, offset, size, size), maskRef);
	[icon unlockFocus];
	[NSApp setApplicationIconImage:icon];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
	[NSApp setApplicationIconImage:[NSImage imageNamed:@"Icon"]];
}

@end
