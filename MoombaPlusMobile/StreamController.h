//
//  StreamController.h
//  MoombaPlusMobile
//
//  Created by  on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "StreamEngine.h"

@interface StreamController : UIViewController

@property (weak, nonatomic) StreamEngine *stream;

- (void) setStreamEngine:(StreamEngine *)stream;

@end
