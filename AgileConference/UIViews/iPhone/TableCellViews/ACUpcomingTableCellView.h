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
}
@property (strong,nonatomic) NSMutableDictionary *cellData;
@end
