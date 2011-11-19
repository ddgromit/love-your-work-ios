//
//  GlobalFeedItemViewController.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoveYourWorkAPI.h"

@interface GlobalFeedItemViewController : UIViewController

@property (nonatomic, assign) LoveYourWorkPic* pic;

@property (nonatomic, assign) IBOutlet UILabel* caption;
@property (nonatomic, assign) IBOutlet UIImageView* imageView;
@property (nonatomic, assign) IBOutlet UILabel* authorName;
@property (nonatomic, assign) IBOutlet UILabel* venueName;

@end
