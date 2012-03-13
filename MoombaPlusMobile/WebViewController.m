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
@synthesize shareButton      = _shareButton;
@synthesize facebookDelegate = _facebookDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSURL           *domain = [NSURL URLWithString:self.feed.url];
        NSURLRequest    *please = [NSURLRequest requestWithURL:domain];
        
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view      addSubview:self.webView];
        [self.webView   loadRequest:please];
        
//        self.view
        
        // Custom initialization
    }
    return self;
}

- (void) shareButtonClicked:(id)sender {
    
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
    [self.view layoutSubviews];
    NSLog(@"Testing");
    
    
    //Finally, load the damn thing
    
    [super        viewDidLoad];
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
