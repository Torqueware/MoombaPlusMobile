//
//  NewRSSController.h
//  MoombaPlusMobile
//
//  Created by  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSEngine.h"
#import "FacebookDelegate.h"

@interface NewRSSController : UITableViewController

@property (strong, nonatomic) RSSEngine        *blogEngine;
@property (weak, nonatomic) IBOutlet UIButton  *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton  *shareButton;
@property (strong, nonatomic) FacebookDelegate *facebookDelegate;

- (void) setFeedURL:(NSURL *)url;
- (void) logoutButtonClicked:(id)sender;
- (void) shareButtonClicked:(id)sender;

@end
