//
//  HyperpublicAPI.m
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HyperpublicAPI.h"
#import "AFHTTPClient.h"
#include "AFJSONRequestOperation.h"

@implementation HyperpublicAPI

@synthesize clientId;
@synthesize clientSecret;
@synthesize delegate;

- (id)initWithClientId:(NSString *)theClientId clientSecret:(NSString *)theClientSecret
{
    self.clientId = theClientId;
    self.clientSecret = theClientSecret;
    
    return self;
}
- (void)apiCallWithLocation:(CLLocation*)location withQuery:(NSString*)query
{
    CLLocationCoordinate2D coords = location.coordinate;
    CLLocationDegrees lat = coords.latitude;
    CLLocationDegrees lon = coords.longitude;
    
    // Figure out if we need to use the query param
    NSString* queryParam = @"";
    if ([query length] > 0) {
        queryParam = [NSString stringWithFormat:@"&q=%@", query];
    }
    
    NSString *endpoint = @"https://api.hyperpublic.com/api/v1/places";
    NSString *url = [NSString 
                     stringWithFormat:@"%@?client_id=%@&client_secret=%@&lat=%f&lon=%f&limit=50%@",endpoint,self.clientId,self.clientSecret,lat,lon,queryParam];
    NSLog(@"Making api call to %@",url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray* placesJSON = (NSArray*)JSON;
        NSLog(@"Returned from operation");
        [self.delegate placesReturned:placesJSON];
    } failure:^(NSURLRequest* request,NSHTTPURLResponse *response, NSError *error) {
        [self.delegate placesError:error];
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
@end
