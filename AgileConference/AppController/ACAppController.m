//
//  ACViewController.m
//  AgileConference
//
//  Created by Valtech India on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ACAppController.h"
#import "ACOrganiser.h"
#import "ACAppSetting.h"
#import "Twitter/TWTweetComposeViewController.h"
#import "SBJSON.h"
#import "FbGraphFile.h"
#import "ACFacebookConnect.h"
#import "ViewUtility.h"


@implementation ACAppController
@synthesize organizerView;
@synthesize popOverImageView;
@synthesize contentView;


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

    
        //ACLog(@"%@", [UIFont fontNamesForFamilyName:@"Segoe UI"]);
    
    [daysSegmentController setFrame:CGRectMake(6, 9, 304, 28)]; 
    [daysSegmentController setBackgroundColor:[UIColor clearColor]];
    
    
        // [daysSegmentController setWidth:99 forSegmentAtIndex:0];
        //[daysSegmentController setWidth:99 forSegmentAtIndex:1];
        //[daysSegmentController setWidth:99 forSegmentAtIndex:2];
    
   /*
    [daysSegmentController setImage:[UIImage imageNamed:@"menuDay1Sel.png"] forSegmentAtIndex:0];
    [daysSegmentController setImage:[UIImage imageNamed:@"menuDay2Norm.png"] forSegmentAtIndex:1];
    [daysSegmentController setImage:[UIImage imageNamed:@"menuDay3Norm.png"] forSegmentAtIndex:2];
   */
    
    preFinalTrackIndex=3;
    preFinalDayIndex=0;
    
    tracksCoverFlowImgsArray = [[NSArray alloc] initWithObjects:@"track1.png",@"track2.png",@"track3.png",@"track4.png",@"track5.png",@"track6.png",@"track7.png", nil];
    
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
    [self setOrganizerView:nil];
    [self setPopOverImageView:nil];
    [self setContentView:nil];
    aboutButton = nil;
    
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
    [searchHolderView.searchResultTableView reloadData];
    [organizerView reloadTableViewData];
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
     return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Views Methods


