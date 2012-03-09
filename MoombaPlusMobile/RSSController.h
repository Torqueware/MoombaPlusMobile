//
//  RSSController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioController.h"
#import "RSSEngine.h"
#import "RSSEntry.h"
#import "FacebookDelegate.h"

#define FACEBOOK_APP_ID @"332658496785553"

@interface RSSController : RadioController {}

@property (strong, nonatomic) RSSEngine        *blogEngine;

@property (strong, nonatomic) IBOutlet UILabel *blogTitle,
                                               *blogDate,
                                               *blogMeta;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton,
                                              *shareButton;

@property (strong, nonatomic) FacebookDelegate *facebookDelegate;

- (void) setFeedURL:(NSURL *)url;
- (void) logoutButtonClicked:(id)sender;
- (void) shareButtonClicked:(id)sender;

@end
