//
//  CommonUtility.h
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#include <CoreFoundation/CoreFoundation.h>



@interface CommonUtility : NSObject{
    
    
}

+(UIImage *) getImage;
+(BOOL)      connectedToNetwork;
+ (NSString *)GetUUID;
//
+(id)convertToPlistFromXMLString:(NSString *)xmlString;
+(NSDictionary *)convertToDictionaryFromXMLString:(NSString *)xmlString;
+(NSString *)convertToXMLFromPlist:(id)plistObject;


@end
