//
//  ACEventDetailViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 01/01/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACEventDescriptionWebviewController.h"

@protocol ACEventDetailViewControllerDelegate;

@interface ACEventDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *topicDescriptionLinkTextView;
@property (strong, nonatomic) id<ACEventDetailViewControllerDelegate>delegate;

- (IBAction)viewEventDescriptionButtonTapped:(id)sender;
@end

@protocol ACEventDetailViewControllerDelegate

@optional
-(void) viewEventDescriptionButtonTapped : (id)sender inView:(ACEventDetailViewController *)descriptionController;

@end