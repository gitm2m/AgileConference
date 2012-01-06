//
//  ACEventDescriptionWebviewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/4/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACEventDescriptionWebviewControllerDelegate;

@interface ACEventDescriptionWebviewController : UIViewController{
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (strong, nonatomic) IBOutlet UIWebView *eventDescriptionWebview;
@property (strong, nonatomic) id<ACEventDescriptionWebviewControllerDelegate>delegate;

-(void)backButtonTapped : (id)sender;
- (IBAction)doneBarButtonPressed:(id)sender;

@end

@protocol ACEventDescriptionWebviewControllerDelegate

@optional
-(void)eventDescriptionViewBackButtonTapped ;

@end