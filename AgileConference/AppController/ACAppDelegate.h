//
//  ACAppDelegate.h
//  AgileConference
//
//  Created by Valtech India on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "Appirater.h"
#import "ACAlertView.h"



@class ACAppController;

@interface ACAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>{
    
    EKEventStore *eventStore;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ACAppController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) EKEventStore *eventStore ;

-(void) showReminder:(NSDictionary *)eventDict;
-(void) clearAlertViews;

@end
