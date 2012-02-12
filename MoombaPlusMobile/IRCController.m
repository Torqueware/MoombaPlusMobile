//
//  IRCController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IRCController.h"

@implementation IRCController

@synthesize player = _player;
@synthesize volumeParentView = _volumeParentView;
@synthesize  str = _str;
@synthesize url = _url;

- (AVPlayer *) startPlayer {
    self.str = @"s6.voscast.com:7662/listen.pls";
    self.url = [NSURL URLWithString:self.str];
    
    return [AVPlayer playerWithURL:self.url];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nibs
    
    self.volumeParentView.backgroundColor = [UIColor clearColor];
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: self.volumeParentView.bounds];
    [self.volumeParentView addSubview:volumeView];
    
    self.player = [self startPlayer];
    [self.player play];
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
