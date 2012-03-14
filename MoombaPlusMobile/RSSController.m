//
//  NewRSSController.m
//  MoombaPlusMobile
//
//  Created by  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSController.h"

@interface RSSController ()

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context;

@end

@implementation RSSController

@synthesize blogEngine = _blogEngine;

@synthesize logoutButton;
@synthesize facebookDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
        [[self tableView] setDelegate:self];
        [[self tableView] setDataSource:self];
    }
    
    return self;
}

- (void) setEngine:(RSSEngine *)engine {
    if (self.blogEngine)
        [self.blogEngine removeObserver:self forKeyPath:@"allEntries"];

    self.blogEngine = engine;
    [self.blogEngine addObserver:self
                      forKeyPath:@"allEntries" 
                         options:(NSKeyValueChangeInsertion | NSKeyValueChangeReplacement | NSKeyValueChangeRemoval) 
                         context:nil];
}

- (void) logoutButtonClicked:(id)sender {
    NSLog(@"in logout IRC");
    [self.facebookDelegate.facebook logout];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {

    if ([keyPath isEqualToString:@"allEntries"]) {
        [self.tableView reloadData];        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.blogEngine.allEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    RSSEntry *current = [self.blogEngine.allEntries objectAtIndex:indexPath.row];
    
    cell.textLabel.text = current.title;
    cell.detailTextLabel.text = [current.date description];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
} */

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
    
    if ([[segue identifier] isEqualToString:@"webSegue"]) {
        WebViewController *destination = [segue destinationViewController];
        
        destination.facebookDelegate   = self.facebookDelegate;
        destination.feed               = (RSSEntry *)[self.blogEngine.allEntries objectAtIndex:selectedIndex.row];    
    }
}

@end
