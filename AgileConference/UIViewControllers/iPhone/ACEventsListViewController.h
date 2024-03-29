//
//  ACEventsListViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/3/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVEventsListTableCellView.h"
#import "ACEventDetailViewController.h"
#import "ACEventDescriptionWebviewController.h"
#import "ACAppConstants.h"
#import "ACCustomRootViewController.h"

@interface ACEventsListViewController : ACCustomRootViewController<ACEventDetailViewControllerDelegate,ACEventDescriptionWebviewControllerDelegate>{
    
    NSIndexPath *selectedEventTrackIndexPath;
    NSMutableArray *topicArray;
}

@property (strong, nonatomic) IBOutlet UITableView *eventsListTableView;
@end
