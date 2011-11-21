//
//  HPRequestDialogs.m
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HPRequestDialogs.h"

@implementation HPRequestDialogs

@synthesize progressHUD;
@synthesize errorHUD;
@synthesize view;

- (id)initWithView:(UIView*) newView
{
    self = [super init];
    self.view = newView;
    return self;
}

- (void)showLoadingWithMessage:(NSString*) message
{
    self.progressHUD.labelText = message;
    [self.progressHUD show:true];
}
- (void)hideLoading
{
    [self.progressHUD hide:true];
}
- (void)showErrorWithMessage:(NSString*) message
{
    self.errorHUD.detailsLabelText = message;
    [self.progressHUD hide:false];
    [self.errorHUD show:false];
    [self.errorHUD hide:true afterDelay:2];
}

- (MBProgressHUD*)progressHUD
{
    if (_progressHUD == nil)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.labelText = @"Loading";
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}
- (MBProgressHUD*)errorHUD
{
    if (_errorHUD == nil)
    {
        _errorHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _errorHUD.labelText = @"Error";
        [self.view addSubview:_errorHUD];
    }
    return _errorHUD;
}

@end
