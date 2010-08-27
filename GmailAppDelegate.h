//
//  GmailAppDelegate.h
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class GmailWindowController;

@interface GmailAppDelegate : NSObject <NSApplicationDelegate> {
	GmailWindowController *mainWindowController;
}

- (IBAction)showMainWindow:(id)sender;
- (void)overlayImageNamed:(NSString *)imageName;
- (void)incomingVideo:(NSNotification *)notification;
- (void)incomingCall:(NSNotification *)notification;

@end
