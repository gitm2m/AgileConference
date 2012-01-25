//
//  ACEventDetailViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 01/01/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACEventDescriptionWebviewController.h"
#import "ACOrganiser.h"
#import "ACAppConstants.h"
#import "ACFacebookConnect.h"
#import "ACFacebookShareView.h"
#import "ACFeedbackViewController.h"
#import "ACCustomRootViewController.h"

@protocol ACEventDetailViewControllerDelegate;

@interface ACEventDetailViewController : ACCustomRootViewController<UIActionSheetDelegate,ACFacebookShareViewDelegate>{
    
    IBOutlet UILabel *speakerHeaderLabel;
    IBOutlet UILabel *topicHeaderLabel;
    IBOutlet UITextView *SpeakerSummaryView;
    IBOutlet UITextView *topicSummaryView;
    NSMutableDictionary *topicDict;
    BOOL isFBLoginFirtTime,didFinishedPostingOnWall;
    ACFacebookShareView *fbShareView;
    IBOutlet UIButton *viewTopicSummaryButton;
    IBOutlet UIButton *viewSpeakerSummaryButton;
}

@property (strong, nonatomic) IBOutlet UITextView *topicDescriptionLinkTextView;
@property (strong, nonatomic) id<ACEventDetailViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet UIButton *addRemoveFavsButton;
@property BOOL isNavigatedFromOrganizerView;

- (IBAction)addToiCalButtonTapped:(id)sender;
- (IBAction)viewMoreButtonTapped:(id)sender;
- (void)shareButtonTapped : (id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTopicIndex:(NSInteger)topicIndex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTopicDict:(NSMutableDictionary *)topicDictionary;
- (IBAction)addToFavsButtonTapped:(id)sender;
- (void)postFacebookFeedOnPage;
- (void)postFacebookFeed;
- (IBAction)writeFeedbackButtonTapped:(id)sender;
- (void) animateScrollIndicators ;
- (void)fbGraphCallback:(id)sender;

@end

@protocol ACEventDetailViewControllerDelegate

@optional
-(void) viewEventDescriptionButtonTapped : (id)sender inView:(ACEventDetailViewController *)descriptionController;

@end