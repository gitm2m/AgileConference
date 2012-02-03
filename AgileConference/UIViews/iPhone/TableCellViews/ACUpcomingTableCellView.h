//
//  ACUpcomingTableCellView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/18/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACUpcomingCellView.h"

@interface ACUpcomingTableCellView : UITableViewCell{
     ACUpcomingCellView *cellView;
    NSInteger currindex;
}
@property (strong,nonatomic) NSMutableDictionary *cellData;
@property (nonatomic) NSInteger currindex;

@end
