//
//  ACCustomRootViewController.m
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "ACCustomRootViewController.h"

@implementation ACCustomRootViewController
@synthesize appDelegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.appDelegate=(ACAppDelegate *)[UIApplication sharedApplication].delegate;
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
        
    [self setupInitialView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - Views Methods

-(void)setupInitialView{
    
    organizerButtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [organizerButtn setFrame:CGRectMake(0, 380, 320, 35)];
    [organizerButtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [organizerButtn setTitle:@"Organizer" forState:UIControlStateNormal];
    [organizerButtn setTitleColor:[UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    [[organizerButtn titleLabel] setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [self.view addSubview:organizerButtn];
    

       
}

@end
