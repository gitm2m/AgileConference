//
//  ACAppDelegate.m
//  AgileConference
//
//  Created by Valtech India on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACAppController.h"
#import "CommonUtility.h"
#import "TestUtility.h"
#import "ACOrganiser.h"
#import "ACFacebookConnect.h"
#import "ViewUtility.h"
#import "ACFeedbackViewController.h"



@implementation ACAppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navigationController = _navigationController;
@synthesize eventStore;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Load catalog dict
    
//    for (int i=0; i<10; i++) {
//        
//        ACAlertView *alertView = [[ACAlertView alloc] initWithTitle:KAppName
//                                                            message:@"Message" delegate:self 
//                                                  cancelButtonTitle:@"NO" 
//                                                  otherButtonTitles:@"YES",nil];
//        [alertView setNotificationType:@""];
//        [alertView setNoteTopicDict:nil];
//        [alertView setDelegate:self];
//        [alertView show];    
//
//    }
//    [self clearAlertViews];
    
    eventStore = [[EKEventStore alloc] init];
    
    [[ACOrganiser getOrganiser] getCatalogDict];
    
    if (![CommonUtility isConnectedToNetwork]) {
        //[ViewUtility showAlertViewWithMessage:@"Network connection attempt failed,Please check your internet connection."];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ACAppController alloc] initWithNibName:@"ACAppController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ACAppController alloc] initWithNibName:@"ACAppController_iPad" bundle:nil];
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [[self.navigationController navigationBar] setTintColor:[UIColor grayColor]];
    [[self.navigationController navigationBar] setAlpha:0.0];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    ////***********************************************************************************************************?
    
	Class cls = NSClassFromString(@"UILocalNotification");
	if (cls) {
		UILocalNotification *notification = [launchOptions objectForKey:
                                             UIApplicationLaunchOptionsLocalNotificationKey];
		
		if (notification) {
			[self showReminder:notification.userInfo];
		}
	}
	
	application.applicationIconBadgeNumber = 0;
   // [[[TestUtility alloc] init] test];
    
    [Appirater appLaunched];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[ACOrganiser getOrganiser] saveCatalogDict];

    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	
    [Appirater appEnteredForeground:YES];
    
    if (![CommonUtility isConnectedToNetwork]) {
        [ViewUtility showAlertViewWithMessage:@"Network connection attempt failed,Please check your internet connection."];
    }
    
	application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application 
didReceiveLocalNotification:(UILocalNotification *)notification {
	
	// UIApplicationState state = [application applicationState];
	// if (state == UIApplicationStateInactive) {
    
    // Application was in the background when notification
    // was delivered.
	// }
	////NSLog(@"jhjhj=========================");
	
	application.applicationIconBadgeNumber = 0;
	[self showReminder:notification.userInfo];
    
    

}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[ACOrganiser getOrganiser] saveCatalogDict];
    
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)showReminder:(NSDictionary *)notificationDict {
    
    NSMutableDictionary *notifiedEventDict=[[NSMutableDictionary alloc] initWithDictionary:[notificationDict objectForKey:@"kEventDict"]];
    NSString *notificationType=[notificationDict objectForKey:@"NOTIFICATION_TYPE"];

    if([notificationType isEqualToString:@"START"]){
        
        NSString *alertMssage=[NSString stringWithFormat:@"Few minutes is remaining to begin '%@', would you like to participate?",[notifiedEventDict objectForKey:kTopicTitle]];
        
        ACAlertView *alertView = [[ACAlertView alloc] initWithTitle:KAppName
                                                            message:alertMssage delegate:nil 
                                                  cancelButtonTitle:@"NO" 
                                                  otherButtonTitles:@"YES",nil];
        [alertView setNotificationType:@"START"];
        [alertView setNoteTopicDict:notifiedEventDict];
        [alertView setDelegate:self];
        [alertView show];    
    }
    //
    else if([notificationType isEqualToString:@"END"]){
        
        //NSLog(@"notifiedEventDict end ........");
        NSString *alertMssage=[NSString stringWithFormat:@"Would you like to write feedback on '%@'?",[notifiedEventDict objectForKey:kTopicTitle]];
        
        ACAlertView *alertView = [[ACAlertView alloc] initWithTitle:KAppName
                                                            message:alertMssage delegate:nil 
                                                  cancelButtonTitle:@"Later" 
                                                  otherButtonTitles:@"Write",nil];
        [alertView setNotificationType:@"END"];
        [alertView setNoteTopicDict:notifiedEventDict];
        [alertView setDelegate:self];
        [alertView show];    
    }
    //
    else if([notificationType isEqualToString:@"UPDATE"]){
        //NSLog(@"notifiedEventDict end ........");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_UPCOMING_EVENTS" object:nil];
    }
    //
    

}

