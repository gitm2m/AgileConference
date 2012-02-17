//
//  ACAlertView.h
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 18/02/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACAlertView : UIAlertView{
    
    NSMutableDictionary *noteTopicDict;
    NSString *notificationType;

}

@property(strong, nonatomic) NSMutableDictionary *noteTopicDict;
@property(strong, nonatomic) NSString *notificationType;



@end
