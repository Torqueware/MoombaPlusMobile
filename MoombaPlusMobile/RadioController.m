//
//  RadioController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RadioController.h"

@implementation RadioController

@synthesize player = _player;

- (id) init {
    self = [super init];
    self.player = [self startPlayer];
    return self;
}

- (AVPlayer *) startPlayer {
    return [AVPlayer playerWithURL:[NSURL URLWithString:@"s6.voscast.com:7662/listen.pls"]];
}



@end

