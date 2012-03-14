//
//  WebViewController.h
//  MoombaPlusMobile
//
//  Created by  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSEntry.h"
#import "FacebookDelegate.h"

@interface WebViewController : UIViewController <UIScrollViewDelegate, FBDialogDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;

@property (weak, nonatomic) FacebookDelegate     *facebookDelegate;
@property (weak, nonatomic) RSSEntry             *feed;

- (IBAction) shareButtonClicked:(id)sender;

@end
