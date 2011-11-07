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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
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

- (IBAction) sendPressed: (id) sender {
    NSData *imageData = UIImageJPEGRepresentation(self.previewImageView.image, 0.5);
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:@"3",@"pic[venue_id]",@"1",@"pic[user_id]",@"from iphone", @"pic[caption]",nil];
    // Instantiate the client
    NSURL* baseURL = [[NSURL alloc] initWithString:@"http://127.0.0.1:3000/"];
    AFHTTPClient *client= [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Content-disposition" value:@"form-data"];
    NSMutableURLRequest *request = 
        [client multipartFormRequestWithMethod:@"POST" 
                                          path:@"pics" 
                                    parameters:params 
                     constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData:imageData mimeType:@"image/jpeg" name:@"pic[image]"];
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        NSLog(@"Sent %d of %d bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
        
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];   
}

- (void)pickedVenue:(NSDictionary *)venue
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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