//
//  HyperpublicAPI.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreLocation/CoreLocation.h>

@protocol HyperpublicAPIDelegate <NSObject>

- (void)placesReturned:(NSArray*)places;

@end


@interface HyperpublicAPI : NSObject

- (id)initWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret; 
- (void)apiCallWithLocation:(CLLocation*)location withQuery:(NSString*)query;

@property (strong, nonatomic) NSString* clientId;
@property (strong, nonatomic) NSString* clientSecret;
@property (assign, nonatomic) id <HyperpublicAPIDelegate> delegate;
@end
