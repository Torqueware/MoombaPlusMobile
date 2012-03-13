//
//  IRCController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IRCController.h"

@implementation IRCController

@synthesize volumeParentView = _volumeParentView;
//@synthesize radioController = _radioController;
@synthesize logoutButton = _logoutButton;
@synthesize facebookDelegate = _facebookDelegate;


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.logoutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(logoutButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nibs
}

- (void) logoutButtonClicked:(id)sender {
    NSLog(@"in logout IRC");
    [self.facebookDelegate.facebook logout];
}

//- (IBAction)togglePlayPause:(id)sender {
//    
//    NSLog(@"Toggle Self: %@\n", self);
//    
//    if (self.radioController.isPlaying) {
//        NSLog(@"is playing");
//        [self.radioController pause:sender];
//        [self showPlayButton];
//    }
//    
//    else {
//        NSLog(@"not playing, RC: %@", self.radioController);
//        [self.radioController play: sender];
//        [self showPauseButton];
//    }
//}

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
