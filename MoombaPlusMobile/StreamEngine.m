//
//  StreamEngine.m
//  MoombaPlusMobile
//
//  Created by  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StreamEngine.h"

@interface StreamEngine ()

@property (strong, nonatomic) AVPlayer      *player;
@property (strong, nonatomic) AVURLAsset    *asset;
@property (strong, nonatomic) AVPlayerItem  *item;
@property BOOL secondStream;

- (void) setURL:(NSURL *)url;
- (void) prepareAsset:(AVURLAsset *)asset;  

@end

@implementation StreamEngine

static void *PlaybackViewControllerStatusObservationContext = &PlaybackViewControllerStatusObservationContext;

@synthesize player = _player;
@synthesize asset = _asset;
@synthesize item = _item;
@synthesize secondStream = _secondStream;
@synthesize isPlaying = _isPlaying;

- (id) init {
    self    = [super init];
    
    [self setURL:[NSURL URLWithString:MOOMBA_PLUS_RADIO]];
    self.secondStream = NO;
    
    return self;
}

- (id) initWithSecondStream {
    self = [super init];
    
    [self setURL:[NSURL URLWithString:ALTERNATE_STREAM]];
    self.secondStream = YES;
    
    return self;
}

- (void) setURL:(NSURL *)url {
    NSArray *keys = [NSArray arrayWithObjects:@"tracks", @"playable", nil];
    
    self.asset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    [self.asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self prepareAsset:self.asset];
                       });
    }];
}

- (void) prepareAsset:(AVURLAsset *)asset {    
    self.item = [AVPlayerItem playerItemWithAsset:self.asset];
    
    [self.item       addObserver:self
                      forKeyPath:@"status"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                         context:PlaybackViewControllerStatusObservationContext];
    
    _player = [AVPlayer playerWithPlayerItem:self.item];
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    
    if (context == PlaybackViewControllerStatusObservationContext) {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        
        switch (status) {
            case AVPlayerStatusReadyToPlay:
                [self play];
                break;
                
            case AVPlayerStatusUnknown:
                break;     
                
            case AVPlayerStatusFailed:
                NSLog(@"The status of the object failed.  In observeValueForKeyPath:");
                break;
        }
    }
}

// control functions

- (NSArray *)   currentMetadata {
    if (self.isPlaying) {
        return [[self.player currentItem] timedMetadata];
    }
    
    return nil;
}

- (void) play {
    if (!self.player) {
       
        if (!self.secondStream)
            [self setURL:[NSURL URLWithString:MOOMBA_PLUS_RADIO]];
        else 
            [self setURL:[NSURL URLWithString:ALTERNATE_STREAM]];     

    }
        
    [self.player play];
    self.isPlaying = YES;
}

- (void) pause {
    [self.player pause];
    self.player = nil;
    self.isPlaying = NO;
}

- (void) dealloc {
    _player = nil;
    _asset = nil;
    _item = nil;
}

@end
