//
//  IRCController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FacebookDelegate.h"

#define IRC_STRING @"http://wbe003.mibbit.com/?settings=aae45fe8521c86ccfaa515437fe80193&server=irc.Mibbit.Net&channel=%23MoombaPlus_test_channel"

@interface IRCController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) FacebookDelegate *facebookDelegate;

@end
