//
//  VenuePicker.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HyperpublicAPI.h"

@protocol VenuePickerDelegate <NSObject>

- (void) pickedVenue:(NSDictionary *)venue;

@end


@interface VenuePicker : UITableViewController <HyperpublicAPIDelegate>

- (void)placesReturned:(NSArray*)placesJSON;

@property (retain, nonatomic) NSArray* places;
@property (retain, nonatomic) id <VenuePickerDelegate> delegate;

@end
