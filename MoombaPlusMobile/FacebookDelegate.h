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

@interface FacebookDelegate : NSObject <FBSessionDelegate, FBDialogDelegate>

@property (strong, nonatomic) Facebook *facebook;

@end
