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
@synthesize daysSegmentController;
@synthesize shareFeedBackView;
@synthesize homeCoverViewHolderView,searchHolderView;

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
    [self setInfoButton:nil];
    [self setShareFeedBackView:nil];
    [self setHomeCoverViewHolderView:nil];
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
    
    self.navigationItem.leftBarButtonItem = shareButton;
    
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACSearchView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    searchHolderView = [nibObjects objectAtIndex:0];
    [searchHolderView setTag:1234];
    searchHolderView.frame = CGRectMake(0, -380, 320, 380);
    
    [self.view addSubview:searchHolderView];
    
    tracksCoverView = [[FlowCoverView alloc] initWithFrame:CGRectMake(6,0, 308, 250)];
    [tracksCoverView  setBackgroundColor:[UIColor clearColor]];
    [[tracksCoverView layer] setCornerRadius : 5.0f];
    [tracksCoverView setDelegate:self];
    [homeCoverViewHolderView addSubview:tracksCoverView];
    
    [homeCoverViewHolderView insertSubview:daysSegmentController aboveSubview:tracksCoverView];
    
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


- (IBAction)infoButtonTapped:(id)sender {

}

- (void)searchButtonTapped : (id)sender{

    
    if ([self.view viewWithTag:1234].frame.origin.y == -380) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.0001];
        [tracksEventsPopoverController.view setAlpha:0];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self.view viewWithTag:1234] setFrame:CGRectMake(0, 0, 320, 380)];
        [homeCoverViewHolderView setFrame:CGRectMake(0, 455, 320, 380)];
        [UIView commitAnimations];
        
    }else if([self.view viewWithTag:1234].frame.origin.y == 0){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [tracksEventsPopoverController.view setAlpha:1];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self.view viewWithTag:1234] setFrame:CGRectMake(0, -380, 320, 380)];
        [homeCoverViewHolderView setFrame:CGRectMake(0, 0, 380, 380)];
        [UIView commitAnimations];

    }
        
    //Commented searchPopover
    /*
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
    [infoButton setUserInteractionEnabled:NO];
     */


    
}

- (void)shareButtonTapped : (id)sender{
    

    
    [self.view insertSubview:shareFeedBackView aboveSubview:tracksEventsPopoverController.view];
    
    [self.view insertSubview:shareFeedBackView aboveSubview:organizerButtn];
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
    
    /*
    [tracksCoverView setUserInteractionEnabled:YES];
    [tracksEventsPopoverController.view setUserInteractionEnabled:YES];
    [daysSegmentController setUserInteractionEnabled:YES];
    [infoButton setUserInteractionEnabled:YES];
     */
   }

@end
