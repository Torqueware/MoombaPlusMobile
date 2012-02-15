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

@property (strong, nonatomic) AVPlayer *player;
@property float val;
@property (strong, nonatomic) UIView *volumeParentView;

- (void) createPlayer;
- (void) play;

@end
