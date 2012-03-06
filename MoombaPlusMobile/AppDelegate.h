//
//  AppDelegate.h
//  MoombaPlusMobile
//
//  Created by  on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRCController.h"
#import "RSSController.h"
#import "RadioController.h"

#define MOOMBA_PLUS_RADIO @"http://s6.voscast.com:7662"
#define MOOMBA_PLUS_FEED  @"http://moombahplus.com/feed"
#define OTHER_RADIO @"http://s6.voscast.com:7644"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RadioController *radioController;


@end
