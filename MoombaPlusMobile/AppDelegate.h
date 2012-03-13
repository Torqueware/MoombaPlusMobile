//
//  AppDelegate.h
//  MoombaPlusMobile
//
//  Created by  on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "StreamController.h"
#import "RSSController.h"
#import "IRCController.h"

#import "StreamEngine.h"
#import "RSSEngine.h"

#import "FacebookDelegate.h"

#define STREAM 0
#define FEED   1
#define CHAT   2

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow          *window;

@property (strong, nonatomic) StreamEngine      *stream;
@property (strong, nonatomic) RSSEngine         *blog;

@property (strong, nonatomic) FacebookDelegate  *facebookDelegate;

@end
