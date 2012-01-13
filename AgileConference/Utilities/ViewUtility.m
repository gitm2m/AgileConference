//
//  ViewUtility.m
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "ViewUtility.h"


@implementation ViewUtility


//show the alertmessage

+(UIAlertView *)showAlertViewWithMessage:(NSString *)message{
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAppName 
													   message:message 
													  delegate:nil 
											 cancelButtonTitle:@"OK" otherButtonTitles:nil];	
	[alertView show];
    return alertView;
	
}


// show the alertmessage with the tag

+(UIAlertView *)showAlertViewWithMessage:(NSString *)message andButtons:(NSString *)btnTitles{
    NSArray *btnTitlesArray=[btnTitles componentsSeparatedByString:@","];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAppName 
                                                        message:message 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:[NSString stringWithFormat:@"%@",btnTitles],nil];	
	[alertView show];
    return alertView;

}

-(id)createViewOfType:(viewType)typeOfView 
              ofClass:(id)typeOfClass
            WithFrame:(CGRect)frame 
          withBGColor:(UIColor *)bgColor 
           withBGView:(UIImageView *)bgView{
    
    id view =[[typeOfClass alloc] init];
    [view setFrame:frame];
    [view setBackgroundColor:bgColor];
    switch (typeOfView) {
        case viewType_UIView:{
            //
        }
            break;
            
        default:{
            return view;
        }
            break;
    }
    return view;

}

-(id)createViewControllerOfType:(viewType)typeOfView 
                        ofClass:(id)typeOfClass
                       WithView:(id)view childView:(id)childView{
    
    id controller =[[typeOfClass alloc] initWithNibName:nil bundle:nil];
    [controller setView:view];
    UIViewController *viewController=(UIViewController *)controller;
    [viewController.view addSubview:childView];
    return controller;
}



@end
