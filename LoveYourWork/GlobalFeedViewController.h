//
//  GlobalFeedViewController.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlobalFeedViewController : UIViewController


- (UIViewController*) makePicLine;
- (void) loadPics;

@property (retain, nonatomic) IBOutlet UIScrollView* scrollView;

@end
