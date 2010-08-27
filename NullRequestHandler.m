//
//  NullRequestHandler.m
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "NullRequestHandler.h"
#import "GmailWindowController.h"

@implementation NullRequestHandler

- (id)init {
	self = [super init];
	webView = [[WebView alloc] init];
	[webView setGroupName:@"Gmail"];
	[webView setDownloadDelegate:self];
	[webView setFrameLoadDelegate:self];
	[webView setPolicyDelegate:self];
	[webView setResourceLoadDelegate:self];
	[webView setUIDelegate:self];
	[[webView preferences] setDefaultFontSize:16];
	[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mail.google.com"]]];
	[webView setCustomUserAgent:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8"];
	return self;
}

- (WebView *)webView {
	return webView;
}

- (void)loadRequest:(NSURLRequest *)request {
	[[webView mainFrame] loadRequest:request];
}

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame {
	if(frame == [sender mainFrame]) {
		NSString *url = [sender mainFrameURL];
		if(url && [url length] > 0) {
			if(![url isEqualToString:@"https://mail.google.com/"]) {
				GmailWindowController *newWindowController = [[GmailWindowController alloc] initWithWebView:webView];
				[newWindowController showWindow:self];
			}
		}
	}
}

- (void)webView:(WebView *)sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener {
	NSString *urlStr = [[request URL] absoluteString];
	if(request) {
		NSRange range = [urlStr rangeOfString:@"google.com"];
		if(range.location == NSNotFound) {
			[listener ignore];
			[[NSWorkspace sharedWorkspace] openURL:[request URL]];
		}
	}
	
	[listener use];
}


@end