- (void) setupView{
    
    
    //self.title = KAppName;
    
    organizerButtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [organizerButtn setFrame:CGRectMake(0, 432, 320, 35)];
    [organizerButtn setBackgroundColor:[UIColor clearColor]];
        //[organizerButtn setTitle:@"Organizer" forState:UIControlStateNormal];
    [organizerButtn setTitleColor:[UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0] forState:UIControlStateNormal];
    [[organizerButtn titleLabel] setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [organizerButtn setShowsTouchWhenHighlighted:YES];
    [organizerButtn addTarget:self action:@selector(organizerButtonTapped : ) forControlEvents:UIControlEventTouchUpInside];
    [organizerButtn setBackgroundImage:[UIImage imageNamed:@"Organizer.png"] forState:UIControlStateNormal];
    //[organizerButtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:organizerButtn];
    
    [self.view insertSubview:aboutButton aboveSubview:organizerButtn];

       
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [label setFont:[CommonUtility fontSegoiBold:18]];
    [label setTextAlignment:UITextAlignmentCenter];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor whiteColor]];
	[label setText:KAppName];
	[self.navigationController.navigationBar.topItem setTitleView:label];
     
    searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonTapped:)];
    
    searchDoneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(searchButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = searchButton;
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareButtonTapped:)];
    
    
    self.navigationItem.leftBarButtonItem = shareButton;


    /*
    UIButton *srchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [srchButton setFrame:CGRectMake(0, 0, 42, 33)];
    [srchButton setBackgroundImage:[UIImage imageNamed:@"searchIcon.png"] forState:UIControlStateNormal];
    [srchButton addTarget:self action:@selector(searchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    searchButton = [[UIBarButtonItem alloc] initWithCustomView:srchButton];
    
    searchDoneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(searchButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = searchButton;
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(0, 0, 42, 33)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"Action.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    */
     
    tracksCoverView = [[FlowCoverView alloc] initWithFrame:CGRectMake(6,-11, 308, 250)];
    [tracksCoverView  setBackgroundColor:[UIColor clearColor]];
    [[tracksCoverView layer] setCornerRadius : 5.0f];
    [tracksCoverView setDelegate:self];
    [homeCoverViewHolderView addSubview:tracksCoverView];
    
    [homeCoverViewHolderView insertSubview:daysSegmentController aboveSubview:tracksCoverView];
    NSString *dateAsString=[CommonUtility convertDateToString:[NSDate date] format:@"dd-MM-yyyy"];
    //
    if([dateAsString isEqualToString:@"17-02-2012"]){
        [daysSegmentController setSelectedSegmentIndex:0];
        [[ACAppSetting getAppSession] setDaySelected:@"Day1"];
        preFinalDayIndex=0;
        
    }else if([dateAsString isEqualToString:@"18-02-2012"]){
        [daysSegmentController setSelectedSegmentIndex:1];
        [[ACAppSetting getAppSession] setDaySelected:@"Day2"];
        preFinalDayIndex=1;

    }else if([dateAsString isEqualToString:@"19-02-2012"]){
        [daysSegmentController setSelectedSegmentIndex:2];
        [[ACAppSetting getAppSession] setDaySelected:@"Day3"];
        preFinalDayIndex=2;
        
    }else{
        [daysSegmentController setSelectedSegmentIndex:0];
        [[ACAppSetting getAppSession] setDaySelected:@"Day1"];
        preFinalDayIndex=0;
    }

    
     contentViewController = [[ACTracksEventsListViewController alloc] initWithNibName:@"ACTracksEventsListViewController" bundle:nil];
    contentViewController.delegate = self;
    [[contentViewController.view layer] setCornerRadius:5.0f];

    /*
    tracksEventsPopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
    [tracksEventsPopoverController presentPopoverFromRect:CGRectMake(110, 79, 100, 100) 
                                            inView:self.view 
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];

     */
    
    [contentView addSubview:contentViewController.view];
    
    [homeCoverViewHolderView insertSubview:popOverImageView aboveSubview:tracksCoverView];
    [homeCoverViewHolderView insertSubview:contentView aboveSubview:popOverImageView];
    [self setupViewsFromNib];
    
    [self showSplasScreen];
    
}


- (void) setupViewsFromNib{
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACSearchView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    for (id object in nibObjects) {
        if ([object isKindOfClass:[ACSearchView class]])
            [(ACSearchView*)object setDelegate:self];
        searchHolderView = (ACSearchView*)object;
    }  
    [searchHolderView setNeedsLayout];
    [searchHolderView setTag:1234];
    searchHolderView.frame = CGRectMake(0, -380, 320, 380);
    [self.view addSubview:searchHolderView];
    //
    
    
    
    NSArray *matrixViewNibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACMatrixCatalogView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    for (id object in matrixViewNibObjects) {
        if ([object isKindOfClass:[ACMatrixCatalogView class]])
            matrixCatalogView = (ACMatrixCatalogView*)object;
            //splashScreenView.delegate = self;
    }  
    matrixCatalogView.frame = CGRectMake(0, 8, 320, 407);
    matrixCatalogView.alpha = 0;    
    
    [self.view addSubview:matrixCatalogView];

    
    NSArray *organizerViewNibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACOrganizerView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    for (id object in organizerViewNibObjects) {
        if ([object isKindOfClass:[ACOrganizerView class]])
        organizerView = (ACOrganizerView*)object;
        organizerView.delegate = self;
    }  
    //
    [organizerView setNeedsLayout];
    organizerView.frame = CGRectMake(0, 415+46, 320, 380);
    [self.view addSubview:organizerView];
    
    
    NSArray *splashViewNibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACSplashView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    for (id object in splashViewNibObjects) {
        if ([object isKindOfClass:[ACSplashView class]])
            splashScreenView = (ACSplashView*)object;
            splashScreenView.delegate = self;
    }  
    splashScreenView.frame = CGRectMake(0, 0, 320, 480);
    
    [appDelegate.window addSubview:splashScreenView];

    
  
}

