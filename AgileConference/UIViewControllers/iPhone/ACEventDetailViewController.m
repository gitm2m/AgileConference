//
//  ACEventDetailViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 01/01/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACEventDetailViewController.h"
#import "Twitter/TWTweetComposeViewController.h"

@implementation ACEventDetailViewController
@synthesize addRemoveFavsButton;
@synthesize topicDescriptionLinkTextView,delegate;

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

- (void)viewDidLoad
{
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = shareButton;
    [topicSummaryView  setText:[topicDict objectForKey:kTopicSummary]];
    [SpeakerSummaryView setText:[topicDict objectForKey:kTopicSpeaker]];
    
    if ([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"NO"]) {
        [addRemoveFavsButton setTitle:kAddtoFavs forState:UIControlStateNormal];
    }else if([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"YES"]){
        [addRemoveFavsButton setTitle:kRemoveFromFavs forState:UIControlStateNormal];
    }
    
    ACLog(@"[topicDict valueForKey:kTopicFavorite] %@", [topicDict valueForKey:kTopicFavorite]);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTopicDescriptionLinkTextView:nil];
    topicSummaryView = nil;
    SpeakerSummaryView = nil;
    [self setAddRemoveFavsButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Events Methods

- (IBAction)viewMoreButtonTapped:(id)sender {
    
        //[self dismissModalViewControllerAnimated:YES];
        //[delegate viewEventDescriptionButtonTapped:sender inView:self];
    
    ACEventDescriptionWebviewController *descriptionViewController = [[ACEventDescriptionWebviewController alloc] initWithNibName:@"ACEventDescriptionWebviewController" bundle:nil];
    
    [self.navigationController presentModalViewController:descriptionViewController animated:YES];


}

- (void)shareButtonTapped : (id)sender{
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"Share via" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter",@"Linkedin", nil];
    
        //[[[shareActionSheet valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"facebookIcon.png"] forState:UIControlStateNormal];
    shareActionSheet.delegate = self;
    [shareActionSheet showInView:self.view];
    
    
}

- (IBAction)addToFavsButtonTapped:(id)sender {
    
    if ([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"NO"]) {
        [topicDict setObject:@"YES" forKey:kTopicFavorite];
        [addRemoveFavsButton setTitle:kRemoveFromFavs forState:UIControlStateNormal];
    }else if([[topicDict valueForKey:kTopicFavorite] isEqualToString:@"YES"]){
        [topicDict setObject:@"NO" forKey:kTopicFavorite];
        [addRemoveFavsButton setTitle:kAddtoFavs forState:UIControlStateNormal];
    }
    
    ACLog(@"[topicDict valueForKey:kTopicFavorite] %@", [topicDict valueForKey:kTopicFavorite]);
    [[ACOrganiser getOrganiser]updateCatalogDict:topicDict];

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
        
    }
}

@end
