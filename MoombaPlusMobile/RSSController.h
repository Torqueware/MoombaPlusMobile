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
#import "WebViewController.h"

@interface RSSController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) RSSEngine          *blogEngine;

@property (strong, nonatomic) FacebookDelegate *facebookDelegate;

- (void) setEngine:(RSSEngine *)blogEngine;

@end
