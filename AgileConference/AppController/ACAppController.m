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


@implementation ACAppController
@synthesize organizerView;


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
    preFinalTrackIndex=3;
    
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
     return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Views Methods

- (void) setupView{
    
    self.title = KAppName;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = searchButton;
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareButtonTapped:)];
    
    self.navigationItem.leftBarButtonItem = shareButton;
    
    tracksCoverView = [[FlowCoverView alloc] initWithFrame:CGRectMake(6,-11, 308, 250)];
    [tracksCoverView  setBackgroundColor:[UIColor clearColor]];
    [[tracksCoverView layer] setCornerRadius : 5.0f];
    [tracksCoverView setDelegate:self];
    [homeCoverViewHolderView addSubview:tracksCoverView];
    
    [homeCoverViewHolderView insertSubview:daysSegmentController aboveSubview:tracksCoverView];
    
     contentViewController = [[ACTracksEventsListViewController alloc] initWithNibName:@"ACTracksEventsListViewController" bundle:nil];
    contentViewController.delegate = self;
    [[contentViewController.view layer] setCornerRadius:5.0f];

    
    tracksEventsPopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
    [tracksEventsPopoverController presentPopoverFromRect:CGRectMake(110, 79, 100, 100) 
                                            inView:self.view 
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];

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
    NSArray *organizerViewNibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACOrganizerView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    for (id object in organizerViewNibObjects) {
        if ([object isKindOfClass:[ACOrganizerView class]])
        organizerView = (ACOrganizerView*)object;
        organizerView.delegate = self;
    }  
    //
    organizerView.frame = CGRectMake(0, 415, 320, 380);
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
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [splashScreenView.logoImageView setFrame:CGRectMake(77, 169, 160, 80)];
    [UIView commitAnimations];
   

    [self performSelector:@selector(animateLogoImageView) withObject:nil afterDelay:2];
    
}

- (void)animateLogoImageView{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [splashScreenView.logoImageView setFrame:CGRectMake(77, 30, 160, 80)];
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3];
    [splashScreenView.logo2 setAlpha:1.0];
    [splashScreenView.menuTbView setAlpha:1.0];
    [splashScreenView.poweredbyLable setAlpha:1.0];
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
    fbShareView.frame = CGRectMake(6, 2, 309, 232);
    
    [self.view addSubview:fbShareView];

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

-(void)slideChanged: (int) inIndex 

{
    //NSLog(@"Track selected:%i",inIndex);
    finalTrackIndex=inIndex;
    //ACLog(@"Track : %d", inIndex);
}


#pragma mark - Events Methods

- (IBAction)daysSegmentControllerValueChanged:(id)sender {
    

        //if(preFinalTrackIndex!=finalTrackIndex){

   // if(preFinalTrackIndex!=finalTrackIndex){

        NSString *daySelected=[NSString stringWithFormat:@"Day%i",[sender selectedSegmentIndex]+1];
        [[ACAppSetting getAppSession]setDaySelected:daySelected];
        [contentViewController reloadEventTableViewWithAnimation:YES];
        preFinalTrackIndex=finalTrackIndex;

        // }

    //}


}


- (IBAction)infoButtonTapped:(id)sender {
    
    ACAboutViewController *aboutController = [[ACAboutViewController alloc] init];
    [aboutController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self.navigationController presentModalViewController:aboutController animated:YES];

}

- (void)searchButtonTapped : (id)sender{

    
    if ([self.view viewWithTag:1234].frame.origin.y == -380) {
        
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
        
    }else if([self.view viewWithTag:1234].frame.origin.y == 0){
        
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
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"Share via" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter",@"Linkedin", nil];
    
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


-(void)organizerButtonTapped : (id)sender{
    
    if (organizerButtn.frame.origin.y == 382) {
        
        
        [organizerView.organizerListTableView reloadData];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [organizerButtn setFrame:CGRectMake(0, 0, 320, 35)];
        [organizerView setFrame:CGRectMake(0, 35, 320, 380)];
        [UIView commitAnimations];

    }else if(organizerButtn.frame.origin.y == 0){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [organizerButtn setFrame:CGRectMake(0, 382, 320, 35)];
        [organizerView setFrame:CGRectMake(0, 415, 320, 380)];
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - Validation Methods

- (BOOL)isOrganizerViewVisibleOnScreen{
    
    if(organizerButtn.frame.origin.y == 0)
        return YES;
    else
        return NO;
    
}

- (BOOL)isSearchViewVisibleOnScreen{
    
    if([self.view viewWithTag:1234].frame.origin.y == 0)
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil];
    [detailViewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - ACTracksEventsListViewControllerDelegate Methods

- (void)viewMoreTopicsButtonTapped:(id)sender inView:(ACTracksEventsListViewController*)tracksEventsListView{
    
    ACEventsListViewController *eventsListViewController = [[ACEventsListViewController alloc] initWithNibName:@"ACEventsListViewController" bundle:nil];
    [self.navigationController pushViewController:eventsListViewController animated:YES];
    
}


- (void)eventsTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil andTopicIndex:indexPath.row];
    
    [detailViewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self.navigationController pushViewController:detailViewController animated:YES];

}

#pragma mark - ACOrganizerViewDelegate Methods
- (void)organizerListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withDict:(NSMutableDictionary  *)dict{
    
    ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil andTopicDict:dict];
    [detailViewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
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

    }else if(buttonIndex == 0){
        
        if ( ([[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken == nil) || ([[[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken length] == 0) ){
            
            isFBLoginFirtTime = YES;
            [[ACFacebookConnect getFacebookConnectObject] checkForSessionWithCallbackObject:self andSelector:@selector(fbGraphCallback:)];
        
        }else{
             [self displayFacebookShareView];
        }
        
              
       
      
    }
}


#pragma mark -
#pragma mark FbGraph Callback Function
/**
 * This function is called by FbGraph after it's finished the authentication process
 **/
- (void)fbGraphCallback:(id)sender {
	
        // [[ACFacebookConnect getFacebookConnectObject] checkForSessionWithCallbackObject:self andSelector:@selector(fbGraphCallback:)];
    
    if(isFBLoginFirtTime){
        [self displayFacebookShareView];
        isFBLoginFirtTime = NO;
    }
    
    if ( ([[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken == nil) || ([[[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken length] == 0) ) {
		
		ACLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
		
            //restart the authentication process.....
		[[[ACFacebookConnect getFacebookConnectObject] fbGraph] authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) 
							 andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
		
	} else {
        
		ACLog(@"------------>CONGRATULATIONS<------------, You're logged into Facebook...  Your oAuth token is:  %@", [[ACFacebookConnect getFacebookConnectObject] fbGraph].accessToken);
        
//        if(didFinishedPostingOnWall){
//            didFinishedPostingOnWall = NO;
//            [self postFacebookFeedOnPage];
//        }
//		
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
