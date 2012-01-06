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

@interface ACOrganizerView : UIView

@property (strong, nonatomic) id<ACOrganizerViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *organizerListTableView;

@end


@protocol ACOrganizerViewDelegate

@optional 
- (void)organizerListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; 

@end
