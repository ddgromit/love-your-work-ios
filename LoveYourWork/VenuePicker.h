//
//  VenuePicker.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HyperpublicAPI.h"
#import <CoreLocation/CoreLocation.h>
#import "HPRequestDialogs.h"

@protocol VenuePickerDelegate <NSObject>
- (void) pickedVenue:(NSDictionary *)venue;
@end




@interface VenuePicker : UITableViewController <HyperpublicAPIDelegate, CLLocationManagerDelegate, UISearchBarDelegate> 
{
    CLLocationManager *locationManager;
    bool initialLoadStarted;
    
    HPRequestDialogs* requestDialogs;
}


- (void)reloadPlaces;
- (void)placesReturned:(NSArray*)placesJSON;
- (void)placesError:(NSError *)error;

@property (retain, nonatomic) NSArray* places;
@property (retain, nonatomic) id <VenuePickerDelegate> delegate;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) HyperpublicAPI* api;

# pragma mark - HP API query state
@property (nonatomic, retain) CLLocation* currentLocation;
@property (nonatomic, retain) NSString* currentQuery;

# pragma mark - controls
@property (retain, nonatomic) IBOutlet UISearchBar* searchBar;
@end
