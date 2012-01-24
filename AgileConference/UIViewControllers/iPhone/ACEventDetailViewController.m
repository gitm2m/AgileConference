//
//  ACEventDetailViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 01/01/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACEventDetailViewController.h"
#import "Twitter/TWTweetComposeViewController.h"
#import "SBJSON.h"
#import "ViewUtility.h"

@implementation ACEventDetailViewController
@synthesize addRemoveFavsButton;
@synthesize topicDescriptionLinkTextView,delegate,isNavigatedFromOrganizerView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTopicIndex:(NSInteger)index{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
        NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];
        
        NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
        NSMutableArray *topicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];
        topicDict=[topicArray objectAtIndex:index];
        
               
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTopicDict:(NSMutableDictionary *)topicDictionary{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        topicDict=topicDictionary;
        

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


-(void)setupInitialView{
    
    
    UIImageView *bgHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0.0,0, 320.0, 44.0)];
    [bgHeader setBackgroundColor:[UIColor clearColor]];
    [bgHeader setImage:[UIImage imageNamed:@"titleRow.png"]];
    [[self view] addSubview:bgHeader];
        //[bgHeader release];
    
    leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setBackgroundImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    leftBarButton.frame = CGRectMake(7, 10, 49, 23);
    [leftBarButton addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBarButton];
    
    rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setBackgroundImage:[UIImage imageNamed:@"actionIcon.png"] forState:UIControlStateNormal];
    rightBarButton.frame = CGRectMake(285, 11, 21, 21) ; 
    [rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBarButton];
    
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 5, 300, 35)];
    [headerLabel setFont:[CommonUtility fontSegoiBold:17]];
    [headerLabel setText:@"Event Detail"];
    [headerLabel setTextAlignment:UITextAlignmentCenter];
    [headerLabel setTextColor:[UIColor darkGrayColor]];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headerLabel];
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = shareButton;
    [topicSummaryView  setText:[topicDict objectForKey:kTopicSummary]];
    [SpeakerSummaryView setText:[topicDict objectForKey:kTopicSpeakerSummary]];
    [viewTopicSummaryButton setTitle:[topicDict objectForKey:kTopicLink] forState:UIControlStateReserved];
    [viewSpeakerSummaryButton setTitle:[topicDict objectForKey:kTopicSpeakerLink] forState:UIControlStateReserved];

    
    if ([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"NO"]) {
            //[addRemoveFavsButton setTitle:kAddtoFavs forState:UIControlStateNormal];
        [addRemoveFavsButton setImage:[UIImage imageNamed:@"starDull.png"] forState:UIControlStateNormal];
    }else if([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"YES"]){
            //[addRemoveFavsButton setTitle:kRemoveFromFavs forState:UIControlStateNormal];
        [addRemoveFavsButton setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    }
    
    [speakerHeaderLabel setFont:[CommonUtility fontSegoiBold:14]];
    [topicHeaderLabel setFont:[CommonUtility fontSegoiBold:14]];
    [SpeakerSummaryView setFont:[CommonUtility fontSegoi:13]];
    [topicSummaryView setFont:[CommonUtility fontSegoi:13]];
    
    [topicSummaryView flashScrollIndicators];
    [SpeakerSummaryView flashScrollIndicators];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(animateScrollIndicators) userInfo:nil repeats:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void) animateScrollIndicators {
    
    [topicSummaryView flashScrollIndicators];
    [SpeakerSummaryView flashScrollIndicators];
}

