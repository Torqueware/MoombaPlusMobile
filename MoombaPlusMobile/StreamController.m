//
//  StreamController.m
//  MoombaPlusMobile
//
//  Created by  on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StreamController.h"

@interface StreamController ()

@property (weak, nonatomic) IBOutlet UIView    *volumeParentView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (strong, nonatomic) UIBarButtonItem    *playButton;
@property (strong, nonatomic) UIBarButtonItem    *pauseButton;
@property (strong, nonatomic) UIBarButtonItem    *leftFlex;
@property (strong, nonatomic) UIBarButtonItem    *rightFlex;

- (void) updateToolbar;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;

@end

@implementation StreamController

@synthesize streamEngine     = _streamEngine;

@synthesize volumeParentView = _volumeParentView;
@synthesize toolbar          = _toolbar;

@synthesize playButton       = _playButton;
@synthesize pauseButton      = _pauseButton;
@synthesize leftFlex         = _leftFlex;
@synthesize rightFlex        = _rightFlex;

- (void) setEngine:(StreamEngine *)stream {
    if (self.streamEngine != nil) {
        [self.streamEngine removeObserver:self forKeyPath:@"isPlaying"];
        _streamEngine = nil;
    }
    
    self.streamEngine = stream;
    
    [self.streamEngine addObserver:self
                        forKeyPath:@"isPlaying"
                           options:NSKeyValueChangeSetting
                           context:nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    
    if ([keyPath isEqualToString:@"isPlaying"])
        [self updateToolbar];
    
    else
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                     target:self
                                                                     action:@selector(play:)];
    self.pauseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                                                                     target:self
                                                                     action:@selector(pause:)];    
    self.leftFlex    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                     target:nil
                                                                     action:nil];
    self.rightFlex   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                     target:nil
                                                                     action:nil];
    
    
    [self.volumeParentView addSubview:[[MPVolumeView alloc] initWithFrame: self.volumeParentView.bounds]];
    [self.toolbar setItems:[NSArray arrayWithObjects:self.leftFlex, self.pauseButton, self.rightFlex, nil]];
}

- (void) updateToolbar {
    if (self.streamEngine.isPlaying) {
        [self.toolbar setItems:[NSArray arrayWithObjects:self.leftFlex, self.pauseButton, self.rightFlex, nil]];
    } else {
        [self.toolbar setItems:[NSArray arrayWithObjects:self.leftFlex, self.pauseButton, self.rightFlex, nil]];
    }
}

- (IBAction)play:(id)sender {
#ifdef __DEBUG__
    NSLog(@"play");
#endif
    
    if (!self.streamEngine.isPlaying) {
        [self.streamEngine play];
    }
}

- (IBAction)pause:(id)sender {
#ifdef __DEBUG__
    NSLog(@"paused");
#endif
    
    if (self.streamEngine.isPlaying) {
        [self.streamEngine pause];
    }
}

- (IBAction)changeStream:(id)sender {
    [self setEngine:[[StreamEngine alloc] initWithSecondStream]];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    [self.streamEngine removeObserver:self forKeyPath:@"isPlaying"];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateToolbar];
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

- (void) dealloc {
    [self.streamEngine removeObserver:self forKeyPath:@"isPlaying"];
    _streamEngine = nil;
    _playButton = nil;
    _pauseButton = nil;
    _leftFlex = nil;
    _rightFlex = nil;
}

@end