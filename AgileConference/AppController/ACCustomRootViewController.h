//
//  ACCustomRootViewController.h
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACAppDelegate.h"
 
@interface ACCustomRootViewController : UIViewController{
    
    ACAppDelegate *appDelegate;
    UIButton *leftBarButton,*rightBarButton;
    UILabel *headerLabel;
    
}

@property (strong, nonatomic) ACAppDelegate *appDelegate;


-(void)setupInitialView;
-(void)organizerButtonTapped : (id)sender ;
-(void)leftBarButtonClicked : (id)sender ;
-(void)rightBarButtonClicked : (id)sender ;
@end


