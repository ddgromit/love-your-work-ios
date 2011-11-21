//
//  HPRequestDialogs.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HPRequestDialogs : NSObject
{
    MBProgressHUD* _progressHUD;
    MBProgressHUD* _errorHUD;
}
- (id)initWithView:(UIView*) newView;
- (void)showLoadingWithMessage:(NSString*) message;
- (void)showErrorWithMessage:(NSString*) message;
- (void)hideLoading;

@property (retain, nonatomic) MBProgressHUD* progressHUD;
@property (retain, nonatomic) MBProgressHUD* errorHUD;
@property (retain, nonatomic) UIView* view;
@end
