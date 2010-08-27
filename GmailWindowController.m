//
//  GmailWindowController.m
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "GmailWindowController.h"
#import "NullRequestHandler.h"

@implementation GmailWindowController

- (id)initWithWebView:(WebView *)newWebView {
	// This loads in the WebView that we were surreptitiously
	// loading in the background via NullRequestHandler.
	self = [super initWithWindowNibName:@"GmailWindow"];
	replacementWebView = newWebView;
	return self;
}

- (void)windowDidLoad {
	if(replacementWebView) {
		[webView removeFromSuperview];
		webView = replacementWebView;
		NSRect frame = [[[self window] contentView] frame];
		[webView setFrame:frame];
		[webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
		[[[self window] contentView] addSubview:webView];
	}

	[webView setGroupName:@"Gmail"];
	[webView setDownloadDelegate:self];
	[webView setFrameLoadDelegate:self];
	[webView setPolicyDelegate:self];
	[webView setResourceLoadDelegate:self];
	[webView setUIDelegate:self];
	[[webView preferences] setDefaultFontSize:16];
	[webView setCustomUserAgent:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8"];

	if(![webView mainFrameURL]) {
		[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mail.google.com"]]];
	}
}

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame {
	[[self window] setTitle:title];
}

// This handles standard new window links
- (void)webView:(WebView *)webView decidePolicyForNewWindowAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request newFrameName:(NSString *)frameName decisionListener:(id < WebPolicyDecisionListener >)listener {
	[listener ignore];
	[[NSWorkspace sharedWorkspace] openURL:[request URL]];
}

// This handles new windows created via JavaScript
// Note: there's a longstanding WebKit bug that passes a null request
// in many cases. That's why we work around it with the NullRequestHandler crap.
- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request {
	NSLog(@"popup clicked");
	NullRequestHandler *nullHandler = [[NullRequestHandler alloc] init];
	[nullHandler loadRequest:request];
	return [nullHandler webView];
}

@end