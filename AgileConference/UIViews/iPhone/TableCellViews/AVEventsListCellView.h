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
   NSMutableDictionary *cellData;

    
    
}

@property (strong, nonatomic) IBOutlet UIButton *favButton;
@property (strong, nonatomic) IBOutlet UILabel *speakerLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) NSMutableDictionary *cellData;
@property (strong, nonatomic) IBOutlet UIImageView *favImageView;
@property (strong, nonatomic) IBOutlet UILabel *breakCellTopicLabel;
@property (strong, nonatomic) IBOutlet UILabel *breakLabelTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTrackLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cellBgView;
@property (strong, nonatomic) IBOutlet UIImageView *statusImageView;

- (IBAction)favouriteButtonTapped:(id)sender;

@end
