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
+ (NSArray *)parseFeed: (GDataXMLElement *)root;
+ (NSArray *)parseRSS:  (GDataXMLElement *)root;
+ (NSArray *)parseAtom: (GDataXMLElement *)root;

@end

@implementation RSSEngine

@synthesize feed = _feed, queue = _queue, cache = _cache, heartbeat = _heartbeat;
@dynamic empty;

- (id) init:(NSURL *)feed {
   self = [super init];

   _cache = [[NSMutableArray alloc] init];
   _feed  = feed;
   
   [self refresh];

   return self;
}

- (bool) empty {
   if (self.cache != nil) {
      return false;
   }
   
   return true;
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
   NSError *error;
   GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData: [request responseData]
                                                          options: 0
                                                            error: &error];
   if(doc) {
      for(RSSEntry *this in [RSSEngine parseFeed:doc.rootElement]) {
         [self.cache addObject: this];
      
         NSLog(@"%@", [this description]);
      }
      
      self.heartbeat++;
      
   } else {
      NSLog(@"Failed to parse %@", request.url);
   }
   
   NSLog(@"%@", [self.cache description]);
}

+ (NSArray *) parseFeed: (GDataXMLElement *)root {
    
    if ([root.name compare: @"rss"] == NSOrderedSame) {
       return [RSSEngine parseRSS:root];
    } else if ([root.name compare: @"atom"] == NSOrderedSame) {
       return [RSSEngine parseAtom:root];
    } else {
       NSLog(@"Unsupported root element: %@", root.name);
    }
       
    return nil;
}

//The below two functions were pulled almost entirely from the howto article

+ (NSArray *)parseRSS:(GDataXMLElement *)root {
   NSMutableArray *entries = [[NSMutableArray alloc] init];
   
   NSArray *channels = [root elementsForName:@"channel"];
   for (GDataXMLElement *channel in channels) {            
      
//      NSString *blogTitle = [channel valueForChild:@"title"];                    
      
      NSArray *items = [channel elementsForName:@"item"];
      for (GDataXMLElement *item in items) {
         
         NSString *articleTitle = [item valueForChild:@"title"];
         NSString *articleUrl = [item valueForChild:@"link"];            
//         NSString *articleDateString = [item valueForChild:@"pubDate"];        
         NSDate *articleDate = nil;
         
         [entries addObject:[[RSSEntry alloc] initWithArticle:articleTitle domain:articleUrl date:articleDate]];   
      }      
   }
   
   return entries;
}

+ (NSArray *)parseAtom:(GDataXMLElement *)root {
   NSMutableArray *entries = [[NSMutableArray alloc] init];
   
   //   NSString *blogTitle = [rootElement valueForChild:@"title"];                    
   NSArray *items = [root elementsForName:@"entry"];
   
   for (GDataXMLElement *item in items) {
      NSString *articleTitle = [item valueForChild:@"title"];
      NSString *articleUrl = nil;
      NSArray *links = [item elementsForName:@"link"];        
      
      for(GDataXMLElement *link in links) {
         NSString *rel = [[link attributeForName:@"rel"] stringValue];
         NSString *type = [[link attributeForName:@"type"] stringValue]; 
         
         if ([rel compare:@"alternate"] == NSOrderedSame && 
             [type compare:@"text/html"] == NSOrderedSame) {
            articleUrl = [[link attributeForName:@"href"] stringValue];
         }
      }
      
//      NSString *articleDateString = [item valueForChild:@"updated"];        
      NSDate *articleDate = nil;
      
      [entries addObject:[[RSSEntry alloc] initWithArticle:articleTitle domain:articleUrl date:articleDate]];
   }
   
   return entries;
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

- (void) dealloc {
   [_queue cancelAllOperations];
   [_cache removeAllObjects];
   
   
   _cache = nil;
   _queue = nil;
}

@end
