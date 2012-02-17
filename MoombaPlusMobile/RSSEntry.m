//
//  RSSEntry.m
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry

//image
@synthesize thumb    = _thumb;

//title data
@synthesize article  = _article;
@synthesize source   = _source;
@synthesize date     = _date;

//an erl
@synthesize url      = _url;

- (id) initWithData:(NSData *) img article: (NSString*) art source: (NSString *) src date: (NSDate *) date url: (NSURL *) url  {
   self = [[RSSEntry alloc] init];
   
   if (self) {
      
      self.thumb     = img;
      
      self.article   = art;
      self.source    = src;
      self.date      = date;
      
      self.url       = url;
   }
}

@end
