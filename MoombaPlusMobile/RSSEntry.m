//
//  RSSEntry.m
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry : NSObject

//indexing data
@synthesize title       = _header;
@synthesize date        = _date;
@synthesize thumb       = _thumb;
@synthesize url         = _url;

- (id)initWithArticle:(NSString*)article domain:(NSString*)domain date:(NSDate*)date {
   self = [super init];
   
   if (self) {
      //fetch this
      self.thumb        = nil;
      
      //init these
      self.title        = article;
      self.url          = domain;
      self.date         = date;
      
   }
   
   return self;
}

@end