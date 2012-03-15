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

@end

@implementation IRCController

@synthesize webView = _webView;
@synthesize scrollView = _scrollView;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.webView;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:MOOMBA_PLUS_IRC]]];   
    
    [self.webView addObserver:self forKeyPath:@"isLoading" options:NSKeyValueChangeSetting context:nil];
    
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.delegate=self;
    
    // Do any additional setup after loading the view, typically from a nibs
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    if ([keyPath isEqualToString:@"isLoading"] && !self.webView.isLoading) {
        int i = 0; //noop
    }
}

- (void) viewDidUnload
{
    [_webView removeObserver:self forKeyPath:@"isLoading"];
    
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
