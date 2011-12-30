//
//  ACViewController.m
//  AgileConference
//
//  Created by Valtech India on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ACAppController.h"
    //#import "ACAppConstants.h"

@implementation ACAppController

@synthesize infoButton;
@synthesize organizerButton;
@synthesize daysSegmentController;
@synthesize shareFeedBackView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    tracksCoverFlowImgsArray = [[NSArray alloc] initWithObjects:@"i12.png",@"i13.png",@"i14.png",@"i15.png",@"i16.png",@"i17.png",@"i18.png", nil];
    
    [self setupView];
    [super viewDidLoad];
    
    

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    daysSegmentController = nil;
    [self setDaysSegmentController:nil];
    [self setOrganizerButton:nil];
    [self setInfoButton:nil];
    [self setShareFeedBackView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Views Methods

- (void) setupView{
    
    self.title = KAppName;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = searchButton;
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareButtonTapped:)];
    
    self.navigationItem.leftBarButtonItem =shareButton;
    
    tracksCoverView = [[FlowCoverView alloc] initWithFrame:CGRectMake(6,0, 308, 250)];
    [tracksCoverView  setBackgroundColor:[UIColor clearColor]];
    [[tracksCoverView layer] setCornerRadius : 5.0f];
    [tracksCoverView setDelegate:self];
    [self.view addSubview:tracksCoverView];
    
    [self.view insertSubview:daysSegmentController aboveSubview:tracksCoverView];
    
     contentViewController = [[ACTracksEventsListViewController alloc] initWithNibName:@"ACTracksEventsListViewController" bundle:nil];
    [[contentViewController.view layer] setCornerRadius:5.0f];

    
    tracksEventsPopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
    [tracksEventsPopoverController presentPopoverFromRect:CGRectMake(110, 90, 100, 100) 
                                            inView:self.view 
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];

    
}


#pragma mark - Coverflow Delegate Methods

- (int)flowCoverNumberImages:(FlowCoverView *)view 
{
	return [tracksCoverFlowImgsArray count];
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)image
{
	return [UIImage imageNamed:[tracksCoverFlowImgsArray objectAtIndex:image]];
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)image
{
	
 
    
}

-(void)slideChanged: (int) inIndex 
{

}


#pragma mark - Events Methods

- (IBAction)daysSegmentControllerValueChanged:(id)sender {

}

- (IBAction)organizerButtonTapped:(id)sender {
    
}

- (IBAction)infoButtonTapped:(id)sender {

}

- (void)searchButtonTapped : (id)sender{
    
    
    
    if([searchPopoverController isPopoverVisible]) {
        [searchPopoverController dismissPopoverAnimated:YES];
        [searchPopoverController setDelegate:nil];
        searchPopoverController = nil;
    }
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    serachPopoverContentViewController = [[ACSearchPopoverViewController alloc] initWithNibName:@"ACSearchPopoverViewController" bundle:nil];
    [[serachPopoverContentViewController.view layer] setCornerRadius:5.0f];
    
    
    searchPopoverController = [[WEPopoverController alloc] initWithContentViewController:serachPopoverContentViewController];
    [searchPopoverController setDelegate:self];
    [searchPopoverController presentPopoverFromRect:CGRectMake(screenBounds.size.width, 0, 50, 57)
                                                   inView:self.navigationController.view 
                                 permittedArrowDirections:UIPopoverArrowDirectionUp
                                                 animated:YES];
    
   

    [tracksCoverView setUserInteractionEnabled:NO];
    [tracksEventsPopoverController.view setUserInteractionEnabled:NO];
    [daysSegmentController setUserInteractionEnabled:NO];
    [organizerButton setUserInteractionEnabled:NO];
    [infoButton setUserInteractionEnabled:NO];


    
}

- (void)shareButtonTapped : (id)sender{
    
    [self.view insertSubview:shareFeedBackView aboveSubview:tracksEventsPopoverController.view];
    if (shareFeedBackView.frame.origin.y == 463) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        shareFeedBackView.frame=CGRectMake(0, 303, 320, 113);
        [UIView commitAnimations];
    }else if (shareFeedBackView.frame.origin.y == 303){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        shareFeedBackView.frame=CGRectMake(0, 463, 320, 113);
        [UIView commitAnimations];
    }
    

    
}

#pragma mark - CustomPopoverDelegate Methods

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)popoverController {
    
    
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)popoverController {
    return YES;
}


#pragma mark - UITouchEvent Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if([searchPopoverController isPopoverVisible]) {
        [searchPopoverController dismissPopoverAnimated:YES];
        [searchPopoverController setDelegate:nil];
        searchPopoverController = nil;
    }
    
    
    [tracksCoverView setUserInteractionEnabled:YES];
    [tracksEventsPopoverController.view setUserInteractionEnabled:YES];
    [daysSegmentController setUserInteractionEnabled:YES];
    [organizerButton setUserInteractionEnabled:YES];
    [infoButton setUserInteractionEnabled:YES];
   }

@end
