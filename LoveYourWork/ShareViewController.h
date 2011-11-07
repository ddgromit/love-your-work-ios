//
//  SecondViewController.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VenuePicker.h"

@interface ShareViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIImageView* previewImageView;
    UILabel* pecentage;
    UIViewController* venuePickerController;
}
- (IBAction) sendPressed: (id) sender;
@property (nonatomic, retain) IBOutlet UIImageView* previewImageView;
@property (nonatomic, retain) IBOutlet UILabel* pecentage;
@property (nonatomic, retain) IBOutlet UIViewController* venuePickerController;

@end
