//
//  ACFacebookConnect.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/9/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACFacebookConnect.h"
#import "SBJSON.h"
#import "FbGraphFile.h"


static ACFacebookConnect *facebookConnectObject = nil;

@implementation ACFacebookConnect
@synthesize fbGraph;
@synthesize feedPostId,callbackObjct;

+(ACFacebookConnect *)getFacebookConnectObject{
    
    if(facebookConnectObject == nil){
		
		facebookConnectObject = [[ACFacebookConnect alloc]init];
		
	}
	return facebookConnectObject;
}

-(void)checkForSessionWithCallbackObject : (id)callbackObject andSelector:(SEL)selector{
    
    NSString *client_id = kFaceBookAPIKey;
    self.callbackObjct = callbackObject;
	
        //alloc and initalize our FbGraph instance
	self.fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
	
    
       
        //begin the authentication process.....
	[fbGraph authenticateUserWithCallbackObject:self.callbackObjct andSelector:selector 
						 andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
}

@end
