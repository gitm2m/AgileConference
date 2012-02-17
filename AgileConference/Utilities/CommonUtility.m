//
//  CommonUtility.m
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "CommonUtility.h"

NSInteger alphabeticSort(id string1, id string2, void *reverse)
{
    if (*(BOOL *)reverse == YES) {
        return [string2 localizedCaseInsensitiveCompare:string1];
    }
    return [string1 localizedCaseInsensitiveCompare:string2];
}


@implementation CommonUtility

#pragma mark - Font
+(UIFont *)fontSegoiBold : (CGFloat)size{
	return [UIFont fontWithName:@"SegoeUI-Bold" size:size];
}


+(UIFont *)fontSegoi : (CGFloat)size{
	return [UIFont fontWithName:@"SegoeUI" size:size];
}

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
	[dateFrmt setTimeZone:[NSTimeZone localTimeZone]];
	NSString *date = [dateFrmt stringFromDate:firstDate];
	if( !date )
		return nil;
	
	return date;
}




#pragma  mark - Network Utility
+(BOOL) isConnectedToNetwork
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
    
   // NSLog(@">>>>>>>>>>>>>>local notification:%@",[[UIApplication sharedApplication]scheduledLocalNotifications]);
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",date, time];
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
        
        UILocalNotification *notif = [[cls alloc] init];
        notif.fireDate = [CommonUtility convertStringToDate:stringDate format:format];
        notif.timeZone = [NSTimeZone localTimeZone];
        NSLog(@"fire date:%@",notif.fireDate);
        notif.alertBody = @"Agile 2012";
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObject:stringDate
                                                             forKey:kRemindMeNotificationDataKey];
        notif.userInfo = userDict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        notif=nil;
    }
   // NSLog(@">>>>>>>>>>>>>>local notification:%@",[[UIApplication sharedApplication]scheduledLocalNotifications]);
}

+(void)schedulNotificationOnDate:(NSString *)date 
                         andTime:(NSString *)time 
                       andFormat:(NSString *)format 
            withNotificationDict:(NSMutableDictionary*)notificationDict{
    
    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",date, time];
   // NSLog(@"String dict %@",stringDate);
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
        
        UILocalNotification *notif = [[cls alloc] init];
        notif.fireDate = [CommonUtility convertStringToDate:stringDate format:format];
        notif.timeZone = [NSTimeZone localTimeZone];
        NSLog(@"fire date with dict>>>>>>>:%@",notif.fireDate);
        notif.alertBody = @"Agile 2012";
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.userInfo = notificationDict;
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
    
}
//



+(NSDate *)ripStartDate : (NSMutableDictionary*)dict{
    
    NSString *topicDay=[dict objectForKey:kTopicDate];
    
    NSString *topicTime=[dict objectForKey:kTopicTime];//
                                                             
    NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
    NSString *topicTimeFirstObject=[topicTimeArray objectAtIndex:0];
    NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@"-"] objectAtIndex:0];
        //
        
    NSInteger startprefix=0;
    NSArray *startTimeArray=[startTime componentsSeparatedByString:@":"];
       
    if([[startTimeArray objectAtIndex:0] intValue]>=1
       && [[startTimeArray objectAtIndex:0] intValue]<=8){
        
        startprefix=12+[[startTimeArray objectAtIndex:0] intValue];
        NSString *timeSuffix=[startTimeArray objectAtIndex:1];
        startTime=[NSString stringWithFormat:@"%i:%@",startprefix, timeSuffix];
           
    }
    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",topicDay, startTime];
    NSDate *eventStartDate=[CommonUtility convertStringToDate:stringDate format:@"dd-MM-yyyy, HH:mm"]; 
    
    return eventStartDate;

    
}

