//
//  IRCController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RadioController.h"
#import "FacebookDelegate.h"

@interface IRCController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *volumeParentView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) FacebookDelegate *facebookDelegate;

- (void) logoutButtonClicked:(id)sender;

@end
