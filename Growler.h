//
//  Growler.h
//  Incoming PrefPane
//
//  Created by Tyler Hall on 8/23/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Growl/Growl.h>

@class TwitterSearch;

@interface Growler : NSObject <GrowlApplicationBridgeDelegate> {

}

+ (Growler *)sharedGrowler;
- (void)growlWithTitle:(NSString *)title description:(NSString *)description notificationName:(NSString *)notificationName iconData:(NSData *)iconData context:(id)context;

@end
