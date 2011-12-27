//
//  ACAppSetting.m
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "ACAppSetting.h"
static ACAppSetting *appSession = nil;

@implementation ACAppSetting




+(ACAppSetting *)getAppSession{
	
	if(appSession == nil){
		
		appSession = [[ACAppSetting alloc]init];
		[appSession setDefaultValues];
	}
	
	return appSession;
}

//////////////////////////////////////////////////////////////////

// Function Name	: setDeafaultValue
// Return Type		: void
// Parameters		: nil	
// Description		: this method will set default value to app memmry object

/////////////////////////////////////////////////////////////////////

-(void)setDefaultValues{	
	

}
//
-(void)resetToDefaultValues{
    
    if(appSession != nil){
       [appSession setDefaultValues];
    }
}



@end