+(NSDate *)ripEndDate :  (NSMutableDictionary*)dict{
    
    NSString *topicDay=[dict objectForKey:kTopicDate];
    
    NSString *topicTime=[dict objectForKey:kTopicTime];//
    
    NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
    ACLog(@"topicTimeArray %@", topicTimeArray);
    NSString *topicTimeFirstObject=[topicTimeArray lastObject];
    NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@"-"] objectAtIndex:1];
        //
    
    NSInteger startprefix=0;
    NSArray *startTimeArray=[startTime componentsSeparatedByString:@":"];
    
    if([[startTimeArray objectAtIndex:0] intValue]>=1
       && [[startTimeArray objectAtIndex:0] intValue]<=8){
        
        startprefix=12+[[startTimeArray objectAtIndex:0] intValue];
        NSString *timeSuffix=[startTimeArray objectAtIndex:1];
        startTime=[NSString stringWithFormat:@"%i:%@",startprefix, timeSuffix];
        
    }
    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",topicDay, startTime];
    NSDate *eventEndDate=[CommonUtility convertStringToDate:stringDate format:@"dd-MM-yyyy, HH:mm"]; 
    
    return eventEndDate;

    
}

+(NSDate *)ripEndDateCalendarView :  (NSMutableDictionary*)dict{
    
    NSString *topicDay=[dict objectForKey:kTopicDate];
    
    NSString *topicTime=[dict objectForKey:kTopicTime];//
    
    NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
    ACLog(@"topicTimeArray %@", topicTimeArray);
    NSString *topicTimeFirstObject=[topicTimeArray lastObject];
    NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@"-"] objectAtIndex:0];
        //
    
    NSInteger startprefix=0;
    NSArray *startTimeArray=[startTime componentsSeparatedByString:@":"];
    
    if([[startTimeArray objectAtIndex:0] intValue]>=1
       && [[startTimeArray objectAtIndex:0] intValue]<=8){
        
        startprefix=12+[[startTimeArray objectAtIndex:0] intValue];
        NSString *timeSuffix=[startTimeArray objectAtIndex:1];
        startTime=[NSString stringWithFormat:@"%i:%@",startprefix, timeSuffix];
        
    }
    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",topicDay, startTime];
    NSDate *eventEndDate=[CommonUtility convertStringToDate:stringDate format:@"dd-MM-yyyy, HH:mm"]; 
    
    return eventEndDate;
    
    
}


