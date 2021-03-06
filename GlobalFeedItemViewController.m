//
//  GlobalFeedItemViewController.m
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalFeedItemViewController.h"
#import "UIImageView+AFNetworking.h"

@implementation GlobalFeedItemViewController

@synthesize pic;

@synthesize caption;
@synthesize imageView;
@synthesize venueName;
@synthesize authorName;

#pragma mark - Caption text

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.pic != nil) {
        self.caption.text = [self.pic getCaption];
        self.authorName.text = [self.pic getAuthorName];
        self.venueName.text = [self.pic getVenueName];
        
        // Load image asynchronously
        NSURL* url = [NSURL URLWithString:[self.pic getImageURL]];
        [self.imageView setImageWithURL:url];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
