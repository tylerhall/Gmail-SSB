//
//  Growler.m
//  Incoming PrefPane
//
//  Created by Tyler Hall on 8/23/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "Growler.h"

static Growler *sharedGrowler;

@implementation Growler

- (id)init
{
	self = [super init];	
	[GrowlApplicationBridge setGrowlDelegate:self];
	return self;
}

+ (Growler *)sharedGrowler
{
	if(sharedGrowler == nil)
		sharedGrowler = [[Growler alloc] init];
	return sharedGrowler;
}

- (NSDictionary *)registrationDictionaryForGrowl
{
	NSArray *notes = [NSArray arrayWithObjects:@"Incoming Voice Call", @"Incoming Video Call", @"New Chat Message", nil];
	return [NSDictionary dictionaryWithObjectsAndKeys:notes, GROWL_NOTIFICATIONS_ALL, notes, GROWL_NOTIFICATIONS_DEFAULT, nil];
}

- (void)growlWithTitle:(NSString *)title 
		   description:(NSString *)description 
	  notificationName:(NSString *)notificationName
			  iconData:(NSData *)iconData
			   context:(id)context
{
	[GrowlApplicationBridge notifyWithTitle:title
								description:description
						   notificationName:notificationName
								   iconData:iconData
								   priority:0
								   isSticky:NO
							   clickContext:context];
}

- (void)growlNotificationWasClicked:(id)clickContext
{
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:clickContext]];
}

@end
