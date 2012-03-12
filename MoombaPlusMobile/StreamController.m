//
//  StreamController.m
//  MoombaPlusMobile
//
//  Created by  on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StreamController.h"

@interface StreamController ()

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context;

@end

@implementation StreamController

@synthesize volumeParentView = _volumeParentView;
@synthesize toolbar = _toolbar;

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self addObserver:self forKeyPath:@"isPlayings" options:nil context:nil];

    
    // Do any additional setup after loading the view, typically from a nibs
}

- (IBAction)togglePlayPause:(id)sender {
    
    NSLog(@"Toggle Self: %@\n", self);
    
    if (self.radioController.isPlaying) {
        NSLog(@"is playing");
        [self.radioController pause:sender];
        [self showPlayButton];
    }
    
    else {
        NSLog(@"not playing, RC: %@", self.radioController);
        [self.radioController play: sender];
        [self showPauseButton];
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    if (self.isPlaying) {
        NSLog(@"Playing");    
    } else {
        NSLog(@"NotPlaying");
    }
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