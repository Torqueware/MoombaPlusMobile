//
//  RSSEntry.h
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSEntry : NSObject {
   NSData   *_thumb;
   NSString *_source,
            *_article;
   NSDate   *_date;
   NSURL    *_url;
}

@property (copy) NSData   *thumb;
@property (copy) NSString *source;
@property (copy) NSString *article;
@property (copy) NSDate   *date;
@property (copy) NSURL    *url;

@end
