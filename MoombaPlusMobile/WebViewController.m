//
//  WebViewController.m
//  MoombaPlusMobile
//
//  Created by  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()



@end

@implementation WebViewController

@synthesize feed             = _feed;
@synthesize webView          = _webView;
@synthesize scrollView       = _scrollView;
@synthesize shareButton      = _shareButton;
@synthesize facebookDelegate = _facebookDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {               
        // Custom initialization
    }
    return self;
}

- (IBAction) shareButtonClicked:(id)sender {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   FACEBOOK_APP_ID, @"app_id",
                                   self.feed.url, @"link",
                                   @"http://moombaplus.com/wp-content/uploads/2012/02/moomba-logo-yellow_smallBLACK-copy.jpg", @"picture",
                                   @"Moomba Plus", @"name",
                                   @"Blog post", @"caption",
                                   @"All the newest and best moombahton, moombahsoul and moombahcore.", @"description",
                                   @"Check out this song!",  @"message",
                                   nil];
    
    [self.facebookDelegate.facebook dialog:@"feed" andParams:params andDelegate:self];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.webView;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


/* Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{

} */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL           *domain = [NSURL URLWithString:self.feed.url];
    NSURLRequest    *please = [NSURLRequest requestWithURL:domain];
    
    [self.webView   loadRequest:please];   
    
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.delegate=self;
   
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
