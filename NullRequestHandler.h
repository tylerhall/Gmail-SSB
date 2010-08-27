//
//  NullRequestHandler.h
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface NullRequestHandler : NSObject {
	WebView *webView;
}

- (WebView *)webView;
- (void)loadRequest:(NSURLRequest *)request;

@end
