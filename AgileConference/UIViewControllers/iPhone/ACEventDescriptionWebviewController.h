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
    NSString *targetURLString;
}

@property (strong, nonatomic) IBOutlet UIWebView *eventDescriptionWebview;
@property (strong, nonatomic) id<ACEventDescriptionWebviewControllerDelegate>delegate;

-(void)backButtonTapped : (id)sender;
-(IBAction)doneBarButtonPressed:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil andURL:(NSString*)urlString;

@end

@protocol ACEventDescriptionWebviewControllerDelegate

@optional
-(void)eventDescriptionViewBackButtonTapped ;

@end