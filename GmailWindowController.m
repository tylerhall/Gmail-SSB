//
//  GmailWindowController.m
//  Gmail
//
//  Created by Tyler Hall on 8/26/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "GmailWindowController.h"
#import "NullRequestHandler.h"
#import "SafariBar.h"
#import "RegexKitLite.h"
#import "GmailWindow.h"

@implementation GmailWindowController

- (id)initWithWindow:(NSWindow *)window andWebView:(WebView *)newWebView {
	self = [super initWithWindow:window];
	replacementWebView = newWebView;
	return self;
}

- (id)initWithWebView:(WebView *)newWebView {
	// This loads in the WebView that we were surreptitiously
	// loading in the background via NullRequestHandler.
	self = [super initWithWindowNibName:@"GmailWindow"];
	replacementWebView = newWebView;
	[[self window] setFrameAutosaveName:@""];
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
	[webView setContinuousSpellCheckingEnabled:YES];
	[webView setShouldCloseWithWindow:NO];
	[webView setCustomUserAgent:@"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8"];

	if(![webView mainFrameURL]) {
		[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mail.google.com"]]];
	}
	
	[[self window] setMovableByWindowBackground:YES];

	unreadTimer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:unreadTimer forMode:NSDefaultRunLoopMode];
}

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame {
	[[self window] setTitle:title];
	
	NSRange videoCall = [title rangeOfString:@"Incoming video"];
	if(videoCall.location != NSNotFound)
		[[NSNotificationCenter defaultCenter] postNotificationName:@"INCOMING_VIDEO" object:nil userInfo:nil];

	NSRange phoneCall = [title rangeOfString:@"Incoming voice"];
	if(phoneCall.location != NSNotFound)
		[[NSNotificationCenter defaultCenter] postNotificationName:@"INCOMING_CALL" object:nil userInfo:nil];

	NSRange newChat = [title rangeOfString:@"says…"];
	if(newChat.location != NSNotFound)
		[[NSNotificationCenter defaultCenter] postNotificationName:@"INCOMING_CHAT" object:nil userInfo:nil];
}

- (void)webView:(WebView *)sender mouseDidMoveOverElement:(NSDictionary *)elementInformation modifierFlags:(NSUInteger)modifierFlags {
	if(elementInformation != nil) {
		NSURL *href = [elementInformation valueForKey:@"WebElementLinkURL"];
		if(href) {
			[statusBar setStringValue:[href absoluteString]];
		} else {
			[statusBar setStringValue:@""];
		}
	}
	else {
		[statusBar setStringValue:@""];
	}
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
	NullRequestHandler *nullHandler = [[NullRequestHandler alloc] init];
	[nullHandler loadRequest:request];
	return [nullHandler webView];
}

-(void)webView:(WebView *)sender setFrame:(NSRect)frame {
	[[self window] setFrame:frame display:YES];
}

// From: http://cocoawithlove.com/2009/08/animating-window-to-fullscreen-on-mac.html
- (void)toggleFullscreen {
	if(oldFrame.size.width > 0)
	{
		[[self window] setFrame:oldFrame display:YES animate:YES];
		oldFrame.size.width = 0;
		[[self window] setFrameAutosaveName:@"MainWindow"];

		if([[[self window] screen] isEqual:[[NSScreen screens] objectAtIndex:0]])
		{
			if([NSApp respondsToSelector:@selector(setPresentationOptions:)])
				[NSApp setPresentationOptions:NSApplicationPresentationDefault];
			else
				[NSMenu setMenuBarVisible:YES];
		}
	}
	else
	{
		[[self window] deminiaturize:nil];
		oldFrame = [[self window] frame];
		
		if([[[self window] screen] isEqual:[[NSScreen screens] objectAtIndex:0]])
		{
			if([NSApp respondsToSelector:@selector(setPresentationOptions:)])
				[NSApp setPresentationOptions:NSApplicationPresentationAutoHideMenuBar | NSApplicationPresentationAutoHideDock];
			else
				[NSMenu setMenuBarVisible:NO];
		}

		[[self window] setFrameAutosaveName:@""];
		[[self window] setFrame:[[self window] frameRectForContentRect:[[[self window] screen] frame]] display:YES animate:YES];
	}
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	if(frame == [sender mainFrame]) {
		WebScriptObject *ws = [webView windowScriptObject];
		NSString *js = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gmailssb" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
		[ws evaluateWebScript:js];
	}
}

- (void)checkUnreadCount {
	WebScriptObject *ws = [webView windowScriptObject];
	id count = [ws callWebScriptMethod:@"gmailSSBUnreadCount" withArguments:nil];
	if(!count || (count == [WebUndefined undefined]))
		[[NSNotificationCenter defaultCenter] postNotificationName:@"UNREAD_COUNT_CHANGED" object:nil userInfo:nil];
	else
		[[NSNotificationCenter defaultCenter] postNotificationName:@"UNREAD_COUNT_CHANGED" object:nil userInfo:[NSDictionary dictionaryWithObject:count forKey:@"count"]];
}

@end
