//
//  SafariBar.h
//  Gmail
//
//  Created by Tyler Hall on 8/27/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SafariBar : NSView {
	NSString *stringValue;
}

- (void)setStringValue:(NSString *)newStringValue;

@end
