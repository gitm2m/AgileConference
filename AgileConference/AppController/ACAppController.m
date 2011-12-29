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
    
    tracksCoverView = [[FlowCoverView alloc] initWithFrame:CGRectMake(6,0, 308, 250)];
    [tracksCoverView  setBackgroundColor:[UIColor clearColor]];
    [[tracksCoverView layer] setCornerRadius : 8];
    [tracksCoverView setDelegate:self];
    [self.view addSubview:tracksCoverView];
    
    ACTracksEventsListViewController *contentViewController = [[ACTracksEventsListViewController alloc] initWithNibName:@"ACTracksEventsListViewController" bundle:nil];

    
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
	
    ACLog(@"image index1 %d", image);

    
}

-(void)slideChanged: (int) inIndex 
{
	ACLog(@"image index2 %d", inIndex);
}


#pragma mark - CustomPopoverDelegate Methods

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)popoverController {
    
    
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)popoverController {
    return YES;
}


@end
