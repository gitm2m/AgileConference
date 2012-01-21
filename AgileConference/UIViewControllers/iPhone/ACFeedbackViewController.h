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
#import "ViewUtility.h"
#import <CoreLocation/CoreLocation.h>
#import "ACCustomRootViewController.h"

@interface ACFeedbackViewController : ACCustomRootViewController<ACRateViewDelegate,ACNetworkHandlerDelegate,CLLocationManagerDelegate>{
    
    IBOutlet UILabel *feedbackheaderLabel;
    IBOutlet UILabel *ratingLabel;
    IBOutlet UILabel *feedbacklabel;
    IBOutlet UILabel *subjectLabel;
    IBOutlet UILabel *userNameLabel;
    CLLocationManager *locationManager;
    NSString *ratingString;
    NSString *lat;
    NSString *longt;
}

@property (strong, nonatomic) IBOutlet UILabel *textViewPlaceHolderView;
@property (strong, nonatomic) IBOutlet UITextField *feedbackSubTextField;
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) IBOutlet UITableViewCell *feedbackBgTableCell;
@property (strong, nonatomic) IBOutlet ACRateView *rateView;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property BOOL isOverallEventFeedback;
@property (strong, nonatomic) NSDictionary *eventDetailDict;

- (IBAction)cacelButtonTapped:(id)sender;
- (IBAction)sendButtonTapped:(id)sender;
@end
