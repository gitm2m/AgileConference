//
//  ACFeedbackViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/11/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACFeedbackViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation ACFeedbackViewController
@synthesize textViewPlaceHolderView;
@synthesize feedbackSubTextField;
@synthesize feedbackTextView;
@synthesize feedbackBgTableCell;
@synthesize rateView;
@synthesize userName;

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

- (IBAction)cacelButtonTapped:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];

}

- (IBAction)sendButtonTapped:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
    ACNetworkHandler *networkHandler = [[ACNetworkHandler alloc] init];
    [networkHandler downloadHandler:nil context:nil delegate:self];

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
    
}

#pragma mark - AcNetworkHandlerDelegate Methods

-(void)networkHandler :(ACNetworkHandler*)networkHandler  downloadDidComplete: (id)serverResponse{
    
    ACLog(@"serverResponse %@" , serverResponse);
}
@end
