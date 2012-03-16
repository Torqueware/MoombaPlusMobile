//
//  IRCController.h
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IRCController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate>
 
- (void) webViewDidStartLoad:(UIWebView *)webView;

- (void) webViewDidFinishLoad:(UIWebView *)webView;

@end
