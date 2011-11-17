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
#import "MBProgressHUD.h"

@protocol VenuePickerDelegate <NSObject>
- (void) pickedVenue:(NSDictionary *)venue;
@end




@interface VenuePicker : UITableViewController <HyperpublicAPIDelegate, CLLocationManagerDelegate, UISearchBarDelegate> 
{
    CLLocationManager *locationManager;
    bool initialLoadStarted;
    
    MBProgressHUD* _progressHUD;
    MBProgressHUD* _errorHUD;
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
@property (retain, nonatomic) MBProgressHUD* progressHUD;
@property (retain, nonatomic) MBProgressHUD* errorHUD;
@end
