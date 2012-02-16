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

@end

static void *PlaybackViewControllerStatusObservationContext = &PlaybackViewControllerStatusObservationContext;


@implementation RadioController

@synthesize player = _player;
@synthesize playerItem = _playerItem;
@synthesize val = _val;
@synthesize volumeParentView = _volumeParentView;
@synthesize mURL = _mURL;


- (id) init {
    self = [super init];
    return self;
}

- (void) setURL:(NSURL *)url {
    if (_mURL != url) {
    
        _mURL = [url copy];
        
        AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
        NSArray *requestedKeys = [NSArray arrayWithObject:@"playable"];
        
        [asset loadValuesAsynchronouslyForKeys:requestedKeys completionHandler:^{
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [self prepareToPlayAsset:asset withKeys:requestedKeys];
                           });
        }];
        
    }
}

- (void) prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys {
    for (NSString *thisKey in requestedKeys) {
        NSError *err = nil;
        AVKeyValueStatus keyStatus = [asset statusOfValueForKey:thisKey error:&err];
        NSLog(@"%@", thisKey);
        if (keyStatus == AVKeyValueStatusFailed) {
            NSLog(@"This stream failed to load.  The key is: %@", thisKey);
        }
        
    }

    if (!asset.playable) {
        NSLog(@"This asset is not playable");
    }
    
    if (self.playerItem) 
        [self.playerItem removeObserver:self forKeyPath:@"status"];
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    if (self.playerItem.status == AVPlayerItemStatusUnknown)
        NSLog(@"item status unknown");
    
    // Observer "status" to determine when player is ready to play
    [self.playerItem addObserver:self
                      forKeyPath:@"status"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                         context:PlaybackViewControllerStatusObservationContext];
    

    if (![self player]) {
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    }

}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    
    if (context == PlaybackViewControllerStatusObservationContext) {
       // [self syncPlayPauseButtons];
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        
        switch (status) {
            case AVPlayerStatusUnknown:
            {
                NSLog(@"The status of the object is unknown.  In observeValueForKeyPath:");
            }
                break;
                
            case AVPlayerStatusReadyToPlay:
            {
                [self.player play];
            }
                break;
            case AVPlayerStatusFailed:
            {
                NSLog(@"The status of the object failed.  In observeValueForKeyPath:");
            }
        }
    }
    
    
}
/*
- (void) syncPlayPauseButtons {
    
}

- (void) enablePlayerButtons {
    
}

- (void) play {

}
*/
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

