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

@interface WebViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton  *shareButton;

@property (weak, nonatomic) FacebookDelegate     *facebookDelegate;
@property (weak, nonatomic) RSSEntry             *feed;

- (void) shareButtonClicked:(id)sender;

@end
