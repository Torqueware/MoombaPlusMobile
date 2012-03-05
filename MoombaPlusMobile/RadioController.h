//
//  RadioController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#define MOOMBA_PLUS_RADIO @"http://s6.voscast.com:7662"

@interface RadioController : UIViewController

@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVURLAsset *asset;
@property float val;
@property (strong, nonatomic) IBOutlet UIView *volumeParentView;
@property (strong, nonatomic) NSURL *mURL;
@property BOOL isPlaying;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) UIBarButtonItem *playButton;
@property (strong, nonatomic) UIBarButtonItem *pauseButton;
@property (strong, nonatomic) UIBarButtonItem *leftFlexButton, *rightFlexButton;
@property (strong, nonatomic) RadioController *radioController;

- (void)play:(id)sender;
- (void)pause:(id)sender;
- (void) setURL:(NSURL *)url;
- (void) enablePlayPause;
- (void) showPlayButton;
- (void) showPauseButton;
- (void) syncPlayPauseButtons;

@end



