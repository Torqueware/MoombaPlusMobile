//
//  RSSEntry.h
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface RSSEntry : NSObject

@property (copy) NSString *title;
@property (copy) NSString *thumb;
@property (copy) NSDate   *date;
@property (copy) NSString *url;


- (id)initWithArticle:(NSString*)article domain:(NSString*)domain date:(NSDate*)date;

@end