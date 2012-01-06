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

@interface ACEventsListViewController : UIViewController<ACEventDetailViewControllerDelegate,ACEventDescriptionWebviewControllerDelegate>{
    
    NSIndexPath *selectedEventTrackIndexPath;
}

@property (strong, nonatomic) IBOutlet UITableView *eventsListTableView;
@end
