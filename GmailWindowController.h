//
//  GmailWindowController.h
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class SafariBar;

@interface GmailWindowController : NSWindowController {
	IBOutlet WebView *webView;
	IBOutlet SafariBar *statusBar;
	WebView *replacementWebView;
}

- (id)initWithWebView:(WebView *)newWebView;

@end
