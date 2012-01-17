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


@implementation ACAppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Load catalog dict
    [[ACOrganiser getOrganiser] getCatalogDict];

    
    if (![CommonUtility isConnectedToNetwork]) {
        [ViewUtility showAlertViewWithMessage:@"Network connection attempt failed,Please check your internet connection."];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ACAppController alloc] initWithNibName:@"ACAppController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ACAppController alloc] initWithNibName:@"ACAppController_iPad" bundle:nil];
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
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
    
    notifiedEventDict=[notificationDict objectForKey:@"kEventDict"];
    notificationType=[notificationDict objectForKey:@"NOTIFICATION_TYPE"];

    if([notificationType isEqualToString:@"START"]){
        
        NSString *alertMssage=[NSString stringWithFormat:@"5 minutes is remaining to begin '%@', would you like to participate?",[notifiedEventDict objectForKey:kTopicTitle]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAppName
                                                            message:alertMssage delegate:nil 
                                                  cancelButtonTitle:@"NO" 
                                                  otherButtonTitles:@"YES",nil];
        [alertView setDelegate:self];
        [alertView show];    

        
    }
    //
    else if([notificationType isEqualToString:@"END"]){
        
        NSString *alertMssage=[NSString stringWithFormat:@"Would you like to write feedback on '%@'?",[notifiedEventDict objectForKey:kTopicTitle]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAppName
                                                            message:alertMssage delegate:nil 
                                                  cancelButtonTitle:@"Later" 
                                                  otherButtonTitles:@"Write",nil];
        [alertView setDelegate:self];
        [alertView show];    
    }else{
        
        //[[ACOrganiser getOrganiser] get];
    }
    //
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"Button Inex:%i",buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            if([notificationType isEqualToString:@"START"]){
                
                // make call to organiser andset event dict skipped yes
            }else if([notificationType isEqualToString:@"END"]){
                
            }
        }
            break;
            
        case 1:
        {
            if([notificationType isEqualToString:@"START"]){
                
                // make call to organiser andset event dict participated yes
            }else if([notificationType isEqualToString:@"END"]){
                
                // call feedback view
                
            }

        }
            break;

            
        default:
            break;
    }
}


@end