- (void)alertView:(ACAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   // //NSLog(@"Button Inex:%i",buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            //NSLog(@"clicked at index 0");
            if([alertView.notificationType isEqualToString:@"START"]){
                
                [alertView.noteTopicDict setObject:@"YES" forKey:kTopicMissed];
                
            }else if([alertView.notificationType isEqualToString:@"END"]){
                
                [alertView.noteTopicDict setObject:@"Closed" forKey:kTopicStatus];
            }
            
            [[ACOrganiser getOrganiser]updateCatalogDictPostNotification:alertView.noteTopicDict];
            [alertView dismissWithClickedButtonIndex:0 animated:NO];


        }
            break;
            
        case 1:
        {
            if([alertView.notificationType isEqualToString:@"START"]){
                
                [alertView.noteTopicDict setObject:@"YES" forKey:kTopicParticipated];
                [CommonUtility schedulPostNotificationOfEvent:alertView.noteTopicDict];

                // make call to organiser andset event dict participated yes
            }else if([alertView.notificationType isEqualToString:@"END"]){
                
                ////NSLog(@"Notification end:%@",notificationType);
               // //NSLog(@"notifiedEventDict :%@",notifiedEventDict);

                
                // call feedback view
                [alertView.noteTopicDict setObject:@"Closed" forKey:kTopicStatus];
                // call notification view
                ACFeedbackViewController *feedbackViewController = [[ACFeedbackViewController alloc] initWithNibName:@"ACFeedbackViewController" bundle:nil];
                feedbackViewController.isOverallEventFeedback = NO;
                feedbackViewController.eventDetailDict = alertView.noteTopicDict;
                [self.navigationController presentModalViewController:feedbackViewController animated:YES];
                //
                //NSLog(@"notifiedEventDict :%@",@"end event finished");
                
            }
            [[ACOrganiser getOrganiser]updateCatalogDictPostNotification:alertView.noteTopicDict];
            [alertView dismissWithClickedButtonIndex:0 animated:NO];
            [self clearAlertViews];


        }
            break;

            
        default:
            break;
    }
}

-(void) clearAlertViews {
	
    //NSLog(@">>>>>>>>>>clear alerview start>>>>>>>>>>>");
	for (UIWindow* window1 in [UIApplication sharedApplication].windows) {
		
           // //NSLog(@">>>window is not kind of UIwindow>");
           // //NSLog(@">>>window is %@>",[window1 class]);
           // //NSLog(@">>>window is %@>",[window1 subviews]);

            for (UIView *sb in window1.subviews) {
                
               // //NSLog(@">>>subview  %@>",sb);

                if ([sb isKindOfClass:[ACAlertView class]]) {
                    
                    //NSLog(@">>>alertview is acalert view>");
                    ACAlertView *alertView = (ACAlertView *)sb;
                    [alertView setDelegate:self];
                    [alertView.noteTopicDict setObject:@"YES" forKey:kTopicMissed];
                    [[ACOrganiser getOrganiser]updateCatalogDictPostNotification:alertView.noteTopicDict];
                    [alertView dismissWithClickedButtonIndex:0 animated:NO];
                }
                
                
            }
        // END OF SECOND FOR LOOP..
            
		
	}
    // END OF MAIN FOR LOOP..
    
    //NSLog(@">>>>>>>>>>clear alerview end >>>>>>>>>>>");

	
}



@end
