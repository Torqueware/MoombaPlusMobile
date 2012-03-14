//
//  IRCController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IRCController.h"

@interface IRCController() 
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation IRCController


@synthesize logoutButton = _logoutButton;
@synthesize facebookDelegate = _facebookDelegate;
@synthesize webView = _webView;
@synthesize scrollView = _scrollView;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.webView;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.logoutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(logoutButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:IRC_STRING]]];   
    
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.delegate=self;
    
    // Do any additional setup after loading the view, typically from a nibs
}

- (void) logoutButtonClicked:(id)sender {
    NSLog(@"in logout IRC");
    [self.facebookDelegate.facebook logout];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self syncPlayPauseButtons];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
