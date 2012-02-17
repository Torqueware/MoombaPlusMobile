//
//  RSSController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "RadioController.h"
#include "RSSEngine.h"

@interface RSSController : RadioController {}

@property (strong, nonatomic) RSSEngine *engine;

@end
