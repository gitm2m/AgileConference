//
//  ACAboutViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "ACAboutViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CommonUtility.h"
#import "ViewUtility.h"
#import "ACEventDescriptionWebviewController.h"

@implementation ACAboutViewController
@synthesize aboutWebView;
@synthesize videoTableViewCell;
@synthesize detailsTableViewCell;
@synthesize doneBarButton,splashView;

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
 
    [valtechLabel setFont:[CommonUtility fontSegoiBold:13]];
    [videoLabel setFont:[CommonUtility fontSegoi:11]];
    [aboutTextView setFont:[CommonUtility fontSegoi:13]];
    
    [leftBarButton setHidden:YES];
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    if (![CommonUtility isConnectedToNetwork]) {
        [ViewUtility showAlertViewWithMessage:@"Network connection attempt failed,Please check your internet connection."];
       
    }

    
    self.title = @"About Valtech";
    
    [videoTableViewCell.layer setCornerRadius:5.0f];
    [detailsTableViewCell.layer setCornerRadius:5.0f];
    
    [videoTableViewCell.layer setBorderColor:[UIColor whiteColor].CGColor];
    [videoTableViewCell.layer setBorderWidth:1.0f];
    [detailsTableViewCell.layer setBorderColor:[UIColor whiteColor].CGColor];
    [detailsTableViewCell.layer setBorderWidth:1.0f];
    
    NSString *htmlString = @"<object style=\"height: 83px; width: 143px\"><param name=\"movie\" value=\"http://www.youtube.com/v/qctovMeRczU?version=3&feature=player_detailpage\"><param name=\"allowFullScreen\" value=\"true\"><param name=\"allowScriptAccess\" value=\"always\"><embed src=\"http://www.youtube.com/v/qctovMeRczU?version=3&feature=player_detailpage\" type=\"application/x-shockwave-flash\" allowfullscreen=\"true\" allowScriptAccess=\"always\" width=\"143\" height=\"83\"></object>";
    
    [aboutWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com/watch?feature=player_detailpage&v=qctovMeRczU"]];
    

    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
                                   initWithTitle: @"Back" 
                                   style:UIBarButtonItemStylePlain 
                                   target:self 
                                   action:@selector(backButtonTapped)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDoneBarButton:nil];
    [self setVideoTableViewCell:nil];
    [self setAboutWebView:nil];
    [self setDetailsTableViewCell:nil];
    valtechLabel = nil;
    videoLabel = nil;
    aboutTextView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)setupInitialView{
    
    
    UIImageView *bgHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0.0,0, 320.0, 44.0)];
    [bgHeader setBackgroundColor:[UIColor clearColor]];
    [bgHeader setImage:[UIImage imageNamed:@"titleRow.png"]];
    [[self view] addSubview:bgHeader];
        //[bgHeader release];
    
    leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setBackgroundImage:[UIImage imageNamed:@"Action.png"] forState:UIControlStateNormal];
    leftBarButton.frame = CGRectMake(15, 10, 25, 24); 
    [leftBarButton setHidden:YES];
    [leftBarButton addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBarButton];
    
    rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setBackgroundImage:[UIImage imageNamed:@"doneBtn.png"] forState:UIControlStateNormal];
    rightBarButton.frame = CGRectMake(264, 10, 49, 23) ; 
    [rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBarButton];
    
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 5, 300, 35)];
    [headerLabel setFont:[CommonUtility fontSegoiBold:17]];
    [headerLabel setText:KAppName];
    [headerLabel setTextAlignment:UITextAlignmentCenter];
    [headerLabel setTextColor:[UIColor darkGrayColor]];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headerLabel];
}


#pragma mark - Events Methodsr
- (IBAction)doneBarButtonPressed:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    /*
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [splashView setAlpha:1.0];
    [UIView commitAnimations];
     */
}

- (IBAction)viewMoreButtonTapped:(id)sender {
    
    ACEventDescriptionWebviewController *descriptionViewController = [[ACEventDescriptionWebviewController alloc] initWithNibName:@"ACEventDescriptionWebviewController" bundle:nil];
    
    [self.navigationController pushViewController:descriptionViewController animated:YES];


}

- (void)backButtonTapped{
    
    [self.navigationController popViewControllerAnimated:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [splashView setAlpha:1.0];
    [UIView commitAnimations];
}

-(void)leftBarButtonClicked : (id)sender{

   
}

-(void)rightBarButtonClicked : (id)sender{
    
     [self dismissModalViewControllerAnimated:YES];
}


@end
