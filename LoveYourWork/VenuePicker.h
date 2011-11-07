//
//  VenuePicker.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HyperpublicAPI.h"

@interface VenuePicker : UITableViewController <HyperpublicAPIDelegate>

- (void)placesReturned:(NSArray*)placesJSON;

@property (retain, nonatomic) NSArray* places;

@end
