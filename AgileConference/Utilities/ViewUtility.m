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

+(void)showAlertViewWithMessage:(NSString *)message{
	
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" 
													   message:message 
													  delegate:self 
											 cancelButtonTitle:@"OK" otherButtonTitles:nil];	
	[alertView show];
	
}


// show the alertmessage with the tag

+(void)showAlertViewWithMessage:(NSString *)message withTag:(NSInteger)tag{
	
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:message 
													  delegate:self 
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];	
	[alertView setTag:tag];
	[alertView show];
	
}


@end