- (void)showSplasScreen{
    
    [splashScreenView setNeedsLayout];
	[splashScreenView setNeedsDisplay];
    
    
    /*
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [splashScreenView.logoImageView setFrame:CGRectMake(77, 169, 160, 80)];
    [UIView commitAnimations];
   */

    [self performSelector:@selector(animateLogoImageView) withObject:nil afterDelay:0];
    
}

- (void)animateLogoImageView{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [splashScreenView.logoImageView setFrame:CGRectMake(12, 123, 145, 115)];
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [splashScreenView.logo2 setFrame:CGRectMake(161, 118, 145, 115)];
    [UIView commitAnimations];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [splashScreenView.agileIndiaLogoImageView setAlpha:1.0];
    [UIView commitAnimations];

}

- (void)displayFacebookShareView{
    
    
    NSArray *fbShareViewNibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACFacebookShareView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    for (id object in fbShareViewNibObjects) {
        if ([object isKindOfClass:[ACFacebookShareView class]])
            fbShareView = (ACFacebookShareView*)object;
    }  
    fbShareView.delegate = self;
    [[fbShareView fbShareTextView] becomeFirstResponder];
    fbShareView.frame = CGRectMake(0, 46, 309, 168);
    
    [self.view addSubview:fbShareView];

}


- (void)animateViewsOnSwitchButtonTapped{
    
    if (homeCoverViewHolderView.alpha == 0) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [homeCoverViewHolderView setAlpha:1];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [matrixCatalogView setAlpha:0];
        [UIView commitAnimations];
        [tracksEventsPopoverController.view setHidden:NO];

    }else if (homeCoverViewHolderView.alpha == 1){
     
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [homeCoverViewHolderView setAlpha:0];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [matrixCatalogView setAlpha:1];
        [UIView commitAnimations];
        [tracksEventsPopoverController.view setHidden:YES];

    }
    
}


#pragma mark - Coverflow Delegate Methods

- (int)flowCoverNumberImages:(FlowCoverView *)view 
{
	return [tracksCoverFlowImgsArray count];
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)image
{
    ACLog(@"Track flowCover selected:%i",image);

	return [UIImage imageNamed:[tracksCoverFlowImgsArray objectAtIndex:image]];

}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)image
{
	
    //NSLog(@"Track didSelect selected:%i",image);

   // 0,1,2,6,5,4,3
   // 1,2,3,4,5,6,7
}
-(void)didSelectSlide:(NSInteger)index{
    
    if(preFinalTrackIndex!=finalTrackIndex){

        ACLog(@"did select slide>>>>>>>>>>%i",finalTrackIndex);
        NSString *trackSelected=[NSString stringWithFormat:@"Track%i",finalTrackIndex+1];
        [[ACAppSetting getAppSession]setTrackSelected:trackSelected];
        if(preFinalTrackIndex<finalTrackIndex) {
            [contentViewController reloadEventTableViewWithAnimation:NO];

        }else{
            [contentViewController reloadEventTableViewWithAnimation:YES];

        }
        preFinalTrackIndex=finalTrackIndex;
    }

}

-(void)slideChanged:(int)inIndex 

{
    finalTrackIndex=inIndex;
    //ACLog(@"Track : %d", inIndex);
}


#pragma mark - Events Methods

