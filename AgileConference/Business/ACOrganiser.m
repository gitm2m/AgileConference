//
//  ACOrganiser.m
//  AgileConference
//
//  Created by Deepak Shukla on 28/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "ACOrganiser.h"
#import "CommonUtility.h"
#import "ACAppConstants.h"
static ACOrganiser *appOrganiser = nil;


@implementation ACOrganiser

//
+(ACOrganiser *)getOrganiser{
	
	if(appOrganiser == nil){
		
		appOrganiser = [[ACOrganiser alloc]init];
        [appOrganiser getCatalogDict];
	}

	return appOrganiser;
}
//
-(NSMutableDictionary *)getCatalogDict{
    
    if(!catalogDict){
        
        NSString *filePath=[CommonUtility getFilePath:@"Catalog" 
                                             fileType:@"plist" 
                                   isDocumentDirecory:YES];
        
        if(![CommonUtility isFileExistAtPath:filePath]){
            
            NSString *bundleCatalogPath=[CommonUtility getFilePath:@"Catalog" 
                                                 fileType:@"plist" 
                                       isDocumentDirecory:NO];

            catalogDict=[[NSMutableDictionary alloc] initWithContentsOfFile:bundleCatalogPath];
            [catalogDict writeToFile:filePath atomically:YES];

        }
        catalogDict=[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return catalogDict;
}
//
-(BOOL)saveCatalogDict{
    
    if(catalogDict){
        
        NSString *filePath=[CommonUtility getFilePath:@"Catalog" 
                                             fileType:@"plist" 
                                   isDocumentDirecory:YES];
        
        return [catalogDict writeToFile:filePath atomically:YES];
    }
    
    return NO;

}
//
-(NSInteger)updateStatusOfEventOnTime:(NSString *)topicTime andDate:(NSString *)topicDate{
    
                NSInteger status=-1;
    
                    NSArray   *topicTimeArray=[topicTime componentsSeparatedByString:@"-"];
                    //
                    NSString  *topicTimeFirstObject=[topicTimeArray objectAtIndex:0];
                    NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@" "] objectAtIndex:0];
                    NSString  *eventStartDayTime=[NSString stringWithFormat:@"%@, %@",topicDate,startTime];
                   // NSLog(@"eventStartDayTime in string::::::%@",eventStartDayTime);
                    NSDate    *eventStartDate=[CommonUtility convertStringToDate:eventStartDayTime format:@"dd-MM-yyyy, HH:mm"];
                    //NSLog(@"eventStartDayTime in date::::::%@",eventStartDate);

    
                if([topicTimeFirstObject hasSuffix:@"PM"]){
                    
                    if([[[topicTimeFirstObject componentsSeparatedByString:@":"] objectAtIndex:0] intValue]>=1
                       && [[[topicTimeFirstObject componentsSeparatedByString:@":"] objectAtIndex:0] intValue]<=12){
                        eventStartDate=[eventStartDate dateByAddingTimeInterval:12*60*60];
                    }

                }
                    //
                    NSString  *topicTimeLastObject=[topicTimeArray lastObject];
                    NSString  *endTime=[[topicTimeLastObject componentsSeparatedByString:@" "] objectAtIndex:0];
                    NSString  *eventDayTime=[NSString stringWithFormat:@"%@, %@",topicDate,endTime];
                    NSDate    *eventEndDate=[CommonUtility convertStringToDate:eventDayTime format:@"dd-MM-yyyy, HH:mm"];
    
                if([topicTimeFirstObject hasSuffix:@"PM"]){
        
                    if([[[topicTimeFirstObject componentsSeparatedByString:@":"] objectAtIndex:0] intValue]>=1
                       && [[[topicTimeFirstObject componentsSeparatedByString:@":"] objectAtIndex:0] intValue]<=12){
                        eventEndDate=[eventEndDate dateByAddingTimeInterval:12*60*60];
                    }
                }

                    NSDate    *currDate    =[NSDate date];
                    //
                    
                  // NSLog(@"Sratdate:%@",eventStartDate);
                  // NSLog(@"currDate:%@",currDate);
                    //NSLog(@"eventEndDate:%@",eventEndDate);

                    
                    if([eventEndDate compare:currDate]==-1){
                        status=-1;

                    }else if([eventEndDate compare:currDate]==0){
                        status=-1;

                    }else if([eventEndDate compare:currDate]==1){
                        status=1;

                    }
                    
                    if(status==1){
                        
                        if([eventStartDate compare:currDate]==-1){
                            status=0;
                            
                        }else if([eventStartDate compare:currDate]==0){
                            status=0;
                            
                        }else if([eventStartDate compare:currDate]==1){
                            status=1;
                            
                        }

                        
                    }
                    
                return status;
}
//Search favorite participants
-(NSMutableDictionary *)getCatalogListOfType:(NSString *)catalogType andCatalogTypeContent:(NSString *)content{
    
    NSMutableDictionary *favDict=[[NSMutableDictionary alloc] init];
    NSArray *dayKeyArray=[catalogDict allKeys];
    
    for (NSString *dayKey in dayKeyArray) {
        
        NSMutableDictionary *trackDict=[catalogDict objectForKey:dayKey];
        NSArray *trackKeyArray=[trackDict allKeys];
        //
        NSMutableDictionary *favTrackdict=[[NSMutableDictionary alloc] init];
        [favDict setObject:favTrackdict forKey:dayKey];
        //

         for (NSMutableDictionary *trackKey in trackKeyArray) {
             //
             NSMutableArray* topicArrayInTrack=[trackDict objectForKey:trackKey];
             //
             NSMutableArray *favTopicInTrack=[[NSMutableArray alloc] init];
             [favTrackdict setObject:favTopicInTrack forKey:trackKey];
             //
             for (NSMutableDictionary *topicDict in topicArrayInTrack) {
                 
                 if([[topicDict objectForKey:catalogType] isEqualToString:content] && [[topicDict objectForKey:kTopicType] isEqualToString:@"BUSINESS"]){
                     //
                     NSMutableDictionary *favTopicDict= [[NSMutableDictionary alloc] initWithDictionary:topicDict];
                     [favTopicInTrack addObject:favTopicDict];
                     //
                 }
             }
             if([favTopicInTrack count]==0){
                 [favTrackdict removeObjectForKey:trackKey];
             }

    }
        if([favTrackdict count]==0){
            [favDict removeObjectForKey:dayKey];
        }
        
        
}
    
    //ACLog(@"%@ list:%@",catalogType,favDict);
    return favDict;
}
//
-(NSMutableDictionary *)searchCatalogListOfType:(NSString *)catalogType andCatalogTypeContent:(NSString *)content{
    
    //NSLog(@"Catalog Type:%@",catalogType);
   // NSLog(@"andCatalogTypeContent:%@",content);
    //
    NSMutableDictionary *favDict=[[NSMutableDictionary alloc] init];
    NSArray *dayKeyArray=[catalogDict allKeys];
    
    for (NSString *dayKey in dayKeyArray) {
        
        NSMutableDictionary *trackDict=[catalogDict objectForKey:dayKey];
        NSArray *trackKeyArray=[trackDict allKeys];
        //
        NSMutableDictionary *favTrackdict=[[NSMutableDictionary alloc] init];
        [favDict setObject:favTrackdict forKey:dayKey];
        //
        
        for (NSMutableDictionary *trackKey in trackKeyArray) {
            //
            NSMutableArray* topicArrayInTrack=[trackDict objectForKey:trackKey];
            //
            NSMutableArray *favTopicInTrack=[[NSMutableArray alloc] init];
            [favTrackdict setObject:favTopicInTrack forKey:trackKey];
            //
            for (NSMutableDictionary *topicDict in topicArrayInTrack) {
                
                //NSLog(@">>>catalog type>>%@",catalogType);
                //NSLog(@">>>event key value>>%@",[topicDict objectForKey:catalogType]);
                //NSLog(@">>>search content>>%@",content);
                //NSLog(@">>>search content>>%i",[[topicDict objectForKey:catalogType] rangeOfString:content].length);

                if([[[topicDict objectForKey:catalogType] uppercaseString] rangeOfString:[content uppercaseString]].length>0 && [[topicDict objectForKey:kTopicType] isEqualToString:@"BUSINESS"]){
                    //
                    NSMutableDictionary *favTopicDict= [[NSMutableDictionary alloc] initWithDictionary:topicDict];
                    [favTopicInTrack addObject:favTopicDict];
                    //
                }
            }
            if([favTopicInTrack count]==0){
                [favTrackdict removeObjectForKey:trackKey];
            }
            
        }
        if([favTrackdict count]==0){
            [favDict removeObjectForKey:dayKey];
        }
        
        
    }
    
    //ACLog(@"%@ search list:%@",catalogType,favDict);
    return favDict;
}

