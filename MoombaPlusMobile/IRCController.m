//
//  IRCController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IRCController.h"

@interface IRCController()

@property (weak, nonatomic) IBOutlet UIWebView    *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIcon;

@end

@implementation IRCController

@synthesize webView             = _webView;
@synthesize scrollView          = _scrollView;

@synthesize loadingIcon         = loadingIcon;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.webView;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSURL        *domain = [NSURL URLWithString:MOOMBA_PLUS_IRC];
    NSURLRequest *please = [NSURLRequest requestWithURL:domain];
    
    [loadingIcon setNeedsDisplay];
    
    [self.webView setDelegate:self];
    [self.webView loadRequest:please];   
        
    [self.scrollView setDelegate:self];
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.maximumZoomScale=6.0;
    
    // Do any additional setup after loading the view, typically from a nibs
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.loadingIcon   removeFromSuperview];
    [self.webView       setHidden:NO];
    
    [self.scrollView    layoutSubviews];
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

- (void)dealloc {
    [self viewDidUnload];
}

@end