- (IBAction)aboutButtonTapped:(id)sender {
    
    ACAboutViewController *aboutController = [[ACAboutViewController alloc] init];
    [aboutController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    aboutController.splashView = splashScreenView;
    [self.navigationController presentModalViewController:aboutController animated:YES];    

}

- (IBAction)daysSegmentControllerValueChanged:(id)sender {
    
    /*
    if ([sender selectedSegmentIndex]==0) {

        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay1Sel.png"] forSegmentAtIndex:0];
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay2Norm.png"] forSegmentAtIndex:1];
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay3Norm.png"] forSegmentAtIndex:2];

    }else if ([sender selectedSegmentIndex]==1){
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay1Norm.png"] forSegmentAtIndex:0];
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay2Sel.png"] forSegmentAtIndex:1];
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay3Norm.png"] forSegmentAtIndex:2];
    }else if ([sender selectedSegmentIndex]==2){
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay1Norm.png"] forSegmentAtIndex:0];
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay2Norm.png"] forSegmentAtIndex:1];
        [daysSegmentController setImage:[UIImage imageNamed:@"menuDay3Sel.png"] forSegmentAtIndex:2];
    }*/
        
        NSString *daySelected=[NSString stringWithFormat:@"Day%i",[sender selectedSegmentIndex]+1];
    
        [[ACAppSetting getAppSession]setDaySelected:daySelected];
    //
        if(preFinalDayIndex<[sender selectedSegmentIndex]){

            [contentViewController reloadEventTableViewWithAnimation:NO];
        }else{
            [contentViewController reloadEventTableViewWithAnimation:YES];
        }
//
        preFinalDayIndex=[sender selectedSegmentIndex];

}


- (IBAction)infoButtonTapped:(id)sender {
    
    ACAboutViewController *aboutController = [[ACAboutViewController alloc] init];
    [aboutController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self.navigationController presentModalViewController:aboutController animated:YES];

}

- (void)searchButtonTapped : (id)sender{
    
    
    if ([self.view viewWithTag:1234].frame.origin.y == -380) {
        
        [[[TestUtility alloc] init] test];

        
        if([ self isOrganizerViewVisibleOnScreen]){
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [organizerButtn setFrame:CGRectMake(0, 382, 320, 35)];
            [organizerView setFrame:CGRectMake(0, 415, 320, 380)];
            [UIView commitAnimations];
        }
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.0001];
        [tracksEventsPopoverController.view setAlpha:0];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self.view viewWithTag:1234] setFrame:CGRectMake(0, 0, 320, 380)];
        [homeCoverViewHolderView setFrame:CGRectMake(0, 455, 320, 380)];
        [UIView commitAnimations];
        
        self.title = @"Search";
        self.navigationItem.rightBarButtonItem = searchDoneButton;
        

        
    }
    else if([self.view viewWithTag:1234].frame.origin.y == 0){
        
        [searchHolderView.eventsSearchBar resignFirstResponder];
        [searchHolderView.eventsSearchBar setText:@""];
        [searchHolderView cleanSearchView];
        if([ self isOrganizerViewVisibleOnScreen] && [self isSearchViewVisibleOnScreen]){
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [organizerButtn setFrame:CGRectMake(0, 382, 320, 35)];
            [organizerView setFrame:CGRectMake(0, 415, 320, 380)];
            [UIView commitAnimations];
            
            return;
        }

        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [tracksEventsPopoverController.view setAlpha:1];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self.view viewWithTag:1234] setFrame:CGRectMake(0, -380, 320, 380)];
        [homeCoverViewHolderView setFrame:CGRectMake(0, 0, 380, 380)];
        [UIView commitAnimations];
        
        self.title = KAppName;
        self.navigationItem.rightBarButtonItem = searchButton;
        
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
    
    NSString *string = nil;
    
    if (homeCoverViewHolderView.alpha == 0)
        string = @"Switch to cover view";
    else
        string = @"Switch to matrix view";
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share via Facebook",@"Share via Twitter",@"Write Feedback",@"About Valtech", nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
        //[[[shareActionSheet valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"facebookIcon.png"] forState:UIControlStateNormal];
    shareActionSheet.delegate = self;
    [shareActionSheet showInView:self.view];


    /*
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
    
     */
    
}

