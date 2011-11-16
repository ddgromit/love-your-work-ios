//
//  VenuePicker.m
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VenuePicker.h"

@implementation VenuePicker

@synthesize places;
@synthesize delegate;
@synthesize locationManager;
@synthesize api;
@synthesize searchBar;

@synthesize currentLocation;
@synthesize currentQuery;

# pragma mark - Location / HP API Call
- (CLLocationManager *)locationManager {
    
    if (locationManager != nil) {
        return locationManager;
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.delegate = self;
    
    return locationManager;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation 
{
    NSLog(@"Location manager update: %@", newLocation);
    self.currentLocation = newLocation;
    
    [self reloadPlaces];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error 
{
    NSLog(@"Location manager failed: %@", error);
}

- (void)reloadPlaces
{
    assert(self.currentLocation != nil);
    
    // Only load once
    if (initialLoadStarted) {
        return;
    }
    initialLoadStarted = true;
    
    // Make the API call
    NSLog(@"Reloading places");
    [self.api apiCallWithLocation:self.currentLocation];
}

# pragma mark - Hyperpublic API delegates


- (void)placesReturned:(NSArray*)placesJSON 
{
    self.places = placesJSON;
    [self.tableView reloadData];
}

# pragma mark - search bar delegates

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.places == NULL) {
        return 0;
    }
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VenueCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Title text
    NSDictionary *place = [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = [place valueForKey:@"display_name"];
    
    // Subtitle text
    NSDictionary *location = (NSDictionary*)[(NSArray*)[place objectForKey:@"locations"] objectAtIndex:0];
    cell.detailTextLabel.text = [location objectForKey:@"address_line1"];
    
    return cell;
}

#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        initialLoadStarted = false;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self locationManager] startUpdatingLocation];
    
    
    // Set up the API client
    self.api = [[HyperpublicAPI alloc] 
                initWithClientId:@"7G2jA481ETolJl2bmAySJ12dZjB2Lc3FeEaeOzWv" 
                    clientSecret:@"jJ32HUlFnEMGXJWvQ246WLyaNKyk94YPwYearXq6"];
    
    api.delegate = self;
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



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *place = [self.places objectAtIndex:indexPath.row];
    [self.delegate pickedVenue:place];
    
}

@end
