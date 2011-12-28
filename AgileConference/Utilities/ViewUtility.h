//
//  ViewUtility.h
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewUtility : NSObject{
    
}
//
+(UIAlertView *)showAlertViewWithMessage:(NSString *)message;
+(UIAlertView *)showAlertViewWithMessage:(NSString *)message andButtons:(NSString *)btnTitles;

//
-(id)createViewOfType:(viewType)typeOfView 
              ofClass:(id)typeOfClass
            WithFrame:(CGRect)frame 
          withBGColor:(UIColor *)bgColor 
           withBGView:(UIImageView *)bgView;

-(id)createViewControllerOfType:(viewType)typeOfView 
                        ofClass:(id)typeOfClass
                       WithView:(id)view;
@end
