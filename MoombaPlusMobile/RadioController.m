//
//  RadioController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RadioController.h"

@implementation RadioController

@synthesize player = _player;
@synthesize val = _val;
@synthesize volumeParentView = _volumeParentView;

- (id) init {
    self = [super init];
    return self;
}

- (void) createPlayer {
    NSString *encodedString = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(nil,
                                               (CFStringRef)@"http://s6.voscast.com:7662/",
                                               NULL,
                                               NULL,
                                               kCFStringEncodingUTF8);
    NSURL *url = [NSURL URLWithString:encodedString];

    if (url == nil)
        NSLog(@"FUUUUU");
    self.player = [AVPlayer playerWithURL:url];
}

- (void) play {
    [self.player play];
    AVPlayerStatus test = self.player.status;
        if (test == AVPlayerStatusFailed) 
                    NSLog(@"FAIL");
            else if (test == AVPlayerStatusReadyToPlay)
                        NSLog(@"YEEE");
                else NSLog(@"WUT");

}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.volumeParentView.backgroundColor = [UIColor clearColor];
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: self.volumeParentView.bounds];
    [self.volumeParentView addSubview:volumeView];
    
    // Do any additional setup after loading the view, typically from a nib.
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