-(void)leftBarButtonClicked : (id)sender{
    
    NSString *string = nil;
    
    if (homeCoverViewHolderView.alpha == 0)
        string = @"Switch to cover view";
    else
        string = @"Switch to matrix view";
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share via Facebook",@"Share via Twitter",@"Write Feedback",@"About Valtech", nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    shareActionSheet.delegate = self;
    [shareActionSheet showInView:self.view];

    
}
-(void)rightBarButtonClicked : (id)sender{
    
   [[[TestUtility alloc] init] test];
    
    if ([self.view viewWithTag:1234].frame.origin.y == -380) {
        
        if([ self isOrganizerViewVisibleOnScreen]){
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [organizerButtn setFrame:CGRectMake(0, 432, 320, 35)];
            [organizerView setFrame:CGRectMake(0, 415+46, 320, 380)];
            [UIView commitAnimations];
        }
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.0001];
        [tracksEventsPopoverController.view setAlpha:0];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self.view viewWithTag:1234] setFrame:CGRectMake(0, 44, 320, 380)];
        [homeCoverViewHolderView setFrame:CGRectMake(0, 455, 320, 380)];
        [UIView commitAnimations];
        
        self.title = @"Search";
        self.navigationItem.rightBarButtonItem = searchDoneButton;
            //[rightBarButton setImage:[UIImage imageNamed:@"doneBtn.png"] forState:UIControlStateNormal];
            //rightBarButton.frame = CGRectMake(264, 10, 49, 23) ; 
        
    }else if([self.view viewWithTag:1234].frame.origin.y ==44){
        
        [searchHolderView.eventsSearchBar resignFirstResponder];
        if([ self isOrganizerViewVisibleOnScreen] && [self isSearchViewVisibleOnScreen]){
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [organizerButtn setFrame:CGRectMake(0, 432, 320, 35)];
            [organizerView setFrame:CGRectMake(0, 415+46, 320, 380)];
            [UIView commitAnimations];
            
            return;
        }
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [tracksEventsPopoverController.view setAlpha:1];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self.view viewWithTag:1234] setFrame:CGRectMake(0, -380, 320, 380)];
        [homeCoverViewHolderView setFrame:CGRectMake(0, 44, 380, 380)];
        [UIView commitAnimations];
        
        self.title = KAppName;
        self.navigationItem.rightBarButtonItem = searchButton;
            // [rightBarButton setImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
            //rightBarButton.frame = CGRectMake(278, 10, 25, 24) ;
    }

    
}

-(void)organizerButtonTapped : (id)sender{
    
    if([self isSearchViewVisibleOnScreen]){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [tracksEventsPopoverController.view setAlpha:1];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self.view viewWithTag:1234] setFrame:CGRectMake(0, -380, 320, 380)];
        [homeCoverViewHolderView setFrame:CGRectMake(0, 44, 380, 380)];
        [UIView commitAnimations];
         
    }

    if (organizerButtn.frame.origin.y == 432) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [organizerButtn setFrame:CGRectMake(0,44, 320, 35)];
        [organizerView setFrame:CGRectMake(0, 35+44, 320, 380)];
        [organizerView reloadTableViewData];
        [UIView commitAnimations];

    }else if(organizerButtn.frame.origin.y == 44){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [organizerButtn setFrame:CGRectMake(0, 432, 320, 35)];
        [organizerView setFrame:CGRectMake(0, 415+46, 320, 380)];
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - Validation Methods

- (BOOL)isOrganizerViewVisibleOnScreen{
    
    if(organizerButtn.frame.origin.y == 44)
        return YES;
    else
        return NO;
    
}

- (BOOL)isSearchViewVisibleOnScreen{
    
    if([self.view viewWithTag:1234].frame.origin.y == 44)
        return YES;
    else
        return NO;
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

#pragma mark - ACSearchViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withDict:(NSMutableDictionary *)dict{
    
    ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil andTopicDict:dict];
    [detailViewController setIsNavigatedFromOrganizerView:NO];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - ACTracksEventsListViewControllerDelegate Methods

- (void)viewMoreTopicsButtonTapped:(id)sender inView:(ACTracksEventsListViewController*)tracksEventsListView{
    
    ACEventsListViewController *eventsListViewController = [[ACEventsListViewController alloc] initWithNibName:@"ACEventsListViewController" bundle:nil];
    [self.navigationController pushViewController:eventsListViewController animated:YES];
    
}


- (void)eventsTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil andTopicIndex:indexPath.row];
    
    [detailViewController setIsNavigatedFromOrganizerView:NO];
    [self.navigationController pushViewController:detailViewController animated:YES];

}

