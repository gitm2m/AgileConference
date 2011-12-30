//
//  ACTracksEventsListViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ACTracksEventsListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;


- (IBAction)viewMoreTopicsButtonTapped:(id)sender;
- (void)setupView;
- (void)changeCellsLables : (NSArray *)topicNamesArray;

@end