+(void)schedulPreNotificationOfEvent:(NSMutableDictionary*)favDict{
    
    NSString *topicDay=[favDict objectForKey:kTopicDate];
    //
    NSString *topicTime=[favDict objectForKey:kTopicTime];//
    //NSLog(@"topicTime %@",topicTime);

    NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
    NSString *topicTimeFirstObject=[topicTimeArray objectAtIndex:0];
    NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@"-"] objectAtIndex:0];
    //
    NSMutableDictionary *userDict=[[NSMutableDictionary alloc] init];
    [userDict setObject:favDict forKey:@"kEventDict"];
    [userDict setObject:@"START" forKey:@"NOTIFICATION_TYPE"];
    NSDate *currDate=[NSDate date];
   // NSLog(@">>>>>>start time:%@", startTime);
    NSInteger startprefix=0;
    NSArray *startTimeArray=[startTime componentsSeparatedByString:@":"];
    //NSLog(@"eventStartDate before:%@",eventStartDate);
    if([[startTimeArray objectAtIndex:0] intValue]>=1
       && [[startTimeArray objectAtIndex:0] intValue]<=8){
        startprefix=12+[[startTimeArray objectAtIndex:0] intValue];
        NSString *timeSuffix=[startTimeArray objectAtIndex:1];
        startTime=[NSString stringWithFormat:@"%i:%@",startprefix, timeSuffix];
        //NSLog(@">>>>>>start time...after:%@", startTime);
    }
    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",topicDay, startTime];
    NSDate *eventStartDate=[CommonUtility convertStringToDate:stringDate format:@"dd-MM-yyyy, HH:mm"]; 
   // NSLog(@">>>>>>startprefix as int:%i", startprefix);
    if([eventStartDate compare:currDate]==NSOrderedAscending){

        //NSLog(@"eventStartDate NSOrderedAscending:%@",eventStartDate);   
        //NSLog(@"currDate NSOrderedAscending:%@",currDate);
        return;

    }

    eventStartDate=[eventStartDate dateByAddingTimeInterval:-5*60];
    //NSLog(@"eventStartDate after:%@",eventStartDate);

    NSString *newSrartDateAsString=[CommonUtility convertDateToString:eventStartDate format:@"dd-MM-yyyy, HH:mm"];
    NSArray *newStartTimeArray=[newSrartDateAsString componentsSeparatedByString:@", "];
    //
    [self schedulNotificationOnDate:topicDay 
                            andTime:[newStartTimeArray objectAtIndex:1] 
                          andFormat:@"dd-MM-yyyy, HH:mm" 
               withNotificationDict:userDict];
    //
}
//
+(void)schedulPostNotificationOfEvent:(NSMutableDictionary*)favDict{
    
   // NSLog(@"Post no>>>>>>>");
    NSString *topicDay=[favDict objectForKey:kTopicDate];
    //
    NSString *topicTime=[favDict objectForKey:kTopicTime];//
   // NSLog(@"topicTime %@",topicTime);
    NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
    //
    NSMutableDictionary *userDict=[[NSMutableDictionary alloc] init];
    [userDict setObject:favDict forKey:@"kEventDict"];
    NSString *topicTimeLastObject=[topicTimeArray lastObject];
    NSString  *endTime=[[topicTimeLastObject componentsSeparatedByString:@"-"] objectAtIndex:1];
    //NSLog(@"end time %@",endTime);
    [userDict setObject:@"END" forKey:@"NOTIFICATION_TYPE"];
    
    // NSLog(@">>>>>>start time:%@", startTime);
    NSInteger startprefix=0;
    NSArray *endTimeArray=[endTime componentsSeparatedByString:@":"];
    //NSLog(@"eventStartDate before:%@",eventStartDate);
    if([[endTimeArray objectAtIndex:0] intValue]>=1
       && [[endTimeArray objectAtIndex:0] intValue]<=8){
        startprefix=12+[[endTimeArray objectAtIndex:0] intValue];
        NSString *timeSuffix=[endTimeArray objectAtIndex:1];
        endTime=[NSString stringWithFormat:@"%i:%@",startprefix, timeSuffix];
        //NSLog(@">>>>>>start time...after:%@", endTime);
    }

    
    
    [self schedulNotificationOnDate:topicDay 
                            andTime:endTime 
                          andFormat:@"dd-MM-yyyy, HH:mm" 
               withNotificationDict:userDict];

}
//
+(void)schedulUpdateNotificationOfEvent:(NSMutableDictionary*)favDict{
    
    NSString *topicDate=[favDict objectForKey:kTopicDate];
    //
    NSString *topicTime=[favDict objectForKey:kTopicTime];//
   //NSLog(@"topicTime>>>>>>>>>>>>>>>>>> %@",topicTime);
    NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
    //
    NSMutableDictionary *userDict=[[NSMutableDictionary alloc] init];
    [userDict setObject:favDict forKey:@"kEventDict"];
    NSString *topicTimeLastObject=[topicTimeArray lastObject];
    NSString  *endTime=[[topicTimeLastObject componentsSeparatedByString:@"-"] objectAtIndex:1];
    //NSLog(@"end time before %@",endTime);
    NSArray *endTimeArray=[endTime componentsSeparatedByString:@":"];
    if([[endTimeArray objectAtIndex:0] intValue]>=1
       &&[[endTimeArray objectAtIndex:0] intValue]<7){
        endTime=[NSString stringWithFormat:@"%i:%@",[[endTimeArray objectAtIndex:0] intValue]+12,[endTimeArray objectAtIndex:1]];
    }
    //NSLog(@"end time after %@",endTime);

    NSString *stringDate=[NSString stringWithFormat:@"%@, %@",topicDate, endTime];
    NSDate *eventStartDate=[CommonUtility convertStringToDate:stringDate format:@"dd-MM-yyyy, HH:mm"]; 
    if([eventStartDate compare:[NSDate date]]!=NSOrderedDescending){
        
        return;
        
    }


    [userDict setObject:@"UPDATE" forKey:@"NOTIFICATION_TYPE"];
    //
    [self schedulNotificationOnDate:topicDate 
                            andTime:endTime 
                          andFormat:@"dd-MM-yyyy, HH:mm" 
               withNotificationDict:userDict];
    
}

