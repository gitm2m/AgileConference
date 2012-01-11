//
//  ACOrganizerView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/3/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVEventsListTableCellView.h"
#import "ACAppConstants.h"
#import "ACOrganizerView.h"

@protocol ACOrganizerViewDelegate;

@interface ACOrganizerView : UIView{
    
    NSMutableArray *eventArray;
}

@property (strong, nonatomic) id<ACOrganizerViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *organizerListTableView;

- (IBAction)segmentValueChanged:(id)sender;

@end


@protocol ACOrganizerViewDelegate

@optional 
- (void)organizerListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; 

@end
