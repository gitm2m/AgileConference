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
    [self updateStatusOfCatalogDict];
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

-(void)updateStatusOfCatalogDict{
    
    if(catalogDict){
        
        NSArray *dayKeyArray=[catalogDict allKeys];
        NSLog(@"Topic dayKeyArray.....%@", dayKeyArray);

        
        for (NSString *dayKey in dayKeyArray) {
            
            NSLog(@"Topic dayKey.....%@", dayKey);

            NSMutableDictionary *trackDict=[catalogDict objectForKey:dayKey];
            NSArray *trackKeyArray=[trackDict allKeys];
            NSLog(@"Topic dayKeyArray.....%@", trackKeyArray);

            for (NSMutableDictionary *trackKey in trackKeyArray) {

                //
                NSMutableArray* topicArrayInTrack=[trackDict objectForKey:trackKey];
                //
                for (NSMutableDictionary *topicDict in topicArrayInTrack) {
                    
                    NSString  *topicStatus=[topicDict objectForKey:kTopicOver];
                   if([topicStatus isEqualToString:@"Open"] || [topicStatus isEqualToString:@"Running"]){
                        NSLog(@"Topic dicts.....%@", topicDict);

                        
                        NSDate    *currDate=[NSDate date];
                        NSString  *topicDay=[topicDict objectForKey:kTopicDay];
                        NSString  *topicTime=[topicDict objectForKey:kTopicTime];
                        NSArray   *topicTimeArray=[topicTime componentsSeparatedByString:@","];
                        //
                        NSString  *topicTimeFirstObject=[topicTimeArray objectAtIndex:0];
                        NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@"-"] objectAtIndex:0];
                        NSString  *eventStartDayTime=[NSString stringWithFormat:@"%@, %@",topicDay,startTime];
                        NSDate    *eventStartDate=[CommonUtility convertStringToDate:eventStartDayTime format:@"dd-MM-yyyy, HH:mm"];

                        //
                        NSString  *topicTimeLastObject=[topicTimeArray lastObject];
                        NSString  *endTime=[[topicTimeLastObject componentsSeparatedByString:@"-"] objectAtIndex:1];
                        NSString  *eventDayTime=[NSString stringWithFormat:@"%@, %@",topicDay,endTime];
                        NSDate    *eventEndDate=[CommonUtility convertStringToDate:eventDayTime format:@"dd-MM-yyyy, HH:mm"];
                    
                        NSLog(@"currDate date>>>>%@", [NSDate date]);

                        NSLog(@"Event Start date>>>>%@", eventStartDate);
                        NSLog(@"Event end date>>>>%@", eventEndDate);

                        //
                        NSComparisonResult comparisonResultStart=[eventStartDate compare:currDate];
                        switch (comparisonResultStart) {
                            case NSOrderedAscending:
                            {
                                [topicDict setObject:@"Running" forKey:kTopicOver];
                            }
                                break;
                                
                            case NSOrderedSame:
                            {
                                [topicDict setObject:@"Running" forKey:kTopicOver];
                                
                            }
                                break;
                                
                            case NSOrderedDescending:
                            {
                                [topicDict setObject:@"Open" forKey:kTopicOver];
                                
                            }
                                break;
                                
                                
                            default:
                                break;
                        }

                        //
                        NSComparisonResult comparisonResultEnd=[eventEndDate compare:currDate];
                        switch (comparisonResultEnd) {
                                
                            case NSOrderedAscending:
                            {
                                [topicDict setObject:@"Closed" forKey:kTopicOver];
                            }
                                break;
                                
                            case NSOrderedSame:
                            {
                                [topicDict setObject:@"Closed" forKey:kTopicOver];

                            }
                                break;
                                
                            case NSOrderedDescending:
                            {
                                //[topicDict setObject:@"Closed" forKey:kTopicOver]

                            }
                                break;

                                
                            default:
                                break;
                        }
                        

                    }
                    
                    
                }
                
            }
            
        }
    }
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
                
                //NSLog(@">>>event key value>>%@",[topicDict objectForKey:catalogType]);
                //NSLog(@">>>search content>>%@",content);
               // NSLog(@">>>search content>>%i",[[topicDict objectForKey:catalogType] rangeOfString:content].length);

                

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
    
    ACLog(@"%@ search list:%@",catalogType,favDict);
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
    if([dayKey hasPrefix:@"17"]){
        dayKey=@"Day1";
    }
    else if([dayKey hasPrefix:@"18"]){
        dayKey=@"Day2";

    }
    else if([dayKey hasPrefix:@"19"]){
        dayKey=@"Day3";

    }

    NSLog(@"Day key:%@",dayKey);
    NSMutableDictionary *dayDict=[catalogDict objectForKey:dayKey];
    
    NSString *tracKey=[currentDict objectForKey:kTopicTrack];
    NSLog(@"tracKey key:%@",tracKey);

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



@end