//search with day , track and topic key
-(NSMutableDictionary *)searchCatalogWithSearchKey:(NSString *)searchKey 
                             andSearchValue:(NSString *)searchValue{
    
    if([searchKey hasPrefix:@"Topic_"]){
        return [self searchCatalogListOfType:searchKey andCatalogTypeContent:searchValue];
    }
    else if([searchKey isEqualToString:@"Track"]){
        
        NSMutableDictionary *resultDict=[[NSMutableDictionary alloc] initWithDictionary:catalogDict];
        NSArray *keyArray=[resultDict allKeys];
        for (NSString *key in keyArray) {
            
            NSMutableDictionary *trackDictionary=[resultDict objectForKey:key];
            NSArray *keyArray=[trackDictionary allKeys];
            for (NSString *key in keyArray) {
                
                if(![key isEqualToString:searchValue]){
                    
                    [trackDictionary removeObjectForKey:key];
                }

            }

        }
        //ACLog(@"Search key:%@, SearchValue:%@ list:%@",searchKey,searchValue,resultDict);
        return resultDict;
    
    }
    else if([searchKey isEqualToString:@"Day"]){
        
        NSMutableDictionary *resultDict=[[NSMutableDictionary alloc] initWithDictionary:catalogDict];
        NSArray *keyArray=[resultDict allKeys];
        for (NSString *key in keyArray) {
            if(![key isEqualToString:searchValue]){
                [resultDict removeObjectForKey:key];
            }
        }
        //ACLog(@"Search key:%@, SearchValue:%@ list:%@",searchKey,searchValue,resultDict);
        return resultDict;
    }
    
    return nil;
}

