//
//  StreamEngine.m
//  MoombaPlusMobile
//
//  Created by  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StreamEngine.h"

@interface StreamEngine ()

@property (strong, nonatomic) AVPlayer      *player;

@end

@implementation StreamEngine

@synthesize player = _player;

@dynamic isPlaying;

- (id) init {
    self    = [super init];

    return self;
}

// variable overrides

- (BOOL) isPlaying {
    if (self.player != nil && self.player.rate > 0.0)
        return true;
    
    return false;
}

// control functions

- (NSArray *)   currentMetadata {
    if (self.isPlaying) {
        return [[self.player currentItem] timedMetadata];
    }
    
    return nil;
}

- (void) play {
    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:MOOMBA_PLUS_RADIO]];
    [self.player play];
}

- (void) pause {
    [self.player pause];
    self.player = nil;
}

@end
