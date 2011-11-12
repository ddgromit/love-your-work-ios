//
//  LoveYourWorkAPI.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoveYourWorkAPIDelegate <NSObject>

- (void)uploadProgress:(NSInteger)bytesWritten totalByesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end

@interface LoveYourWorkAPI : NSObject {
    
}
- (id)init;
- (void)sendImage:(UIImage*)image withHyperpublicId:(NSString*)hpId withUserId:(NSString*)userId caption:(NSString*)caption;

@property (assign, nonatomic) id<LoveYourWorkAPIDelegate>delegate;
@end
