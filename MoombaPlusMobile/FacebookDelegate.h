//
//  FacebookDelegate.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "FBConnect.h"

#define FACEBOOK_APP_ID @"332658496785553"
#define MOOMBA_PLUS_FEED  @"http://moombahplus.com/feed"

@interface FacebookDelegate : NSObject <FBSessionDelegate, FBDialogDelegate>

@property (strong, nonatomic) Facebook *facebook;

@end