-(NSMutableDictionary *)sortSearchDict:(NSMutableDictionary*)searchDict 
                                    withSortKey:(NSString *)sortkey{
    
    return nil;
}

//
-(void)updateCatalogDict:(NSMutableDictionary *)currentDict{
    
    NSString *dayKey=[currentDict objectForKey:kTopicDay];
   // NSLog(@"Day key:%@",dayKey);
    NSMutableDictionary *dayDict=[catalogDict objectForKey:dayKey];
    
    NSString *tracKey=[currentDict objectForKey:kTopicTrack];
   // NSLog(@"tracKey key:%@",tracKey);

    NSMutableArray *tracArray=[dayDict objectForKey:tracKey];
   // NSLog(@"Day key:%@",[dayDict objectForKey:kTopicTrack];);

    NSString *currentTopicTitle=[currentDict objectForKey:kTopicTitle];
    //
    NSInteger topicIndex=0;
    BOOL isDictFound=NO;
    
    for (NSMutableDictionary *topicDict in tracArray) {
        
        NSString *tempTopicTitle=[topicDict objectForKey:kTopicTitle];
        if([tempTopicTitle isEqualToString:currentTopicTitle]){
            //NSLog(@"current title topic matches");
            //NSLog(@"title to be updated:%@",currentTopicTitle);
            //NSLog(@"current title:%@",currentTopicTitle);

            isDictFound=YES;
            break;
        }
        topicIndex++;
    }
    
    if(isDictFound){
        [tracArray replaceObjectAtIndex:topicIndex withObject:currentDict];
        [self saveCatalogDict];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_ORGANISER" object:nil];
    }
}
//
-(NSMutableArray *)getArrayOfDict:(NSMutableDictionary *)dict{
    NSMutableArray *eventArray=[[NSMutableArray alloc] init];
    NSArray *dayKeys=[dict allKeys];
    
    for (NSString *dayKey in dayKeys) {
        NSMutableDictionary *trackDict=[dict objectForKey:dayKey];
        NSArray *trackKeys=[trackDict allKeys];
        
        for (NSString *trackKey in trackKeys) {
            NSMutableArray *trackArray=[trackDict objectForKey:trackKey];
            for (NSMutableDictionary *eventDict in trackArray) {
                [eventArray addObject:eventDict];
            }
        }

    }
    return eventArray;
}
//
-(void)updateCatalogDictPostNotification:(NSMutableDictionary *)currentDict{
    
    NSString *dayKey=[currentDict objectForKey:kTopicDay];
    //
   // NSLog(@"Day key:%@",dayKey);
    NSMutableDictionary *dayDict=[catalogDict objectForKey:dayKey];
    
    NSString *tracKey=[currentDict objectForKey:kTopicTrack];
   // NSLog(@"tracKey key:%@",tracKey);
    
    NSMutableArray *tracArray=[dayDict objectForKey:tracKey];
    
    
    
    // NSLog(@"Day key:%@",[dayDict objectForKey:kTopicTrack];);
    
    NSString *currentTopicTitle=[currentDict objectForKey:kTopicTitle];
    //
    NSInteger topicIndex=0;
    BOOL isDictFound=NO;
    
    for (NSMutableDictionary *topicDict in tracArray) {
        
        NSString *tempTopicTitle=[topicDict objectForKey:kTopicTitle];
        if([tempTopicTitle isEqualToString:currentTopicTitle]){
            isDictFound=YES;
            break;
        }
        topicIndex++;
    }
    
    if(isDictFound){
        NSMutableDictionary *dictFound=[tracArray objectAtIndex:topicIndex];
        [dictFound setObject:[currentDict objectForKey:kTopicStatus] forKey:kTopicStatus];
        [dictFound setObject:[currentDict objectForKey:kTopicParticipated] forKey:kTopicParticipated];
        [dictFound setObject:[currentDict objectForKey:kTopicMissed] forKey:kTopicMissed];
        [self saveCatalogDict];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_ORGANISER" object:nil];
    }
}

@end
