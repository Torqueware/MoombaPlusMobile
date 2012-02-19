//
//  RSSController.m
//  MoombaPlusMobile
//
//  Created by Mitchell, DJ on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSController.h"
#import "RSSEngine.h"

@implementation RSSController

@synthesize blogEngine, blogTitle, blogDate, blogMeta;

- (id) init {
   self = [super init];
   
   self.blogEngine = [[RSSEngine alloc]init];

   return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
      
   [self.blogDate setText:@"Fail-O-Clock"];
   [self.blogTitle setText:@"How-To-Fail"];
   
   [self.blogEngine addObserver:self forKeyPath:@"valid" options:NSKeyValueChangeSetting context: nil];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
   
   if ([keyPath compare: @"heartbeat"] == 0) {
      RSSEntry *entry = [self.blogEngine dumpOne];
      
      //self.blogThumb setImage: entry.thumb;
      [self.blogTitle setText: entry.title];
      [self.blogDate setText: [entry.date description]];
      [self.blogMeta setText: entry.title];
   }
   
   [self.view setNeedsDisplay];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
   
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

