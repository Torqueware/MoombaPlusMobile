//
//  RSSEntry.h
//  MoombaPlusMobile
//
//  Created by  on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface RSSEntry : NSObject

@property (copy) NSString *title;
@property (copy) NSString *author;
@property (copy) NSDate   *date;
@property (copy) NSString *url;

@property (copy) NSString *tree;

@property (readonly) NSString *humanTime;
@property (readonly) NSString *subTitle;

- (id)initWithArticle:(NSString*)article author:(NSString*)author link:(NSString*)URL date:(NSDate*)date;

@end