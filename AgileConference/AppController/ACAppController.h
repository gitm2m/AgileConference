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


@interface ACAppController : ACCustomRootViewController<FlowCoverViewDelegate,PopoverControllerDelegate>{
    
    FlowCoverView *tracksCoverView;
    NSArray *tracksCoverFlowImgsArray;
    WEPopoverController *tracksEventsPopoverController;
    
}

- (void) setupView;
 @end
