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
    
}

@property (strong, nonatomic) ACAppDelegate *appDelegate;

@end