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
    self.chatController = [[IRCController alloc] init];
    self.blogController = [[RSSController alloc] init];
    self.radioController = [[RadioController alloc] init];
    [self.radioController setURL:[NSURL URLWithString:@"http://qtdevseed.apple.com/addemo/ad.m3u8"]];
    
    
    return self;
}

@end
