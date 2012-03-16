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

- (void) refresh;

+ (NSArray *)parseFeed: (GDataXMLElement *)root;
+ (NSArray *)parseRSS:  (GDataXMLElement *)root;
+ (NSArray *)parseAtom: (GDataXMLElement *)root;

@end

@implementation RSSEngine

@synthesize feed = _feed, queue = _queue, cache = _cache;
@dynamic    allEntries;

- (id) init {
    self = [[super init] initWithUrl:[NSURL URLWithString:MOOMBA_PLUS_FEED]];
    
    return self;
}

- (id) initWithUrl:(NSURL *)feed {
   self = [super init];

   _cache = [[NSMutableArray alloc] init];
   _feed  = feed;
   
   [self refresh];

   return self;
}

+ (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key {    
    if (![key isEqualToString:@"allEntries"])
        return [super automaticallyNotifiesObserversForKey:key];
    
    return NO;
}

- (NSArray *) allEntries {
    if (self.cache != nil) {
        return [NSArray arrayWithArray:self.cache];
    }
    
    return nil;
}

- (void) refresh {
   ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:self.feed];

   [request setDelegate:self];
   [request setNumberOfTimesToRetryOnTimeout:3];
   [request setQueuePriority:NSOperationQueuePriorityLow];
    
   [self.queue addOperation:request];
   
   [request startAsynchronous];
}

- (void) forceRefresh {
    [self.queue cancelAllOperations];
    [self.queue waitUntilAllOperationsAreFinished];
    
    [self refresh];
}

- (void) requestFinished:(ASIHTTPRequest *)request {
   NSError          *error;
   GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData: [request responseData]
                                                          options: 0
                                                            error: &error];
   if(doc) {       
       for (RSSEntry *this in [RSSEngine parseFeed:doc.rootElement]) {
           int i = [self.cache indexForInsertingObject:this 
                                      sortedUsingBlock:^(id this, id that) {
               return [((RSSEntry *)this).date compare:((RSSEntry *)that).date];
           }];
           
           if (i < [self.cache count]) {
               if ([this.title isEqualToString:((RSSEntry *)[self.cache objectAtIndex:i]).title]) {
                   continue;
               }
           }
          
           [self willChange:NSKeyValueChangeInsertion 
            valuesAtIndexes:[NSIndexSet indexSetWithIndex:i]
                     forKey:@"allEntries"];
           
           [self.cache insertObject:this
                            atIndex:i];
           
           [self didChange:NSKeyValueChangeInsertion 
           valuesAtIndexes:[NSIndexSet indexSetWithIndex:i]
                    forKey:@"allEntries"];
       }
   }
#ifdef __DEBUG__
   else {
      NSLog(@"Failed to parse %@", request.url);
   }
#endif
}

+ (NSArray *) parseFeed: (GDataXMLElement *)root {
    
    if ([root.name compare: @"rss"] == NSOrderedSame) {
       return [RSSEngine parseRSS:root];
    } else if ([root.name compare: @"atom"] == NSOrderedSame) {
       return [RSSEngine parseAtom:root];
    }
#ifdef __DEBUG__
    else {
       NSLog(@"Unsupported root element: %@", root.name);
    }
#endif

       
    return nil;
}

//The below two functions were pulled almost entirely from the howto article

+ (NSArray *)parseRSS:(GDataXMLElement *)root {
   NSMutableArray *entries = [[NSMutableArray alloc] init];
   
   NSArray *channels = [root elementsForName:@"channel"];
   for (GDataXMLElement *channel in channels) {            
            
      NSArray *items = [channel elementsForName:@"item"];
      for (GDataXMLElement *item in items) {
         
         NSString *articleTitle         = [item valueForChild:@"title"];
         NSString *articleAuthor        = [item valueForChild:@"dc:creator"];
         NSString *articleUrl           = [item valueForChild:@"link"];            
         NSString *articleDateString    = [item valueForChild:@"pubDate"];        
         NSDate *articleDate            = [NSDate dateFromInternetDateTimeString:articleDateString
                                                                      formatHint:DateFormatHintRFC822];
         
         [entries addObject:[[RSSEntry alloc] initWithArticle:articleTitle
                                                       author:articleAuthor
                                                         link:articleUrl
                                                         date:articleDate]];   
      }      
   }
   
   return entries;
}

+ (NSArray *)parseAtom:(GDataXMLElement *)root {
   NSMutableArray *entries = [[NSMutableArray alloc] init];
   
   NSArray *items = [root elementsForName:@"entry"];
   
   for (GDataXMLElement *item in items) {
      NSString *articleTitle  = [item valueForChild:@"title"];
      NSString *articleAuthor = [item valueForChild:@"dc:creator"]; 
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
      
      NSString *articleDateString = [item valueForChild:@"updated"];        
      NSDate   *articleDate = [NSDate dateFromInternetDateTimeString:articleDateString 
                                                        formatHint:DateFormatHintRFC3339];
      
      [entries addObject:[[RSSEntry alloc] initWithArticle:articleTitle
                                                    author:articleAuthor
                                                      link:articleUrl
                                                      date:articleDate]];
   }
   
   return entries;
}


- (void)requestFailed:(ASIHTTPRequest *)request {
   NSError *error = [request error];
#ifdef __DEBUG__
   NSLog(@"Error: %@", error);
#endif
}

- (void) dealloc {
   [_queue cancelAllOperations];
   [_cache removeAllObjects];
   [_queue waitUntilAllOperationsAreFinished];

}

@end
