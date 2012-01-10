//
//  ACEventsListHeaderView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/2/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACEventsListHeaderViewDelegate;


@interface ACEventsListHeaderView : UIView{
    
    NSInteger indexOfSection;
    
}
@property (strong,nonatomic) id<ACEventsListHeaderViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIButton *eventsListHeaderButton;
@property (strong, nonatomic) IBOutlet UILabel *evemtsListTableHeaderLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headerAccesoryImage;
@property (nonatomic) NSInteger indexOfSection;


- (IBAction)headerButtontapped:(id)sender;
@end


@protocol ACEventsListHeaderViewDelegate

@optional
- (void)eventsListHeaderButtonTapped : (id)sender inView : (ACEventsListHeaderView *)headerView;

@end