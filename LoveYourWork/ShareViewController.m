//
//  SecondViewController.m
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShareViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@implementation ShareViewController

@synthesize previewImageView;
@synthesize pecentage;
@synthesize venuePickerController;
@synthesize captionTextField;
@synthesize selectedVenue;
@synthesize venueName;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)textFieldReturn:(id)sender
{
    NSLog(@"text field return");
    [sender resignFirstResponder];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get the image from the camera
    UIImage* pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.previewImageView setImage:pickedImage];
    
    // Create the venues list controller
    UIStoryboard* venues = [UIStoryboard storyboardWithName:@"VenuePicker" bundle:nil];
    VenuePicker* venuesController = [venues instantiateInitialViewController];
    venuesController.delegate = self;
    
    // Put the venues storyboard on the camera's nav
    [picker pushViewController:venuesController animated:NO];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel");
    [self dismissModalViewControllerAnimated:YES];
}

- (void)uploadProgress:(NSInteger)bytesWritten totalByesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"uploadprogress called");
}
- (IBAction) sendPressed: (id) sender {
    NSString* hpId = [self.selectedVenue valueForKey:@"id"];
    NSString* caption = [self.captionTextField text];
    
    LoveYourWorkAPI *api = [[LoveYourWorkAPI alloc] init];
    api.delegate = self;
    [api    sendImage:self.previewImageView.image 
    withHyperpublicId:hpId
           withUserId:@"1" 
              caption:caption
              success:^(NSString* response) {
                  NSLog(@"Called success: %@",response);
              }
              failure:^(NSError* error) {
                  NSLog(@"Called failure: %@",error);
              }
  uploadProgressBlock:^(NSInteger bytesWritten, 
                        NSInteger totalBytesWritten, 
                        NSInteger totalBytesExpectedToWrite) {
                  NSLog(@"Sent %d of %d bytes", totalBytesWritten, totalBytesExpectedToWrite);
              }];

    
}

- (void)pickedVenue:(NSDictionary *)venue
{
    NSDictionary* newVenue = [[NSDictionary alloc] initWithDictionary:venue copyItems:true];
    self.selectedVenue = newVenue;
    [self.venueName setText:[self.selectedVenue objectForKey:@"display_name"]];
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    cameraPresented = false;
}

- (void)viewDidUnload
{
    captionTextField = nil;
    [self setCaptionTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)presentImagePicker
{
	// What is the device capable of
    UIImagePickerControllerSourceType type =
    UIImagePickerControllerSourceTypePhotoLibrary;
    BOOL canTakePicture = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL canPickPicture = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (canTakePicture) {
        type = UIImagePickerControllerSourceTypeCamera;
    } else if (canPickPicture) {
        type = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        NSLog(@"No image picker sources available");
        return;
    }
    
    // Show the controller
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType = type;
    [UIImagePickerController availableMediaTypesForSourceType:type];
    picker.delegate = self;
    [self presentModalViewController:picker animated:NO];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!cameraPresented) {
        cameraPresented = true;
        [self presentImagePicker];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
