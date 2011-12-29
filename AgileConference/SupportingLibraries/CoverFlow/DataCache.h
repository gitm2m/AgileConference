//
//  ACAppConstants.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//    


#import <Foundation/Foundation.h>


@interface DataCache : NSObject 
{
	int fCapacity;
	NSMutableDictionary *fDictionary;
	NSMutableArray *fAge;
}

- (id)initWithCapacity:(int)cap;

- (id)objectForKey:(id)key;
- (void)setObject:(id)value forKey:(id)key;

@end
