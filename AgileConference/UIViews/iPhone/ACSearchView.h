//
//  ACSearchView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/30/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVEventsListTableCellView.h"
#import "ACEventsListHeaderView.h"


@protocol ACSearchViewDelegate ;

@interface ACSearchView : UIView<ACEventsListHeaderViewDelegate>{
    
    id<ACSearchViewDelegate>delegate;
    NSDictionary *eventsListTableContentsDict;
    NSMutableArray *eventsListTableHeaderArray,*accordionViewTrackArray;
    NSArray *array;
    BOOL reloadHeaderNeeded;
    
   
}

@property (strong, nonatomic) id<ACSearchViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *searchResultTableView;

@end

@protocol ACSearchViewDelegate 

@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
