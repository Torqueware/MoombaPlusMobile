//
//  RSSController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioController.h"
#import "RSSEngine.h"
#import "RSSEntry.h"

@interface RSSController : RadioController {}

@property (strong, nonatomic) RSSEngine        *blogEngine;

@property (strong, nonatomic) IBOutlet UILabel *blogTitle,
                                               *blogDate,
                                               *blogMeta;

- (void) setFeedURL:(NSURL *)url;

@end
