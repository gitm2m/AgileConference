//
//  ACTracksEventsListViewController.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACUpcomingTableCellView.h"

@protocol ACTracksEventsListViewControllerDelegate;

@interface ACTracksEventsListViewController : UIViewController{
    
    NSMutableArray *topicArray;
    BOOL isBottomAnimation;
}

@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;
@property (strong, nonatomic) id<ACTracksEventsListViewControllerDelegate>delegate;


-(IBAction)viewMoreTopicsButtonTapped:(id)sender;
-(void)setupView;
-(void)changeCellsLables : (NSArray *)topicNamesArray;
-(void)reloadEventTableViewWithAnimation:(BOOL)animated;


@end

@protocol ACTracksEventsListViewControllerDelegate

@optional
- (void)viewMoreTopicsButtonTapped:(id)sender inView:(ACTracksEventsListViewController*)tracksEventsListView;
- (void)eventsTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end