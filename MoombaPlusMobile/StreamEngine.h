//
//  StreamEngine.h
//  MoombaPlusMobile
//
//  Created by  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

#define ALTERNATE_STREAM @"http://s6.voscast.com:7644"

@interface StreamEngine : NSObject

@property (nonatomic) BOOL isPlaying;

- (id)          init;
- (id)          initWithSecondStream;

- (NSArray *)   currentMetadata;

- (void)        play;
- (void)        pause;

@end
