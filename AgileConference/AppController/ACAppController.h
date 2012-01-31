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
#import "ACMatrixCatalogView.h"
#import "GCCalendar.h"

@interface ACAppController : ACCustomRootViewController<FlowCoverViewDelegate,PopoverControllerDelegate,ACSearchViewDelegate,ACTracksEventsListViewControllerDelegate,UIActionSheetDelegate,ACOrganizerViewDelegate,UIWebViewDelegate,ACFacebookShareViewDelegate,ACSplashViewDelegate,CLLocationManagerDelegate,GCCalendarDelegate,GCCalendarDataSource>{
    
    FlowCoverView *tracksCoverView;
    NSArray *tracksCoverFlowImgsArray;
    WEPopoverController *tracksEventsPopoverController;
    WEPopoverController *searchPopoverController;
    ACTracksEventsListViewController *contentViewController;
    IBOutlet UIButton *aboutButton;
    ACSearchPopoverViewController *serachPopoverContentViewController;
    NSInteger finalTrackIndex;
    NSInteger preFinalTrackIndex;
    NSInteger preFinalDayIndex;
    UIBarButtonItem *searchButton;
    UIBarButtonItem *searchDoneButton;
    //
    ACSplashView *splashScreenView;
    ACFacebookShareView *fbShareView;
    ACMatrixCatalogView *matrixCatalogView;
    BOOL isFBLoginFirtTime,didFinishedPostingOnWall;
    UIButton *organizerButtn;
    CLLocationManager *locationManager;
    GCCalendarPortraitView *calendar ;
    UIScrollView *tracksScrollView;
    NSDate *selectedDateFromCalendarView;
    NSMutableArray *topicArray;
    BOOL isCoverFlowView;
}

@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *daysSegmentController;
@property (strong, nonatomic) IBOutlet UIView *shareFeedBackView;
@property (strong, nonatomic) IBOutlet UIView *homeCoverViewHolderView;
@property (strong, nonatomic) IBOutlet ACSearchView *searchHolderView;
@property (strong, nonatomic) ACOrganizerView *organizerView;
@property (strong, nonatomic) IBOutlet UIImageView *popOverImageView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIButton *segmentBtn1;
@property (strong, nonatomic) IBOutlet UIButton *segmentBtn2;
@property (strong, nonatomic) IBOutlet UIButton *segmentBtn3;



- (void) setupView;
- (void) setupViewsFromNib;
- (IBAction)daysSegmentControllerValueChanged:(id)sender;
- (IBAction)infoButtonTapped:(id)sender;
- (void)searchButtonTapped : (id)sender;
- (void)shareButtonTapped : (id)sender;
- (BOOL)isOrganizerViewVisibleOnScreen;
- (BOOL)isSearchViewVisibleOnScreen;
- (void)showSplasScreen;
- (void)displayFacebookShareView;
- (void)postFacebookFeed;
- (void)postFacebookFeedOnPage;
- (void)animateViewsOnSwitchButtonTapped;
- (IBAction)aboutButtonTapped:(id)sender;
- (void)changeNavigationViewBydelayWithName : (NSString*)navigationName;
- (void)fbGraphCallback:(id)sender;
- (void)getDirectionWithLatitude : (CLLocation *)location;
- (void)calendarTrackButtonTapped : (id)sender;
- (void)delayTrckScrollViewAnimate ;
@end
