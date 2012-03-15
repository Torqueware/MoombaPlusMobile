//
//  RSSEngine.h
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "NSDate+InternetDateTime.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"
#import "NSArray+Extras.h"

#import "RSSEntry.h"

@interface RSSEngine : NSObject

@property (readonly, strong, nonatomic) NSArray *allEntries;

- (id) init;

- (id) initWithUrl:(NSURL *)feed;

- (void) forceRefresh;

@end

