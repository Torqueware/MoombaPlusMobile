//
//  RSSController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSController.h"
#import "RSSEngine.h"

@implementation RSSController

@synthesize blogEngine = _blogEngine;
@synthesize radioController = _radioController;
@synthesize blogTitle = _blogTitle;
@synthesize blogDate = _blogDate;
@synthesize blogMeta = _blogMeta;
@synthesize logoutButton = _logoutButton;
@synthesize shareButton = _shareButton;
@synthesize facebookDelegate = _facebookDelegate;


- (id) init {
    self = [super init];
    return self;
}

- (void) setFeedURL:(NSURL *)url {
    
   if (!url) {
       _blogEngine = [[RSSEngine alloc] initWithUrl: url];
       [self.blogEngine addObserver:self forKeyPath:@"heartbeat" options:NSKeyValueChangeSetting context: nil];
   }
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];  
    self.radioController.isPlaying = YES;
    [self syncPlayPauseButtons];
    
    [self.logoutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self
                          action:@selector(logoutButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.shareButton setTitle:@"Share Post" forState:UIControlStateNormal];
    [self.shareButton addTarget:self
                          action:@selector(shareButtonClicked:) 
                forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) logoutButtonClicked:(id)sender {
    NSLog(@"in logout RSS");
    [self.facebookDelegate.facebook logout];
}

- (void) shareButtonClicked:(id)sender {
    
    NSLog(@"In share button clicked");
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   FACEBOOK_APP_ID, @"app_id",
                                   @"http://developers.facebook.com/docs/reference/dialogs/", @"link",
                                   @"http://fbrell.com/f8.jpg", @"picture",
                                   @"Facebook Dialogs", @"name",
                                   @"Reference Documentation", @"caption",
                                   @"Using Dialogs to interact with users.", @"description",
                                   @"Facebook Dialogs are so easy!",  @"message",
                                   nil];
    
    [self.facebookDelegate.facebook dialog:@"feed" andParams:params andDelegate:self.facebookDelegate];
}

- (IBAction)togglePlayPause:(id)sender {
    NSLog(@"Toggle Self: %@\n", self);
    if (self.radioController.isPlaying) {
        [self.radioController pause:sender];
        [self showPlayButton];
    }
    
    else {
        [self.radioController play:sender];
        [self showPauseButton];
    }
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {

   if (!self.blogEngine.empty) {
      
      RSSEntry *entry = [self.blogEngine dumpOne]; 
    
      NSLog(@"%@", entry.title);
      
      //self.blogThumb setImage: entry.thumb;
      [self.blogTitle setText:  entry.title];
      [self.blogDate  setText: [entry.date description]];
//      [self.blogMeta  setText:  entry.title];
      
      [self.view setNeedsLayout];
      [self.view setNeedsDisplay];
   }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self syncPlayPauseButtons];
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

