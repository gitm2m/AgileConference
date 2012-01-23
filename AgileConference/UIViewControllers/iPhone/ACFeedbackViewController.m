//
//  ACFeedbackViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/11/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACFeedbackViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ACAppConstants.h"

@implementation ACFeedbackViewController
@synthesize textViewPlaceHolderView;
@synthesize feedbackSubTextField;
@synthesize feedbackTextView;
@synthesize feedbackBgTableCell;
@synthesize rateView;
@synthesize userName,isOverallEventFeedback,eventDetailDict;

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

-(void)setupInitialView{
    
    
    UIImageView *bgHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0.0,0, 320.0, 44.0)];
    [bgHeader setBackgroundColor:[UIColor clearColor]];
    [bgHeader setImage:[UIImage imageNamed:@"titleRow.png"]];
    [[self view] addSubview:bgHeader];
    //[bgHeader release];
    
    leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setBackgroundImage:[UIImage imageNamed:@"cancelBtn.png"] forState:UIControlStateNormal];
    leftBarButton.frame = CGRectMake(7, 10, 49, 23); 
    [leftBarButton addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBarButton];
    
    rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setBackgroundImage:[UIImage imageNamed:@"sendBtn.png"] forState:UIControlStateNormal];
    rightBarButton.frame = CGRectMake(264, 10, 49, 23) ; 
    [rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBarButton];
    
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 5, 300, 35)];
    [headerLabel setFont:[CommonUtility fontSegoiBold:17]];
    [headerLabel setText:@"Feedback"];
    [headerLabel setTextAlignment:UITextAlignmentCenter];
    [headerLabel setTextColor:[UIColor darkGrayColor]];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headerLabel];
}


