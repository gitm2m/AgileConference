//
//  ACFacebookConnect.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/9/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FbGraph.h"
#import "ACAppConstants.h"

@interface ACFacebookConnect : NSObject{
    FbGraph *fbGraph;
    NSString *feedPostId;
}

@property (nonatomic, retain) FbGraph *fbGraph;
@property (nonatomic, retain) NSString *feedPostId;

+(ACFacebookConnect *)getFacebookConnectObject;
-(void)checkForSessionWithCallbackObject : (id)callbackObject andSelector:(SEL)selector;
@end
