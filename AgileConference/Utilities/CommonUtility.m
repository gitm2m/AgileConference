//
//  CommonUtility.m
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "CommonUtility.h"

@implementation CommonUtility


#pragma mark - Image Utility
+ (UIImage *) getImageWithConentsOfURL:(NSString *)urlString{
    
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image=nil;
	if(data)
	{
		image = [[UIImage alloc] initWithData:data];		
	}
	return image;
}
//
+ (UIImage *) getImageWithConentsOfFile:(NSString *)filePath{
    
	NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image=nil;
	if(data)
	{
		image = [[UIImage alloc] initWithData:data];		
	}
	return image;
}


//
+(void)saveImage:(UIImage *)image atPath:(NSString *)relativePath andFormat:(NSString *)formatType{
	
    NSString *absolutePath=[self getFilePath:relativePath fileType:formatType isDocumentDirecory:YES];
   NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
   [imageData writeToFile:absolutePath atomically:YES];
}



#pragma  mark - Date Utility
+(NSDate*)convertStringToDate:(NSString*)inString format:(NSString *)format
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
	[dateFormatter setDateFormat:format];
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




#pragma  mark - Network Utility
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

#pragma  mark - General Utility

+ (NSString *)GetUUID{
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef theUUIDStringRef = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString * theUUIDString= (__bridge NSString*)theUUIDStringRef;
    theUUIDString=[theUUIDString lowercaseString];
    CFRelease(theUUIDStringRef); //Added after analyze 
    return theUUIDString;
}

+(NSFileManager *)getFileManager{
    
    return [NSFileManager defaultManager];
}



#pragma  mark - plist Utility
+(id)convertToPlistFromXMLString:(NSString *)xmlString{
    
    return [xmlString propertyList];
}
//
+(NSDictionary *)convertToDictionaryFromXMLString:(NSString *)xmlString{  
    
    return [xmlString propertyListFromStringsFileFormat];
}

+(NSString *)convertToXMLFromPlist:(id)plistObject{ //here object may be plist,array, dictionary
    
    NSError  *error=nil;
    NSData *data=  [NSPropertyListSerialization 
                    dataWithPropertyList:plistObject 
                    format:kCFPropertyListXMLFormat_v1_0 
                    options:kCFPropertyListXMLFormat_v1_0 error:&error];    
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]; 
    //Altered after analyze , added autorelease
    
}

//Document directory && bundle
#pragma  mark - Document directory && bundle


+(NSString *)getDocumentDirectoryPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

}
+(NSString*)getBundlePath{
    
   return [[NSBundle mainBundle] bundlePath];
        
}
+(NSDictionary *)getDictionaryOfPlistAtPath:(NSString *)relativePath fileType:(NSString *)fileType isDocumentDirecory:(BOOL)isDD{
    
    NSString *rootPath=[self getBundlePath];
    if(isDD){
        rootPath=[self getDocumentDirectoryPath];
    }
    
    NSString *absolutePath=[rootPath stringByAppendingPathComponent:relativePath];
    absolutePath=[absolutePath stringByAppendingFormat:@".%@",fileType];
    return [NSDictionary dictionaryWithContentsOfFile:absolutePath];
}

///
+(NSString *)getFilePath:(NSString *)relativePath fileType:(NSString *)fileType isDocumentDirecory:(BOOL)isDD{
    
    NSString *rootPath=[self getBundlePath];
    if(isDD){
        rootPath=[self getDocumentDirectoryPath];
    }
    
    NSString *absolutePath=[rootPath stringByAppendingPathComponent:relativePath];
    return [absolutePath stringByAppendingFormat:@".%@",fileType];
    
}
//
+(BOOL)isFileExistAtPath:(NSString*)file{
	
	return [[self getFileManager] fileExistsAtPath:file]; 	
}



+(void)createFileAtPath:(NSString *)relativePath{
    
    NSError *error;
    NSString *rootPath=[self getDocumentDirectoryPath];
    NSArray  *pathComponents=[relativePath componentsSeparatedByString:@"/"];
    NSString *lastComponent=[pathComponents lastObject];
    if([lastComponent rangeOfString:@"."].length>0){
        NSString *tempRelativePath=[relativePath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/%@",lastComponent]
                                                                           withString:@""];
        NSString *absolutePath=[rootPath stringByAppendingPathComponent:tempRelativePath];
        if([[self getFileManager] createDirectoryAtPath:absolutePath 
                            withIntermediateDirectories:YES 
                                             attributes:nil 
                                                  error:&error]){
            
            NSLog(@"directory created....file");
            
        }else{
            
            NSLog(@"Creation of Project  directory failed because:\n %@",error);
        }
        
        [[self getFileManager] createFileAtPath:[rootPath stringByAppendingPathComponent:relativePath] contents:nil attributes:nil];

        
    }else{
        NSString *absolutePath=[rootPath stringByAppendingPathComponent:relativePath];
        if([[self getFileManager] createDirectoryAtPath:absolutePath 
                            withIntermediateDirectories:YES 
                                             attributes:nil 
                                                  error:&error]){
            
            NSLog(@"directory created....");
            
        }else{
            
            NSLog(@"Creation of Project  directory failed because:\n %@",error);
        }
        
}
    
	
}


+(void)schedulNotification:(NSString *)date andTime:(NSString *)time andFormat:(NSString *)format{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",date, time];
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
        
        UILocalNotification *notif = [[cls alloc] init];
        //notif.timeZone = [NSTimeZone localTimeZone];
        notif.fireDate = [CommonUtility convertStringToDate:stringDate format:format];
        //NSLog(@"Date Current:%@",notif.fireDate);
        
        notif.alertBody = @"Did you forget something?";
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"Hey! You implemented the local notification"
                                                             forKey:kRemindMeNotificationDataKey];
        notif.userInfo = userDict;
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
    
}








@end