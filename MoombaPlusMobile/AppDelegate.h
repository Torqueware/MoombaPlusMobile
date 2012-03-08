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
#import "FBConnect.h"

#define MOOMBA_PLUS_RADIO @"http://s6.voscast.com:7662"
#define MOOMBA_PLUS_FEED  @"http://moombahplus.com/feed"
#define OTHER_RADIO @"http://s6.voscast.com:7644"
#define FACEBOOK_APP_ID @"332658496785553"

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RadioController *radioController;
@property (strong, nonatomic) Facebook *facebook;

@end
