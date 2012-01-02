//
//  ACSearchView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/30/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVEventsListTableCellView.h"

@protocol ACSearchViewDelegate ;

@interface ACSearchView : UIView{
    
    id<ACSearchViewDelegate>delagate;
}

@property (strong, nonatomic) id<ACSearchViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *searchResultTableView;

@end

@protocol ACSearchViewDelegate 

@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
