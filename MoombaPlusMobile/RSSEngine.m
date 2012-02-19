//
//  RSSEngine.m
//  MoombaPlusMobile
//
//  Created by William Millard on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSEngine.h" //Let NOTHING be in this .h file but accessors and method calls

@interface RSSEngine ()

@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSMutableArray *feeds;
@property (readwrite) int heartbeat;

- (void) refresh;

@end

@implementation RSSEngine

@synthesize queue = _queue, feeds = _feeds, heartbeat = _heartbeat;
@dynamic valid;

- (id) init {
   self = [super init];

   [self refresh];

   return self;
}

- (bool) dynamic {
   return ([self.feeds count] != 0) ? true : false;
}

- (void)forceRefresh {
   NSLog(@"%@", @"Forced refresh");
   
   [self refresh];
}

- (void)refresh {
   ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL: [NSURL URLWithString:@"http://moombahplus.com/feed/"]];

   [request setDelegate:self];
   [self.queue addOperation:request];
   
   [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
   
   [self.feeds addObject: [[RSSEntry alloc] initWithArticle:request.url.absoluteString
                                                      domain:request.url.absoluteString
                                                       date:[NSDate date]]];
   NSLog(@"%@", @"hit!\n");

   self.heartbeat++;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
   NSError *error = [request error];
   NSLog(@"Error: %@", error);
}

- (NSArray *) dumpFeeds {
   NSArray *feedDump = (NSArray *) self.feeds;
   
   if(self.valid) self.feeds = nil;
   
   return feedDump;
}

- (RSSEntry *) dumpOne {
   RSSEntry *one = (self.valid) ? [self.feeds objectAtIndex:0] : nil;
   
   if (one) [self.feeds removeObjectAtIndex:0];
   
   return one;
}

@end