- (void)viewDidLoad
{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    ratingString = [[NSString alloc] init];
    ratingString = @"-1";
    
    lat = @"0.0";
    longt = @"0.0";
    
    [feedbackSubTextField.layer setCornerRadius:5.0f];
    
    [feedbackSubTextField.layer setBorderColor:[UIColor whiteColor].CGColor];
    [feedbackSubTextField.layer setBorderWidth:1.0f];

    [userName.layer setBorderColor:[UIColor whiteColor].CGColor];
    [userName.layer setBorderWidth:1.0f];
    [userName.layer setCornerRadius:5.0f];  
    
    [feedbackBgTableCell.layer setCornerRadius:5.0f];
    
    [feedbackBgTableCell.layer setBorderColor:[UIColor whiteColor].CGColor];
    [feedbackBgTableCell.layer setBorderWidth:1.0f];
    
    rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    rateView.rating = 0;
    rateView.editable = YES;
    rateView.maxRating = 5;
    rateView.delegate = self;
    
    [userNameLabel setFont:[CommonUtility fontSegoi:14]];
    [subjectLabel setFont:[CommonUtility fontSegoi:14]];
    [ratingLabel setFont:[CommonUtility fontSegoi:14]];
    [feedbacklabel setFont:[CommonUtility fontSegoi:14]];
    [userName setFont:[CommonUtility fontSegoi:13]];
    [feedbackSubTextField setFont:[CommonUtility fontSegoi:13]];
    [feedbackTextView setFont:[CommonUtility fontSegoi:13]];
    [feedbackheaderLabel setFont:[CommonUtility fontSegoiBold:13]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setFeedbackBgTableCell:nil];
    [self setFeedbackTextView:nil];
    [self setFeedbackSubTextField:nil];
    [self setTextViewPlaceHolderView:nil];
    [self setRateView:nil];
    [self setUserName:nil];
    userNameLabel = nil;
    subjectLabel = nil;
    feedbacklabel = nil;
    ratingLabel = nil;
    headerLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Events Methods


-(void)leftBarButtonClicked : (id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}
-(void)rightBarButtonClicked : (id)sender{
    
    NSString *deviceUdid = [[UIDevice currentDevice] uniqueIdentifier];
    NSString *deviceModel = [[UIDevice currentDevice] model];
    
    NSMutableDictionary *apiDict = [[NSMutableDictionary alloc] init];
    
    if([[feedbackSubTextField text] length]>0)
        [apiDict setValue:[feedbackSubTextField text] forKey:@"subject"];
    else{
        [ViewUtility showAlertViewWithMessage:@"Please fill the subject field."];
        return;
    }
    
    if([[userName text] length]>0)
        [apiDict setValue:[userName text] forKey:@"personName"];
    else{
        [ViewUtility showAlertViewWithMessage:@"Please provide your name."];
        return;
    }
    
    
    if([deviceUdid length]>0)
        [apiDict setValue:deviceUdid forKey:@"udid"];
    else
        [apiDict setValue:@"NA" forKey:@"udid"];
    
    
    if([deviceModel length]>0)
        [apiDict setValue:deviceModel forKey:@"deviceType"];
    else
        [apiDict setValue:@"NA" forKey:@"deviceType"];
    
    
    if([[feedbackTextView text] length]>0)
        [apiDict setValue:[feedbackTextView text] forKey:@"feedBack"];
    else
        [apiDict setValue:@"NA" forKey:@"feedBack"];
    
    
    if (isOverallEventFeedback == YES) {
        [apiDict setValue:@"OverallEvent" forKey:@"eventType"];
        [apiDict setValue:@"NA" forKey:@"seminarName"];
        [apiDict setValue:@"NA" forKey:@"speakerName"];
    }else{
        [apiDict setValue:@"Seminar" forKey:@"eventType"];
        
        if([[eventDetailDict valueForKey:kTopicTitle] length]>0)
            [apiDict setValue:[eventDetailDict valueForKey:kTopicTitle] forKey:@"seminarName"];
        else
            [apiDict setValue:@"NA" forKey:@"seminarName"];
        
        
        if([[eventDetailDict valueForKey:kTopicSpeaker] length]>0)
            [apiDict setValue:[eventDetailDict valueForKey:kTopicSpeaker] forKey:@"speakerName"];
        else
            [apiDict setValue:@"NA" forKey:@"speakerName"];
    }
    
    if([ratingString length]>0)
        [apiDict setValue:ratingString forKey:@"rating"];
    else
        [apiDict setValue:@"-1" forKey:@"rating"];
    
    if([longt length]>0)
        [apiDict setValue:longt forKey:@"longitude"];
    else
        [apiDict setValue:longt forKey:@"0.0"];
    
    if([lat length]>0)
        [apiDict setValue:lat forKey:@"latitude"];
    else
        [apiDict setValue:lat forKey:@"0.0"];
    
    ACLog(@"apiDict %@", apiDict);
    
    ACNetworkHandler *networkHandler = [[ACNetworkHandler alloc] init];
    [networkHandler downloadHandler:apiDict context:nil delegate:self];
    
    [self dismissModalViewControllerAnimated:YES];

    
}

- (IBAction)cacelButtonTapped:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];

}

