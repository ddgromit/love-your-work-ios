//
//  LoveYourWorkAPI.m
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoveYourWorkAPI.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

@implementation LoveYourWorkAPI

static bool const USING_PROD = true;

@synthesize delegate;

- (id)init {
    self = [super init];
    
    return self;
}

- (void)sendImage:(UIImage*)image 
withHyperpublicId:(NSString*)hpId 
       withUserId:(NSString*)userId 
          caption:(NSString*)caption
          success:(void (^)(NSString*))success 
          failure:(void (^)(NSError*))failure
uploadProgressBlock:(void (^)(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite))uploadProgressBlock
{
    
    // Convert the UIImage to JPEG data
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    // Request POST params
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            hpId, @"hp_id",
                            userId,@"user_id",
                            caption, @"caption",
                            nil];
    
    // Determine what endpoint to use
    NSURL* baseURL;
    if (USING_PROD) {
        baseURL = [[NSURL alloc] initWithString:@"http://loveyourwork.heroku.com/"];
    } else {
        baseURL = [[NSURL alloc] initWithString:@"http://127.0.0.1:3000/"];
    }
    
    // Create a POST file transfer
    AFHTTPClient *client= [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Content-disposition" value:@"form-data"];
    NSMutableURLRequest *request = 
        [client multipartFormRequestWithMethod:@"POST" 
                                          path:@"mobile_api/post_pic" 
                                    parameters:params 
                     constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                         // Add the image data to the POST body
                         [formData appendPartWithFileData:imageData mimeType:@"image/jpeg" name:@"image"];
                     }];
    NSLog(@"Making LoveYourWork request to %@ with params %@",[request URL],params);
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    void (^complete)() = ^() {
        if (operation.error) {
            if (failure != nil) {
                failure(operation.error);
            }
        } else {
            if (success != nil) {
                success(operation.responseString);
            }
        }
    };
    [operation setCompletionBlock:complete];
    
    // Allow delegate to watch for transfer progress
    if (uploadProgressBlock != nil) {
        [operation setUploadProgressBlock:uploadProgressBlock];
    }
    
    // Kick off the transfer
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];   
}

- (void)getPicsWithSuccess:(void (^)(NSArray*))success
                   failure:(void (^)(NSError*))failure
{
    
    NSURL* baseURL;
    if (USING_PROD) {
        baseURL = [[NSURL alloc] initWithString:@"http://loveyourwork.heroku.com/"];
    } else {
        baseURL = [[NSURL alloc] initWithString:@"http://127.0.0.1:3000/"];
    }
    
    // Build the URL
    NSString *url = [NSString 
                     stringWithFormat:@"%@mobile_api/feed",baseURL];
    NSLog(@"Making lyw api call to %@",url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray* picsJSON = (NSArray*)JSON;
        
        // Turn the array of pics into objects
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        for (NSDictionary* picJSON in picsJSON) {
            LoveYourWorkPic* newPic = [[LoveYourWorkPic alloc] initWithDictionary:picJSON];
            [arr addObject:newPic];
        }
        
        // Callback with array of pic objects
        success(arr);
    } failure:^(NSURLRequest* request,NSHTTPURLResponse *response, NSError *error) {
        failure(error);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
@end

@implementation LoveYourWorkPic

-(id)initWithDictionary:(NSDictionary *)picDictArg
{
    self = [super init];
    picDict = picDictArg;
    return self;
}

-(NSString*)getVenueName
{
    return [picDict objectForKey:@"venue_name"];
}
-(NSString*)getAuthorName
{
    return [picDict objectForKey:@"author_name"];
}
-(NSString*)getImageURL
{
    return [picDict objectForKey:@"image_url_feed"];
}
-(NSString*)getCaption
{
    return [picDict objectForKey:@"caption"];
}

@end
