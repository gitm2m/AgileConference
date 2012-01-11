//
//  ACAboutViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSplashView.h"

@interface ACAboutViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) IBOutlet UIWebView *aboutWebView;
@property (strong, nonatomic) IBOutlet UITableViewCell *videoTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *detailsTableViewCell;
@property (strong, nonatomic) ACSplashView *splashView;

- (IBAction)doneBarButtonPressed:(id)sender;
- (void)backButtonTapped;
@end
