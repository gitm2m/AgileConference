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
#import "ACAppConstants.h"

@protocol ACSearchViewDelegate ;

@interface ACSearchView : UIView<ACEventsListHeaderViewDelegate>{
    
    id<ACSearchViewDelegate>delegate;
    NSDictionary *eventsListTableContentsDict;
    NSMutableArray *eventsListTableHeaderArray;
    NSArray *array;
    BOOL reloadHeaderNeeded;
    IBOutlet UISearchBar *eventsSearchBar;
    
    //
    NSMutableDictionary  *searchDataDictionary;
    //
    NSMutableArray *daySectionArray;
    NSMutableArray *trackSectionArray;
    NSMutableArray *commonSectionArray;
    //
    NSMutableArray *accordionViewTrackArray;
    NSMutableArray *accordionViewDayArray;
    NSMutableArray *accordionViewCommonArray;
    //
    
    NSString *searchContent;
    NSString *sortBy;
    NSMutableArray *commonRowArray;

}

@property (strong, nonatomic) id<ACSearchViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *searchResultTableView;
-(void)searchCatalogAndShowResult;

@end

@protocol ACSearchViewDelegate 

@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
