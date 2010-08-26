//
//  GmailWindow.m
//  Gmail
//
//  Created by Tyler Hall on 8/25/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "BrowserWindow.h"


@implementation BrowserWindow

// This is so we can close the winodw and then re-open
// without reloading the WebView. Primarily, this is awesome
// for backgrounding Gmail with voice/video chats open.
- (void)performClose:(id)sender
{
	[self setIsVisible:NO];
}

@end