- (IBAction)sendButtonTapped:(id)sender {
    
    
    
    NSString *deviceUdid = [[UIDevice currentDevice] uniqueIdentifier];
    NSString *deviceModel = [[UIDevice currentDevice] model];
    
    NSMutableDictionary *apiDict = [[NSMutableDictionary alloc] init];
    
    if([[feedbackSubTextField text] length]>0)
        [apiDict setValue:[feedbackSubTextField text] forKey:@"subject"];
    else{
        [ViewUtility showAlertViewWithMessage:@"Please fill the subject field."];
        return;
    }
    
    if([[userName text] length]>0)
        [apiDict setValue:[userName text] forKey:@"personName"];
    else{
        [ViewUtility showAlertViewWithMessage:@"Please provide your name."];
        return;
    }

    
    if([deviceUdid length]>0)
        [apiDict setValue:deviceUdid forKey:@"udid"];
    else
        [apiDict setValue:@"NA" forKey:@"udid"];
    
    
    if([deviceModel length]>0)
        [apiDict setValue:deviceModel forKey:@"deviceType"];
    else
        [apiDict setValue:@"NA" forKey:@"deviceType"];
    
    
    if([[feedbackTextView text] length]>0)
        [apiDict setValue:[feedbackTextView text] forKey:@"feedBack"];
    else
        [apiDict setValue:@"NA" forKey:@"feedBack"];
    
    
    if (isOverallEventFeedback == YES) {
        [apiDict setValue:@"OverallEvent" forKey:@"eventType"];
        [apiDict setValue:@"NA" forKey:@"seminarName"];
        [apiDict setValue:@"NA" forKey:@"speakerName"];
    }else{
        [apiDict setValue:@"Seminar" forKey:@"eventType"];
        
        if([[eventDetailDict valueForKey:kTopicTitle] length]>0)
            [apiDict setValue:[eventDetailDict valueForKey:kTopicTitle] forKey:@"seminarName"];
        else
            [apiDict setValue:@"NA" forKey:@"seminarName"];
        
        
        if([[eventDetailDict valueForKey:kTopicSpeaker] length]>0)
            [apiDict setValue:[eventDetailDict valueForKey:kTopicSpeaker] forKey:@"speakerName"];
        else
            [apiDict setValue:@"NA" forKey:@"speakerName"];
    }
    
    if([ratingString length]>0)
        [apiDict setValue:ratingString forKey:@"rating"];
    else
        [apiDict setValue:@"-1" forKey:@"rating"];
   
     if([longt length]>0)
         [apiDict setValue:longt forKey:@"longitude"];
     else
        [apiDict setValue:longt forKey:@"0.0"];
    
    if([lat length]>0)
        [apiDict setValue:lat forKey:@"latitude"];
    else
        [apiDict setValue:lat forKey:@"0.0"];
    
    ACLog(@"apiDict %@", apiDict);
    
    ACNetworkHandler *networkHandler = [[ACNetworkHandler alloc] init];
    [networkHandler downloadHandler:apiDict context:nil delegate:self];

    [self dismissModalViewControllerAnimated:YES];
}

#pragma UITextViewDelegateMethods 

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text length]==0) {
        [textViewPlaceHolderView setAlpha:1.0];
    }else{
        [textViewPlaceHolderView setAlpha:0.0];
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text length]==0) {
        [textViewPlaceHolderView setAlpha:1.0];
    }else{
        [textViewPlaceHolderView setAlpha:0.0];
    }
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    ACLog(@"%@ %@ %d %d", textView.text,text,[textView.text length],[text length]);
    if ([textView.text length]== -1) {
        [textViewPlaceHolderView setAlpha:1.0];
    }else{
        [textViewPlaceHolderView setAlpha:0.0];
    }
    
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - UITextFieldDelegateMethods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - ACRateViewDelegate Methods

- (void)rateView:(ACRateView *)rateView ratingDidChange:(float)rating {
        
    ratingString = [NSString stringWithFormat:@"%0.0f",rating];
    
}

#pragma mark - AcNetworkHandlerDelegate Methods

-(void)networkHandler :(ACNetworkHandler*)networkHandler  downloadDidComplete: (id)serverResponse{
    
    ACLog(@"serverResponse %@" , [[serverResponse valueForKey:@"status"] valueForKey:@"message"]);
    
    if ([[[serverResponse valueForKey:@"status"] valueForKey:@"message"] isEqualToString:@"Success"]) {
        [ViewUtility showAlertViewWithMessage:@"Your feedback posted successfully."];
    }else{
        [ViewUtility showAlertViewWithMessage:@"Feedback post unsuccessful,Please try again later.Sorry for inconvinience."];
    }
}

#pragma mark - CLLocationManager Methods

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
     lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
                     degrees, minutes, seconds];
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
                       degrees, minutes, seconds];
   
}
@end