//
+(void)cancelNotificationOfEvent:(NSMutableDictionary *)eventDict{
    
    NSArray *eventNotificationArray=[[UIApplication sharedApplication]scheduledLocalNotifications];
    //
    if([eventNotificationArray count]>0){
        //NSMutableArray *targetNotificationArray=[[NSMutableArray alloc] init];
        
        for (UILocalNotification *eventNotification in eventNotificationArray) {
        
            NSDictionary *notificationEventDict=[eventNotification.userInfo objectForKey:@"kEventDict"];
            
            NSString *noteDay=[notificationEventDict objectForKey:kTopicDate];
            NSString *currDay=[eventDict objectForKey:kTopicDate];

            NSString *noteTrack=[notificationEventDict objectForKey:kTopicTrack];
            NSString *currTrack=[eventDict objectForKey:kTopicTrack];

            NSString *noteTitle=[notificationEventDict objectForKey:kTopicTitle];
            NSString *currTitle=[eventDict objectForKey:kTopicTitle];


        if([noteDay isEqualToString:currDay] && [noteTrack isEqualToString:currTrack] && 
           [noteTitle isEqualToString:currTitle]){
            
            [[UIApplication sharedApplication] cancelLocalNotification:eventNotification];
            //[targetNotificationArray addObject:eventNotification];
            //if([targetNotificationArray count]==2){
                //break;
            //}
        }
    }
        /*
        if([targetNotificationArray count]>0){
        
        for (UILocalNotification *eventNotification in targetNotificationArray){
            [[UIApplication sharedApplication] cancelLocalNotification:eventNotification];

        }
    }
         */
    }
}
+(void)cancelUpdateNotificationOfEvent:(NSMutableDictionary *)eventDict{
    
    NSArray *eventNotificationArray=[[UIApplication sharedApplication]scheduledLocalNotifications];
    //
    if([eventNotificationArray count]>0){
        
        for (UILocalNotification *eventNotification in eventNotificationArray) {
            
            NSString *notificationType=[eventNotification.userInfo objectForKey:@"NOTIFICATION_TYPE"];
            //
            if([notificationType isEqualToString:@"UPDATE"]){
                [[UIApplication sharedApplication] cancelLocalNotification:eventNotification];
                break;
            }
        }
    }
}


+(NSString *)convertDateToAMPMFormat:(NSString *)topicTime{
    
    NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
    NSString *topicTimeFirstObject=[topicTimeArray objectAtIndex:0];
    NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@"-"] objectAtIndex:0];
    //
    if([[[startTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]>=8
       && [[[startTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]<12){
        startTime=[NSString stringWithFormat:@"%@ AM",startTime];
    }else{
        startTime=[NSString stringWithFormat:@"%@ PM",startTime];
    }
    //
    NSString *topicTimeLastObject=[topicTimeArray lastObject];
    NSString  *endTime=[[topicTimeLastObject componentsSeparatedByString:@"-"] objectAtIndex:1];
    if([[[endTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]>=8
       && [[[endTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]<12){
        endTime=[NSString stringWithFormat:@"%@ AM",endTime];
    }else{
        endTime=[NSString stringWithFormat:@"%@ PM",endTime];
    }
    return [NSString stringWithFormat:@"%@-%@",startTime,endTime];
}

+(NSArray *)getSortedArrayByAlphabet:(NSArray *)inputArray{
    NSArray *anArray =inputArray;
    // note: anArray is sorted
    NSData *sortedArrayHint = [anArray sortedArrayHint];
    
    NSArray *sortedArray;
    
    // sort using a selector
    sortedArray =
    [anArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    // sort using a function
    BOOL reverseSort = NO;
    // sortedArray =
    //[anArray sortedArrayUsingFunction:alphabeticSort context:&reverseSort];
    
    // sort with a hint
    sortedArray =
    [anArray sortedArrayUsingFunction:alphabeticSort
                              context:&reverseSort
                                 hint:sortedArrayHint];
    
    return sortedArray;
    
}

////

+ (float) getHeightFromText:(NSString*)aText font:(UIFont*)font maxWidth:(float)aWidth
{
	CGSize maximumLabelSize = CGSizeMake(aWidth, MAXFLOAT);
	CGSize expecteSize = [aText sizeWithFont:font
                           constrainedToSize:maximumLabelSize 
                               lineBreakMode:UILineBreakModeWordWrap];
	
	return expecteSize.height;
}




@end