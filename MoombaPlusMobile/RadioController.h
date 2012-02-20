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

@interface RadioController : UIViewController

@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *player;
@property float val;
@property (strong, nonatomic) IBOutlet UIView *volumeParentView;
@property (strong, nonatomic) IBOutlet UIView *toolbarParentView;
@property (strong, nonatomic) NSURL *mURL;
@property BOOL isPlaying;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *pauseButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *flexButton;

- (IBAction)togglePlayPause:(id)sender;
- (void)play:(id)sender;
- (void)pause:(id)sender;
- (void) setURL:(NSURL *)url;
- (void) enablePlayPause;
- (void) showPlayButton;
- (void) showPauseButton;

@end
