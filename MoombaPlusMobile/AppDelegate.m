//
//  AppDelegate.m
//  MoombaPlusMobile
//
//  Created by  on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

- (void) setViewModels;

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize stream = _stream;
@synthesize blog   = _blog;

@synthesize facebookDelegate = _facebookDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ // Override point for customization after application launch.
    NSError *delegateError = nil;
    UInt32 doChangeDefaultRoute = 1;
    
    // Setup background execution for the radio object
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                           error:&delegateError];

    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,
                            sizeof(doChangeDefaultRoute),
                            &doChangeDefaultRoute);
    [[AVAudioSession sharedInstance] setActive:true error:&delegateError];
    
    // set up audio stream and blog engine
    self.stream = [[StreamEngine alloc] init];
    self.blog   = [[RSSEngine    alloc] init];
    
    // set up FacebookDelegate wrapper class  
    self.facebookDelegate = [[FacebookDelegate alloc] init];
  
    [self setViewModels];
    
    [MemoryHound startRotateHound];
            
    return YES;
}

- (void)setViewModels {
    UITabBarController *tabBar = (id)self.window.rootViewController;
    
    StreamController *tabOne    = [tabBar.viewControllers objectAtIndex:STREAM];
    RSSController    *tabTwo    = nil;
    //IRCController    *tabThree  = [tabBar.viewControllers objectAtIndex:CHAT];
    
    for (UIViewController *controller in [[tabBar.viewControllers objectAtIndex:FEED] viewControllers])
        if ([controller isMemberOfClass:[RSSController class]])
            tabTwo = (RSSController *)controller;
    
    [tabOne setEngine:self.stream];
    
    [tabTwo setEngine:self.blog];
    [tabTwo setFacebookDelegate:self.facebookDelegate];
    
    //[tabThree setEngine:self.chat];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
