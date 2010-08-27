//
//  SafariBar.m
//  Gmail
//
//  Created by Tyler Hall on 8/27/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "SafariBar.h"


@implementation SafariBar

- (void)drawRect:(NSRect )aRect {
	NSBezierPath *path;
	NSGradient *gradient;
	
	// Top Border
	path = [[NSBezierPath alloc] init];
	[[NSColor colorWithDeviceWhite:0 alpha:1.0] set];
	[path setLineWidth:1.0];
	[path moveToPoint:NSMakePoint(aRect.origin.x, aRect.origin.y + aRect.size.height)];
	[path lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y + aRect.size.height)];
	[path stroke];	

	// Top Border 2
	path = [[NSBezierPath alloc] init];
	[[NSColor colorWithDeviceWhite:0.8156 alpha:1.0] set];
	[path setLineWidth:1.0];
	[path moveToPoint:NSMakePoint(aRect.origin.x, aRect.origin.y + aRect.size.height - 1)];
	[path lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y + aRect.size.height - 1)];
	[path stroke];	
	
	// Middle gradient
	gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceRed:0.6901 green:0.6901 blue:0.6901 alpha:1.0]
											 endingColor:[NSColor colorWithDeviceRed:0.6549 green:0.6549 blue:0.6549 alpha:1.0]];
	NSRect topRect = aRect;
	topRect.origin.y += 1;
	topRect.size.height -= 3;
	[gradient drawInRect:topRect angle:90];

	// Bottom Border
	path = [[NSBezierPath alloc] init];
	[[NSColor colorWithDeviceWhite:0.4666 alpha:1.0] set];
	[path setLineWidth:1.0];
	[path moveToPoint:NSMakePoint(aRect.origin.x, aRect.origin.y)];
	[path lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y)];
	[path stroke];
	
	// Status Text
	if(stringValue && [stringValue length] > 0) {
		NSFont *font = [NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]];
		
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,
							  [NSColor colorWithDeviceWhite:0 alpha:1.0], NSForegroundColorAttributeName, nil];
		
		NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Go to %@", stringValue] attributes:dict];
		[str drawInRect:NSMakeRect(12, -2, aRect.size.width, aRect.size.height)];
	}
}

- (void)setStringValue:(NSString *)newStringValue {
	stringValue = [NSString stringWithString:newStringValue];
	[self setNeedsDisplay:YES];
}

@end
