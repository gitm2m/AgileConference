//
//  ACAppSetting.h
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonUtility.h"

@interface ACAppSetting : NSObject{
    
    NSString *daySelected;
    NSString *trackSelected;
    NSMutableDictionary *upCommingEventDict;
    NSInteger organiserSegmentIndex;
}
@property(strong,nonatomic)     NSString *daySelected;
@property (strong,nonatomic)    NSString *trackSelected;
@property (strong,nonatomic)    NSMutableDictionary *upCommingEventDict;
@property (nonatomic)    NSInteger  organiserSegmentIndex;





+(ACAppSetting *)getAppSession;
-(void)setDefaultValues;
-(void)resetToDefaultValues;



@end
