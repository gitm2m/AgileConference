//
//  ACViewController.h
//  AgileConference
//
//  Created by Valtech India on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACCustomRootViewController.h"
#import "ACAppConstants.h"
#import "FlowCoverView.h"
#import <QuartzCore/QuartzCore.h>
#import "ACTracksEventsListViewController.h"
#import "WEPopoverController.h"
#import "ACSearchPopoverViewController.h"


@interface ACAppController : ACCustomRootViewController<FlowCoverViewDelegate,PopoverControllerDelegate>{
    
    FlowCoverView *tracksCoverView;
    NSArray *tracksCoverFlowImgsArray;
    WEPopoverController *tracksEventsPopoverController;
    WEPopoverController *searchPopoverController;
    ACTracksEventsListViewController *contentViewController;
    ACSearchPopoverViewController *serachPopoverContentViewController;
}

@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *organizerButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *daysSegmentController;
@property (strong, nonatomic) IBOutlet UIView *shareFeedBackView;


- (void) setupView;
- (IBAction)daysSegmentControllerValueChanged:(id)sender;
- (IBAction)organizerButtonTapped:(id)sender;
- (IBAction)infoButtonTapped:(id)sender;
- (void)searchButtonTapped : (id)sender;
- (void)shareButtonTapped : (id)sender;
 @end
