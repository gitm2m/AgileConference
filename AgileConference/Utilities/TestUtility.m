//
//  TestUtility.m
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 29/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "TestUtility.h"
#import "ACOrganiser.h"
#import "ACAppConstants.h"
#import "CommonUtility.h"

@implementation TestUtility

-(id)init{
    
    self=[super init];
    if(self){
        
    }
    return self;

}


-(void)test{
    
    //NSMutableDictionary *dict=[[ACAppSetting getAppSession] getCatlogDict];
    ////NSLog(@"Dict:<<<<<%@>>>>>",dict);
    
    
    //[[ACOrganiser getOrganiser]getCatalogListOfType:kTopicFavorite andCatalogTypeContent:@"YES"];
    //[[ACOrganiser getOrganiser]searchCatalogWithSearchKey:@"Track" andSearchValue:@"Track1"];
    
     [CommonUtility schedulNotification:@"17-02-2012" andTime:@"10:35" andFormat:@"dd-MM-yyyy, HH:mm"];
    ////NSLog(@"Dict:<<<<<%@>>>>>",dict);
    
    //NSLog(@"Test method called>>>>>>");
    
}

@end
