	//
//  RadioController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RadioController.h"

@interface RadioController()
- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context;
- (void) prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys;
/*
- (void) syncPlayPauseButtons;
- (void) enablePlayerButtons;
- (void) disablePlayerButtons;
- (void) showPlayButton;
- (void) showPauseButton;
*/

@property (strong, nonatomic) AVURLAsset *asset;

@end

static void *PlaybackViewControllerStatusObservationContext = &PlaybackViewControllerStatusObservationContext;


@implementation RadioController

@synthesize asset = _asset;
@synthesize player = _player;
@synthesize playerItem = _playerItem;
@synthesize val = _val;
@synthesize volumeParentView = _volumeParentView;
@synthesize toolbarParentView = _toolbarParentView;
@synthesize mURL = _mURL;
@synthesize isPlaying = _isPlaying;
@synthesize toolbar = _toolbar;
@synthesize playButton = _playButton;
@synthesize pauseButton = _pauseButton;


- (id) init {
    self = [super init];
    return self;
}

- (void) setURL:(NSURL *)url {
    if (_mURL != url) {
    
        _mURL = [url copy];
            
        self.asset = [AVURLAsset URLAssetWithURL:url options:nil];
        NSArray *requestedKeys = [NSArray arrayWithObjects:@"tracks", @"playable", nil];
        [self.asset loadValuesAsynchronouslyForKeys:requestedKeys completionHandler:^{
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [self prepareToPlayAsset:self.asset withKeys:requestedKeys];
                           });
        }];
    }
}

- (void) prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys {
    for (NSString *thisKey in requestedKeys) {
        AVKeyValueStatus keyStatus = [self.asset statusOfValueForKey:thisKey error:nil];
        if (keyStatus == AVKeyValueStatusFailed) {
            NSLog(@"This stream failed to load.  The key is: %@", thisKey);
        }
    }

    if (!self.asset.playable) {
        NSLog(@"This asset is not playable");
    }

    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    [self.playerItem addObserver:self
                      forKeyPath:@"status"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                         context:PlaybackViewControllerStatusObservationContext];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    
    if (context == PlaybackViewControllerStatusObservationContext) {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:
                NSLog(@"Object played.  In observeValueForKeyPath:");
                self.isPlaying = NO;
                [self play:nil];
                break;
            case AVPlayerStatusUnknown:
                NSLog(@"The status of the object is unknown.  In observeValueForKeyPath:");
                break;              
            case AVPlayerStatusFailed:
                NSLog(@"The status of the object failed.  In observeValueForKeyPath:");
                break;
        }
    }   
}

- (void) showPlayButton {
    NSMutableArray *items = [NSMutableArray arrayWithArray:self.toolbar.items];
    [items replaceObjectAtIndex:0 withObject:self.playButton];
    self.toolbar.items = items;
}

- (void) showPauseButton {
    NSMutableArray *items = [NSMutableArray arrayWithArray:self.toolbar.items];
    [items replaceObjectAtIndex:0 withObject:self.pauseButton];
    self.toolbar.items = items;
}

- (void) enablePlayPause {
    self.playButton.enabled = YES;
    self.pauseButton.enabled = YES;
}

- (IBAction)togglePlayPause:(id)sender {
    if (self.isPlaying) {
        [self pause:sender];
        [self showPlayButton];
    }
    
    else {
        [self play:sender];
        [self showPauseButton];
    }
}


- (void) play:(id)sender {
    self.isPlaying = YES;
    NSLog(@"in play");
    if (!self.player)
        NSLog(@"player nil");
    [self.player play];
    
}

- (void) pause:(id)sender {
    self.isPlaying = NO;
    NSLog(@"in pause");
    if (!self.player)
        NSLog(@"player nil");
    [self.player pause];
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.volumeParentView.backgroundColor = [UIColor clearColor];
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: self.volumeParentView.bounds];
    [self.volumeParentView addSubview:volumeView];
    
    self.playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                    target:self
                                                                    action:@selector(togglePlayPause:)];
    self.pauseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                                                                     target:self
                                                                     action:@selector(togglePlayPause:)];  
    
    _toolbar = [[UIToolbar alloc] initWithFrame:self.toolbarParentView.bounds];
    [self.toolbar setItems:[NSArray arrayWithObjects:self.pauseButton, nil]]; 
    self.toolbar.barStyle = UIBarStyleDefault;
    [self.toolbarParentView addSubview:self.toolbar];
    
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

