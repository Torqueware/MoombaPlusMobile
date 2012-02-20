//
//  RSSEngine.h
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"

#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"

#import "RSSEntry.h"

@interface RSSEngine : NSObject

@property (readonly) bool     empty;
@property (readonly) int      heartbeat;

- (id) init:(NSURL *)feed;

- (void) forceRefresh;

- (NSArray *) dumpFeeds;

- (RSSEntry *) dumpOne;

@end

