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

@interface MoombaPlusController : NSObject

@property (strong, nonatomic) IRCController *chatController;
@property (strong, nonatomic) RSSController *blogController;

@end
