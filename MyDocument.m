//
//  MyDocument.m
//  Gmail
//
//  Created by Tyler Hall on 8/25/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (NSString *)windowNibName
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
	[stupidHack setTitle:@"Gmail"];
	[webView setGroupName:@"Browser"];
	[webView setDownloadDelegate:self];
	[webView setFrameLoadDelegate:self];
	[webView setPolicyDelegate:self];
	[webView setResourceLoadDelegate:self];
	[webView setUIDelegate:self];
	[[webView preferences] setDefaultFontSize:16];
	[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mail.google.com"]]];
	[webView setCustomUserAgent:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8"];
}

- (WebView *)webView
{
	return webView;
}

- (void)showWindow
{
	[stupidHack setIsVisible:YES];
}

- (void)webView:(WebView *)webView decidePolicyForNewWindowAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request newFrameName:(NSString *)frameName decisionListener:(id < WebPolicyDecisionListener >)listener
{
	[listener ignore];
	[[NSWorkspace sharedWorkspace] openURL:[request URL]];
}

- (void)webView:(WebView *)sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener
{
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

// The following two delegate methods are the way they are in order to work around a
// WebKit bug that returns a null request object for some JavaScript initiated window.open()'s.
// Anyone know a solution that doesn't suck so much? (I wonder how Fluid.app handles this?)
- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
	MyDocument *myDocument = [[NSDocumentController sharedDocumentController] openUntitledDocumentOfType:@"DocumentType" display:YES];
	[[[myDocument webView] mainFrame] loadRequest:request];
	return [myDocument webView];
}

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
	if(frame == [sender mainFrame])
	{
		NSString *url = [sender mainFrameURL];
		if(url && [url length] > 0)
		{
			if(![url isEqualToString:@"https://mail.google.com/"])
			{
				[self setWindow:stupidHack];
				[stupidHack setIsVisible:YES];
			}
		}
	}
}

@end
