//
//  StreamController.h
//  MoombaPlusMobile
//
//  Created by  on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RadioController.h"

@interface StreamController : RadioController

@property (strong, nonatomic) IBOutlet UIView *volumeParentView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@end
