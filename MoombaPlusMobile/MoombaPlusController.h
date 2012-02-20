//
//  MoombaPlusController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRCController.h"
#import "RSSController.h"
#import "RadioController.h"

#define MOOMBA_PLUS_RADIO @"http://s6.voscast.com:7662"
#define MOOMBA_PLUS_FEED  @"http://moombahplus.com/feed"

@interface MoombaPlusController : NSObject

@property (strong, nonatomic) IRCController     *chatController;
@property (strong, nonatomic) RSSController     *blogController;
@property (strong, nonatomic) RadioController   *radioController;

@end
