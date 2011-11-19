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
    NSDictionary* samplePicDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"the caption",@"caption", nil];
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        LoveYourWorkPic* newPic = [[LoveYourWorkPic alloc] initWithDictionary:samplePicDict];
        [arr addObject:newPic];
    }
    success(arr);
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
    return @"Venue Name";
}
-(NSString*)getAuthorName
{
    return @"Elyse B.";
}
-(UIImage*)getImage
{
    NSString* imageName = [[NSBundle mainBundle] pathForResource:@"wood_1" ofType:@"png"];
    return [[UIImage alloc] initWithContentsOfFile:imageName];
    
}
-(NSString*)getCaption
{
    return @"soup on a rainy day";
}

@end
