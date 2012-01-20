//
//  ACAboutViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSplashView.h"
#import "ACCustomRootViewController.h"

@interface ACAboutViewController : ACCustomRootViewController{
    
    IBOutlet UILabel *valtechLabel;
    
    IBOutlet UITextView *aboutTextView;
    IBOutlet UILabel *videoLabel;
}


@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) IBOutlet UIWebView *aboutWebView;
@property (strong, nonatomic) IBOutlet UITableViewCell *videoTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *detailsTableViewCell;
@property (strong, nonatomic) ACSplashView *splashView;

- (IBAction)doneBarButtonPressed:(id)sender;
- (IBAction)viewMoreButtonTapped:(id)sender;
- (void)backButtonTapped;
@end
