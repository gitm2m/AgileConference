//
//  CommonUtility.m
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "CommonUtility.h"

@implementation CommonUtility

+ (UIImage *) getImage
{
	NSURL *url = [NSURL URLWithString:nil];
	NSData *data = [NSData dataWithContentsOfURL:url];
	if(data)
	{
		UIImage *img = [[UIImage alloc] initWithData:data];		
		return img;
	}
	return nil;
}




// Converting string to date


+(NSDate*)convertStringToDate:(NSString*)inString
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSDate* outDate = [dateFormatter dateFromString:inString];
	return outDate;
}



// convert date to string

+(NSString*) convertDateToString:(NSDate *)firstDate format:(NSString *)format
{
	NSDateFormatter *dateFrmt = [[NSDateFormatter alloc] init];
	[dateFrmt setDateStyle:kCFDateFormatterShortStyle];
	
	if( !dateFrmt )
		return nil;
	[dateFrmt setDateFormat:format];
	
	//Optionally for time zone converstions
	[dateFrmt setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
	NSString *date = [dateFrmt stringFromDate:firstDate];
	if( !date )
		return nil;
	
	return date;
}




// is app can detect the network??
+(BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags){
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}



+ (NSString *)GetUUID{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef theUUIDStringRef = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString * theUUIDString= (__bridge NSString*)theUUIDStringRef;
    theUUIDString=[theUUIDString lowercaseString];
    CFRelease(theUUIDStringRef); //Added after analyze 
    return theUUIDString;
}





+(id)convertToPlistFromXMLString:(NSString *)xmlString{
    
    return [xmlString propertyList];
}
/// we can use this method to make custom xml format, we can iterate dictinary and can make xml, no need of parsing
+(NSDictionary *)convertToDictionaryFromXMLString:(NSString *)xmlString{    
    return [xmlString propertyListFromStringsFileFormat];
}

+(NSString *)convertToXMLFromPlist:(id)plistObject{ //here object may be plist,array, dictionary
    
    NSError  *error=nil;
    NSData *data=  [NSPropertyListSerialization 
                    dataWithPropertyList:plistObject 
                    format:kCFPropertyListXMLFormat_v1_0 
                    options:kCFPropertyListXMLFormat_v1_0 error:&error];    
    // NSLog(@"Data>>>>>>>>>>>%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]; //Altered after analyze , added autorelease
    
}




@end