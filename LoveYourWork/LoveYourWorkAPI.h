//
//  LoveYourWorkAPI.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoveYourWorkPic : NSObject {
    NSDictionary* picDict;
}
-(id)initWithDictionary:(NSDictionary*)picDictArg;
-(NSString*)getVenueName;
-(NSString*)getAuthorName;
-(NSString*)getImageURL;
-(NSString*)getCaption;

@end

@protocol LoveYourWorkAPIDelegate <NSObject>

- (void)uploadProgress:(NSInteger)bytesWritten totalByesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end

@interface LoveYourWorkAPI : NSObject {
    NSURL* baseURL;
}
- (id)init;
- (void)sendImage:(UIImage*)image withHyperpublicId:(NSString*)hpId 
       withUserId:(NSString*)userId 
          caption:(NSString*)caption
          success:(void (^)(NSString*))success
          failure:(void (^)(NSError*))failure
uploadProgressBlock:(void (^)(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite))uploadProgressBlock;

- (void)getPicsWithSuccess:(void (^)(NSArray*))success
                   failure:(void (^)(NSError*))failure;

@property (assign, nonatomic) id<LoveYourWorkAPIDelegate>delegate;
@end
