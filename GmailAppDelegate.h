//
//  GmailAppDelegate.h
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Growler.h"

@class GmailWindowController;

@interface GmailAppDelegate : NSObject <NSApplicationDelegate, GrowlApplicationBridgeDelegate> {
	GmailWindowController *mainWindowController;
	BOOL voiceBounce;
	BOOL videoBounce;
	BOOL chatBounce;
}

- (IBAction)showMainWindow:(id)sender;
- (void)incomingVideo:(NSNotification *)notification;
- (void)incomingCall:(NSNotification *)notification;
- (void)incomingChat:(NSNotification *)notification;
- (void)unreadCountChanged:(NSNotification *)notification;
- (IBAction)toggleFullscreen:(id)sender;

@end
