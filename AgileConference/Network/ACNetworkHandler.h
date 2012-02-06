//
//  ACNetworkHandler.h
//  AgileConference
//
//  Created by Deepak Shukla on 28/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@protocol ACNetworkHandlerDelegate;
@interface ACNetworkHandler : NSObject{
    NSMutableData *d;
}

@property (strong , nonatomic)id<ACNetworkHandlerDelegate> downloadDelegate;

-(void)downloadHandler : (NSDictionary *)apiParamrters context:(NSString *)context delegate:(id<ACNetworkHandlerDelegate>)delegate; 
-(void)downloadRespone : (NSMutableURLRequest *)request;

@end


@protocol ACNetworkHandlerDelegate

-(void)networkHandler :(ACNetworkHandler*)networkHandler  downloadDidComplete: (id)serverResponse ;

@end