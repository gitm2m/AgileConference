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
                                   isDocumentDirecory:NO];
        catalogDict=[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return catalogDict;
    
}
//
-(BOOL)saveCatalogDict{
    
    if(catalogDict){
        
        NSString *filePath=[CommonUtility getFilePath:@"Catalog" 
                                             fileType:@"plist" 
                                   isDocumentDirecory:NO];
        
        return [catalogDict writeToFile:filePath atomically:YES];
    }
    
    return NO;

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
                 
                 if([[topicDict objectForKey:catalogType] isEqualToString:content]){
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
    
    NSLog(@"%@ list:%@",catalogType,favDict);
    return favDict;
}


//search with day , track and topic key
-(NSMutableDictionary *)searchCatalogWithSearchKey:(NSString *)searchKey 
                             andSearchValue:(NSString *)searchValue{
    
    if([searchKey hasPrefix:@"Topic_"]){
        return [self getCatalogListOfType:searchKey andCatalogTypeContent:searchValue];
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
        NSLog(@"Search key:%@, SearchValue:%@ list:%@",searchKey,searchValue,resultDict);
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
        NSLog(@"Search key:%@, SearchValue:%@ list:%@",searchKey,searchValue,resultDict);
        return resultDict;
    }
    
    return nil;
}
//
-(void)updateCatalogDict:(NSMutableDictionary *)currentDict{
    
    NSMutableDictionary *dayDict=[catalogDict objectForKey:[currentDict objectForKey:kTopicDay]];
    NSMutableArray *tracArray=[dayDict objectForKey:kTopicTrack];
    NSString *currentTopicTitle=[currentDict objectForKey:kTopicTitle];
    //
    NSInteger topicIndex=0;
    BOOL isDictFound=NO;
    
    for (NSMutableDictionary *topicDict in tracArray) {
        
        NSString *tempTopicTitle=[topicDict objectForKey:kTopicTitle];
        if([tempTopicTitle isEqualToString:currentTopicTitle]){
            break;
        }
        topicIndex++;
    }
    
    if(isDictFound){
        [tracArray replaceObjectAtIndex:topicIndex withObject:currentDict];
    }
    
    
}


//-(NSMutableDictionary *)searchCatalogOfType:(NSString *)catalogType 
//                              withSearchKey:(NSString *)searchKey
//                             andSearchValue:(NSString *)serachValue{
//    
//    NSMutableDictionary *dicToBeSearched=[self getCatalogListOfType:searchKey andCatalogTypeContent:serachValue];
//    return dicToBeSearched;
//    
//    
//}


/////





@end
