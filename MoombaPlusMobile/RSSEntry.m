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
@synthesize title       = _title;
@synthesize author      = _author;
@synthesize date        = _date;
@synthesize tree        = _tree;
@synthesize url         = _url;

@dynamic humanTime, subTitle;

- (id)initWithArticle:(NSString*)article author:(NSString*)author link:(NSString*)url date:(NSDate*)date {
    self = [super init];
    
    if (self) {
        //fetch this
        self.tree         = nil;
        
        //init these
        self.title        = article;
        self.author       = author;
        self.url          = url;
        self.date         = date;
        
    }
    
    return self;
}

- (NSString *) humanTime {
    NSString        *time = nil;
    
    if (self.date != nil) {
        NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
        NSLocale        *locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        
        time = [[NSString alloc] init];
        
        [formatter setLocale:locale];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        
        time = [formatter stringFromDate:self.date];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateStyle:NSDateFormatterNoStyle];
        
        
        time = [time stringByAppendingString: @" at "]; 
        time = [time stringByAppendingString:[formatter stringFromDate:self.date]];
    }

    return time;
}

- (NSString *) subTitle {
    NSString *sub = self.humanTime;
    
    sub = [sub stringByAppendingString:@" - "];
    sub = [sub stringByAppendingString:self.author];
    
    return sub;
}

@end