#pragma mark - ACOrganizerViewDelegate Methods
- (void)organizerListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withDict:(NSMutableDictionary  *)dict{
    
    ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil andTopicDict:dict];
    [detailViewController setIsNavigatedFromOrganizerView:YES];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        if (![CommonUtility isConnectedToNetwork]) {
            [ViewUtility showAlertViewWithMessage:@"Network connection attempt failed,Please check your internet connection."];
            return;
        }
        
       
        if (NSClassFromString(@"TWTweetComposeViewController")) {
                       
            TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc]init];
            [twitter setInitialText:@"Write your text here!!"];
                //[twitter addImage:[UIImage imageNamed:@"bg_moderator_notes1.png"]];
            
            [self presentViewController:twitter animated:YES completion:nil];
            
            twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
                
                if(res == TWTweetComposeViewControllerResultDone)
                    {
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Succes!" message:@"Your Tweet was posted succesfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                    
                    }else if(res == TWTweetComposeViewControllerResultCancelled)
                        {
                        
                            // UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your Tweet was not posted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                            //  [alertView show];
                        
                        }
                
                [self dismissModalViewControllerAnimated:YES];
                
                
            };

        }else{
            [ViewUtility showAlertViewWithMessage:@"You can able to tweet only with iOS5,Sorry for the inconvenience"];
        }
        
            
    }else if(buttonIndex == 0){
        
        if (![CommonUtility isConnectedToNetwork]) {
            [ViewUtility showAlertViewWithMessage:@"Network connection attempt failed,Please check your internet connection."];
            return;
        }
        
        if ( ([[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken == nil) || ([[[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken length] == 0) ){
            
            isFBLoginFirtTime = YES;
            [[ACFacebookConnect getFacebookConnectObject] checkForSessionWithCallbackObject:self andSelector:@selector(fbGraphCallback:)];
        
        }else{
             [self displayFacebookShareView];
        }
        
              
       
      
    }else if(buttonIndex == 3){
        
        
        ACAboutViewController *aboutController = [[ACAboutViewController alloc] init];
        [aboutController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        aboutController.splashView = splashScreenView;
        [self.navigationController presentModalViewController:aboutController animated:YES];
        
        /*
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [splashScreenView setAlpha:1.0];
        UITableViewCell *cell = [splashScreenView.menuTbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.textLabel setText:@"Return to application"];
        [UIView commitAnimations];
         */
        

    }else if(buttonIndex == 2){
        ACFeedbackViewController *feedbackViewController = [[ACFeedbackViewController alloc] initWithNibName:@"ACFeedbackViewController" bundle:nil];
        feedbackViewController.isOverallEventFeedback = YES;
        [self.navigationController presentModalViewController:feedbackViewController animated:YES];
    }
}


#pragma mark -
#pragma mark FbGraph Callback Function
/**
 * This function is called by FbGraph after it's finished the authentication process
 **/
- (void)fbGraphCallback:(id)sender {
	
        // [[ACFacebookConnect getFacebookConnectObject] checkForSessionWithCallbackObject:self andSelector:@selector(fbGraphCallback:)];
    
   
    
    if ( ([[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken == nil) || ([[[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken length] == 0) ) {
		
		ACLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
		
         isFBLoginFirtTime = NO;
            //restart the authentication process.....
            //[[[ACFacebookConnect getFacebookConnectObject] fbGraph] authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) 
            // andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
        NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie* cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            [cookies deleteCookie:cookie];
        }
		
	} else {
        
		ACLog(@"------------>CONGRATULATIONS<------------, You're logged into Facebook...  Your oAuth token is:  %@", [[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken);
        
//        if(didFinishedPostingOnWall){
//            didFinishedPostingOnWall = NO;
//            [self postFacebookFeedOnPage];
//        }
//		
	}
    
    if(isFBLoginFirtTime){
        [self displayFacebookShareView];
        isFBLoginFirtTime = NO;
    }
	
}

#pragma mark - ACFacebookShareViewDelegate Methods

-(void)cancelButtonTapped : (id)sender{
    
    [[fbShareView fbShareTextView] resignFirstResponder];
    [fbShareView removeFromSuperview];
    
}

-(void)sendButtonTapped : (id)sender{
    
    [self postFacebookFeed];
    
    [[fbShareView fbShareTextView] resignFirstResponder];
    [fbShareView removeFromSuperview];
}


- (void)postFacebookFeed{
    
    NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
    
    NSString *string = [[NSString alloc] initWithFormat:@"%@ - Posted via Valtech's AgileConference2012 iPhone app",[[fbShareView fbShareTextView]text]];
    
    [variables setObject:string forKey:@"message"];
        //[variables setObject:@"http://bit.ly/bFTnqd" forKey:@"link"];
        //[variables setObject:@"This is the bolded copy next to the image" forKey:@"name"];
        //[variables setObject:[[fbShareView fbShareTextView]text] forKey:@"description"];
    
    FbGraphResponse *fb_graph_response = [[[ACFacebookConnect getFacebookConnectObject] fbGraph] doGraphPost:@"me/feed" withPostVars:variables];
    NSLog(@"postMeFeedButtonPressed:  %@", fb_graph_response.htmlResponse);
    
        //parse our json
    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *facebook_response = [parser objectWithString:fb_graph_response.htmlResponse error:nil];	
    
    
        //let's save the 'id' Facebook gives us so we can delete it if the user presses the 'delete /me/feed button'
    [[ACFacebookConnect getFacebookConnectObject] setFeedPostId:(NSString *)[facebook_response objectForKey:@"id"]];
    NSLog(@"feedPostId, %@", [[ACFacebookConnect getFacebookConnectObject] feedPostId]);
    NSLog(@"Now log into Facebook and look at your profile...");
    
    didFinishedPostingOnWall = YES;
    [self postFacebookFeedOnPage];

}

- (void)postFacebookFeedOnPage{
    NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
    
    NSString *string = [[NSString alloc] initWithFormat:@"%@ - Posted via Valtech's AgileConference2012 iPhone app",[[fbShareView fbShareTextView]text]];
    
    [variables setObject:string forKey:@"message"];
        //[variables setObject:@"http://bit.ly/bFTnqd" forKey:@"link"];
        //[variables setObject:@"This is the bolded copy next to the image" forKey:@"name"];
        //[variables setObject:[[fbShareView fbShareTextView]text] forKey:@"description"];
    
    FbGraphResponse *fb_graph_response = [[[ACFacebookConnect getFacebookConnectObject] fbGraph] doGraphPost:@"40796308305/feed" withPostVars:variables];
    NSLog(@"postMeFeedButtonPressed:  %@", fb_graph_response.htmlResponse);
    
        //parse our json
    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *facebook_response = [parser objectWithString:fb_graph_response.htmlResponse error:nil];	
    
    
        //let's save the 'id' Facebook gives us so we can delete it if the user presses the 'delete /me/feed button'
    [[ACFacebookConnect getFacebookConnectObject] setFeedPostId:(NSString *)[facebook_response objectForKey:@"id"]];
    NSLog(@"feedPostId, %@", [[ACFacebookConnect getFacebookConnectObject] feedPostId]);
    NSLog(@"Now log into Facebook and look at your profile...");

    
}

#pragma ACSplashViewDelegate Methods

-(void) aboutValtechTapped : (NSIndexPath *)indexPath{
    
    ACAboutViewController *aboutController = [[ACAboutViewController alloc] init];
    [aboutController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    aboutController.splashView = splashScreenView;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [splashScreenView setAlpha:0.0];
    [UIView commitAnimations];
    [self.navigationController pushViewController:aboutController animated:YES];
}


@end
