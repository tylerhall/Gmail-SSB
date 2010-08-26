//
//  MyDocument.h
//  Gmail
//
//  Created by Tyler Hall on 8/25/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface MyDocument : NSDocument
{
	IBOutlet WebView *webView;
	IBOutlet NSWindow *stupidHack;
}

- (WebView *)webView;
- (void)showWindow;

@end
