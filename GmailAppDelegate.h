//
//  GmailAppDelegate.h
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class GmailWindowController;

@interface GmailAppDelegate : NSObject <NSApplicationDelegate> {
	GmailWindowController *mainWindowController;
}

- (IBAction)showMainWindow:(id)sender;

@end
