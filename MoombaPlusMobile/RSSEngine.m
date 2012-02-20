//
//  RSSEngine.m
//  MoombaPlusMobile
//
//  Created by William Millard on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  This code is HEAVILY inspired from a guide "How To Make A Simple RSS Reader iPhone App"
//  at "http://www.raywenderlich.com/2636/how-to-make-a-simple-rss-reader-iphone-app-tutorial"
//  it is heavily modified version, as the original version SHAMELESSLY VIOLATES the
//  MVC methodology

#import "RSSEngine.h" //Let NOTHING be in this .h file but accessors and method calls

@interface RSSEngine ()

@property (strong, nonatomic) NSURL            *feed;

@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSMutableArray   *cache;

@property (readwrite) int                       heartbeat;

- (void) refresh;
- (NSArray *)parseFeed: (GDataXMLElement *)root;

@end

@implementation RSSEngine

@synthesize feed = _feed, queue = _queue, cache = _cache, heartbeat = _heartbeat;
@dynamic empty;

- (id) init:(NSURL *)feed {
   self = [super init];

   _feed = feed;
   
   [self refresh];

   return self;
}

- (bool) empty {
   if (self.cache == nil) {
      return true;
   }
   
   return false;
}

- (void)forceRefresh {   
   [self refresh];
}

- (void)refresh {
   ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:self.feed];

   [request setDelegate:self];
   [self.queue addOperation:request];
   
   [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
   
   [self.queue addOperationWithBlock: ^{
      NSError *error;
      GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData: [request responseData]
                                                             options: 0
                                                               error: &error];
      
      if (doc != nil) {
         NSMutableArray *entries = [NSMutableArray alloc];         
         [self parseFeed:doc.rootElement entries:entries];
         
         [self.cache addObjectsFromArray:entries];
      }
   }];
    
   self.heartbeat++;
}

- (void) parseFeed: (GDataXMLElement *)root {
    
    if([root.name compare: @"rss"] == NSOrderedSame) {
       return [self parseRSS:root];
    } else if {
       return [self parseAtom:root];
    } else {
       NSLog(@"Unsupported root element: %@", root.name);
    }
       
    return nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
   NSError *error = [request error];
   NSLog(@"Error: %@", error);
}

- (NSArray *) dumpFeeds {
   NSArray *feedDump = (NSArray *) self.cache;
   
   if(!self.empty) self.cache = nil;
   
   return feedDump;
}

- (RSSEntry *) dumpOne {
   RSSEntry *one = (self.empty) ? nil : [self.cache objectAtIndex:0];
   
   if (!self.empty) [self.cache removeObjectAtIndex:0];
   
   return one;
}

@end
