//
//  ACOrganiser.h
//  AgileConference
//
//  Created by Deepak Shukla on 28/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACOrganiser : NSObject{
    
    NSMutableDictionary *catalogDict;
    
}

+(ACOrganiser *)getOrganiser;

-(NSMutableDictionary *)getCatalogDict;
-(BOOL)saveCatalogDict;
//
-(NSMutableDictionary *)getCatalogListOfType:(NSString *)catalogType 
                       andCatalogTypeContent:(NSString *)content;
//
-(NSMutableDictionary *)searchCatalogWithSearchKey:(NSString *)searchKey 
                                    andSearchValue:(NSString *)searchValue;

-(void)updateCatalogDict:(NSMutableDictionary *)currentDict;

//
-(NSMutableArray *)getArrayOfDict:(NSMutableDictionary *)dict;
-(NSInteger)updateStatusOfEventOnTime:(NSString *)topicTime andDate:(NSString *)topicDate;
-(void)updateCatalogDictPostNotification:(NSMutableDictionary *)currentDict;


@end
