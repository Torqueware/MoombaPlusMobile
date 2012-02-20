//
//  MoombaPlusController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoombaPlusController.h"

@implementation MoombaPlusController

@synthesize chatController = _chatController;
@synthesize blogController = _blogController;
@synthesize radioController = _radioController;

- (id) init {
    self = [super init];
   
    _chatController  = [[IRCController   alloc] init];
    _blogController  = [[RSSController   alloc] init];
    _radioController = [[RadioController alloc] init];

   [self.blogController  setURL:[NSURL URLWithString:MOOMBA_PLUS_FEED]];
   [self.radioController setURL:[NSURL URLWithString:MOOMBA_PLUS_RADIO]];
    
    return self;
}

@end
