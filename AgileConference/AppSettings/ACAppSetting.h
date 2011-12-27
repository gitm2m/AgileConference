//
//  ACAppSetting.h
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACAppSetting : NSObject{
}

+(ACAppSetting *)getAppSession;
-(void)setDefaultValues;
-(void)resetToDefaultValues;



@end
