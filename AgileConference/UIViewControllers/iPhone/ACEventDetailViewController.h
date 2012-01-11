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

@protocol ACEventDetailViewControllerDelegate;

@interface ACEventDetailViewController : UIViewController<UIActionSheetDelegate>{
    
    IBOutlet UITextView *SpeakerSummaryView;
    IBOutlet UITextView *topicSummaryView;
    NSMutableDictionary *topicDict;
}

@property (strong, nonatomic) IBOutlet UITextView *topicDescriptionLinkTextView;
@property (strong, nonatomic) id<ACEventDetailViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet UIButton *addRemoveFavsButton;

- (IBAction)viewMoreButtonTapped:(id)sender;
- (void)shareButtonTapped : (id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTopicIndex:(NSInteger)topicIndex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTopicDict:(NSMutableDictionary *)topicDictionary;
- (IBAction)addToFavsButtonTapped:(id)sender;

@end

@protocol ACEventDetailViewControllerDelegate

@optional
-(void) viewEventDescriptionButtonTapped : (id)sender inView:(ACEventDetailViewController *)descriptionController;

@end