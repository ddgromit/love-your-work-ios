//
//  SecondViewController.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController <UIImagePickerControllerDelegate> {
    UIImageView* previewImageView;
    UILabel* pecentage;
}
- (IBAction) sendPressed: (id) sender;
@property (nonatomic, retain) IBOutlet UIImageView* previewImageView;
@property (nonatomic, retain) IBOutlet UILabel* pecentage;

@end
