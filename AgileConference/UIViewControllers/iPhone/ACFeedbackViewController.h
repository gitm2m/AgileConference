//
//  ACFeedbackViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/11/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACRateView.h"
#import "ACNetworkHandler.h"

@interface ACFeedbackViewController : UIViewController<ACRateViewDelegate,ACNetworkHandlerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *textViewPlaceHolderView;
@property (strong, nonatomic) IBOutlet UITextField *feedbackSubTextField;
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) IBOutlet UITableViewCell *feedbackBgTableCell;
@property (strong, nonatomic) IBOutlet ACRateView *rateView;
@property (strong, nonatomic) IBOutlet UITextField *userName;


- (IBAction)cacelButtonTapped:(id)sender;
- (IBAction)sendButtonTapped:(id)sender;
@end
