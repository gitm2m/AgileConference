//
//  AVEventsListCellView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVEventsListCellView : UIView{
    
   IBOutlet UILabel *speakerLabel;
   IBOutlet UILabel *timeLabel;
   IBOutlet UILabel *statusLabel;
   IBOutlet UILabel *topicLabel;
   NSDictionary *cellData;

    
    
}

@property (strong, nonatomic) IBOutlet UILabel *speakerLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong,nonatomic) NSDictionary *cellData;

@end