- (void)viewDidUnload
{
    [self setTopicDescriptionLinkTextView:nil];
    topicSummaryView = nil;
    SpeakerSummaryView = nil;
    [self setAddRemoveFavsButton:nil];
    
    topicHeaderLabel = nil;
    speakerHeaderLabel = nil;
    viewTopicSummaryButton = nil;
    viewSpeakerSummaryButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    fbShareView.frame = CGRectMake(0, 46, 320, 194);
    
    [self.view addSubview:fbShareView];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Events Methods

-(void)leftBarButtonClicked : (id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBarButtonClicked : (id)sender{
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"Share via" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter", nil];
    
        //[[[shareActionSheet valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"facebookIcon.png"] forState:UIControlStateNormal];
    shareActionSheet.delegate = self;
    [shareActionSheet showInView:self.view];
    
}

- (IBAction)viewMoreButtonTapped:(id)sender {
    
    if (![CommonUtility isConnectedToNetwork]) {
        [ViewUtility showAlertViewWithMessage:@"Network connection attempt failed,Please check your internet connection."];
        return ;
        
    }

    
        //[self dismissModalViewControllerAnimated:YES];
        //[delegate viewEventDescriptionButtonTapped:sender inView:self];
    
    ACEventDescriptionWebviewController *descriptionViewController = [[ACEventDescriptionWebviewController alloc] initWithNibName:@"ACEventDescriptionWebviewController" andURL:[(UIButton *)sender titleForState:UIControlStateReserved]];
    [self.navigationController presentModalViewController:descriptionViewController animated:YES];

}

- (void)shareButtonTapped : (id)sender{
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"Share via" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter", nil];
    
        //[[[shareActionSheet valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"facebookIcon.png"] forState:UIControlStateNormal];
    shareActionSheet.delegate = self;
    [shareActionSheet showInView:self.view];
    
    
}

- (IBAction)addToFavsButtonTapped:(id)sender {
    
    if ([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"NO"]) {
        
        [topicDict setObject:@"YES" forKey:kTopicFavorite];
        [addRemoveFavsButton setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
            //[addRemoveFavsButton setTitle:kRemoveFromFavs forState:UIControlStateNormal];
        [[ACOrganiser getOrganiser]updateCatalogDict:topicDict];
        [CommonUtility schedulPreNotificationOfEvent:topicDict];
        
    }else if([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"YES"]){
     
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAppName 
                                                            message:@"Are you sure you want to remove from favourites." 
                                                           delegate:self 
                                                  cancelButtonTitle:@"No" 
                                                  otherButtonTitles:@"Yes", nil];
        [alertView show];

        
    }
    

}

- (IBAction)writeFeedbackButtonTapped:(id)sender {
    
    ACFeedbackViewController *feedbackViewController = [[ACFeedbackViewController alloc] initWithNibName:@"ACFeedbackViewController" bundle:nil];
    feedbackViewController.isOverallEventFeedback = NO;
    feedbackViewController.eventDetailDict = topicDict;
    [self.navigationController presentModalViewController:feedbackViewController animated:YES];
    
}



#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc]init];
        [twitter setInitialText:@"It's really that simple!"];
        [twitter addImage:[UIImage imageNamed:@"twitter.png"]];
        
        [self presentViewController:twitter animated:YES completion:nil];
        
        twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
            
            if(res == TWTweetComposeViewControllerResultDone)
                {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Succes!" message:@"Your Tweet was posted succesfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertView show];
                
                }else if(res == TWTweetComposeViewControllerResultCancelled)
                    {
                    
                        //  UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your Tweet was not posted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                        // [alertView show];
                    
                    }
            
            [self dismissModalViewControllerAnimated:YES];
            
            
        };
        
    }else
        if(buttonIndex == 0){
            
                //[ViewUtility showAlertViewWithMessage:@"Could not connect to facebook,please try again later."];
        
        
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


# pragma mark UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [topicDict setObject:@"NO" forKey:kTopicFavorite];
        [addRemoveFavsButton setImage:[UIImage imageNamed:@"starDull.png"] forState:UIControlStateNormal];
            //[addRemoveFavsButton setTitle:kAddtoFavs forState:UIControlStateNormal];
        [[ACOrganiser getOrganiser]updateCatalogDict:topicDict];
        [CommonUtility cancelNotificationOfEvent:topicDict];

        
        if(isNavigatedFromOrganizerView)
            [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
