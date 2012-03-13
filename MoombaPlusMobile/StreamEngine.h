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

@interface StreamEngine : NSObject

@property BOOL isPlaying;

- (id)          init;

- (NSArray *)   currentMetadata;

- (void)        play;
- (void)        pause;

@end
