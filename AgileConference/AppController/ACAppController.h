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
#import "ACSearchView.h"
#import "ACAboutViewController.h"
#import "ACEventDetailViewController.h"
#import "ACOrganizerView.h"
#import "ACEventsListViewController.h"
#import "ACAppSetting.h"
#import "ACSplashView.h"
#import "FbGraph.h"
#import "ACFacebookShareView.h"
#import "ACSplashView.h"
#import "TestUtility.h"

@interface ACAppController : ACCustomRootViewController<FlowCoverViewDelegate,PopoverControllerDelegate,ACSearchViewDelegate,ACTracksEventsListViewControllerDelegate,UIActionSheetDelegate,ACOrganizerViewDelegate,UIWebViewDelegate,ACFacebookShareViewDelegate,ACSplashViewDelegate>{
    
    FlowCoverView *tracksCoverView;
    NSArray *tracksCoverFlowImgsArray;
    WEPopoverController *tracksEventsPopoverController;
    WEPopoverController *searchPopoverController;
    ACTracksEventsListViewController *contentViewController;
    ACSearchPopoverViewController *serachPopoverContentViewController;
    NSInteger finalTrackIndex;
    NSInteger preFinalTrackIndex;
    NSInteger preFinalDayIndex;


    ACSplashView *splashScreenView;
    ACFacebookShareView *fbShareView;
    BOOL isFBLoginFirtTime,didFinishedPostingOnWall;
}

@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *daysSegmentController;
@property (strong, nonatomic) IBOutlet UIView *shareFeedBackView;
@property (strong, nonatomic) IBOutlet UIView *homeCoverViewHolderView;
@property (strong, nonatomic) IBOutlet ACSearchView *searchHolderView;
@property (strong, nonatomic) ACOrganizerView *organizerView;



- (void) setupView;
- (void) setupViewsFromNib;
- (IBAction)daysSegmentControllerValueChanged:(id)sender;
- (IBAction)infoButtonTapped:(id)sender;
- (void)searchButtonTapped : (id)sender;
- (void)shareButtonTapped : (id)sender;
- (BOOL)isOrganizerViewVisibleOnScreen;
- (BOOL)isSearchViewVisibleOnScreen;
- (void)showSplasScreen;
- (void)checkForFacebookSession;
- (void)displayFacebookShareView;
- (void)postFacebookFeed;
- (void)postFacebookFeedOnPage;

@end
