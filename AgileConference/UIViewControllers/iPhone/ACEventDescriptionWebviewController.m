//
//  ACEventDescriptionWebviewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/4/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACEventDescriptionWebviewController.h"

@implementation ACEventDescriptionWebviewController
@synthesize eventDescriptionWebview,delegate;

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
    [activityIndicator setHidesWhenStopped:YES];
    
    [eventDescriptionWebview scalesPageToFit];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
                                   initWithTitle: @"Back" 
                                   style:UIBarButtonItemStylePlain 
                                   target:self 
                                   action:@selector(backButtonTapped:)];
    self.navigationItem.leftBarButtonItem = backButton;

    
    NSURL *url = [NSURL URLWithString:@"http://submit2012india.agilealliance.org/node/8774"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [eventDescriptionWebview loadRequest:request];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setEventDescriptionWebview:nil];
    activityIndicator = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationLandscapeRight|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationPortrait;
}

#pragma mark - Events Methods

-(void)backButtonTapped : (id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    [delegate eventDescriptionViewBackButtonTapped]; 
}

#pragma mark - UIWebviewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [activityIndicator startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [activityIndicator stopAnimating];
    
}

@end

