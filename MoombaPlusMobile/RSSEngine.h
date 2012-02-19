//
//  RSSEngine.h
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSXMLParser.h>
#import "ASIHTTPRequest.h"
#import "RSSEntry.h"

@interface RSSEngine : NSObject

@property (readonly) int heartbeat;
@property (readonly) bool valid;

- (NSArray *) dumpFeeds;

- (void) forceRefresh;

- (RSSEntry *) dumpOne;

@end

