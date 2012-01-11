//
//  ACAboutViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "ACAboutViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    [videoTableViewCell.layer setCornerRadius:5.0f];
    [detailsTableViewCell.layer setCornerRadius:5.0f];
    
    [videoTableViewCell.layer setBorderColor:[UIColor blackColor].CGColor];
    [videoTableViewCell.layer setBorderWidth:1.0f];
    [detailsTableViewCell.layer setBorderColor:[UIColor blackColor].CGColor];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Events Methodsr
- (IBAction)doneBarButtonPressed:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [splashView setAlpha:1.0];
    [UIView commitAnimations];
}

- (void)backButtonTapped{
    
    [self.navigationController popViewControllerAnimated:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [splashView setAlpha:1.0];
    [UIView commitAnimations];
}

@end
