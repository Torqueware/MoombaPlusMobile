//
//  StreamController.m
//  MoombaPlusMobile
//
//  Created by  on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StreamController.h"

@interface StreamController ()

@property (strong, nonatomic) IBOutlet UIView       *volumeParentView;

@property (strong, nonatomic) IBOutlet UIToolbar    *toolbar;
@property (strong, nonatomic) UIBarButtonItem       *playButton;
@property (strong, nonatomic) UIBarButtonItem       *pauseButton;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;

@end

@implementation StreamController

@synthesize stream           = _stream;

@synthesize volumeParentView = _volumeParentView;

@synthesize toolbar          = _toolbar;
@synthesize playButton       = _playButton;
@synthesize pauseButton      = _pauseButton;

- (void) setStreamEngine:(StreamEngine *)stream {
    self.stream = stream;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.volumeParentView.backgroundColor = [UIColor clearColor];
    [self.volumeParentView addSubview:[[MPVolumeView alloc] initWithFrame: self.volumeParentView.bounds]];
    
    self.playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                    target:self
                                                                    action:@selector(play:)];
    self.pauseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                                                                     target:self
                                                                     action:@selector(pause:)];
    self.toolbar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *left  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                   target:nil
                                                                                   action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                   target:nil
                                                                                   action:nil];
    
    if (self.stream.isPlaying) {
        [self.toolbar setItems:[NSArray arrayWithObjects:left, self.pauseButton, right, nil]];
    } else {
        [self.toolbar setItems:[NSArray arrayWithObjects:left, self.playButton, right, nil]];
    }
        
    NSLog(@"Target Self: %@\n  Toolbar: %@\n", self, self.toolbar);
    
    // Do any additional setup after loading the view, typically from a nibs
}

- (IBAction)play:(id)sender {
    NSLog(@"play");

    if (!self.stream.isPlaying) {
        [self.stream play];
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:self.toolbar.items];
        [items replaceObjectAtIndex:1 withObject:self.pauseButton];
        self.toolbar.items = items;
    }
}

- (IBAction)pause:(id)sender {
    NSLog(@"paused");

    if (self.stream.isPlaying) {
        [self.stream pause];
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:self.toolbar.items];
        [items replaceObjectAtIndex:1 withObject:self.playButton];
        self.toolbar.items = items;
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