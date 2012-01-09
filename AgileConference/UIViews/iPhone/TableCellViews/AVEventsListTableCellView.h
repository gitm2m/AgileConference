//
//  AVEventsListTableCellView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVEventsListCellView.h"

@interface AVEventsListTableCellView : UITableViewCell{
    
    AVEventsListCellView *cellView;

}
@property (strong,nonatomic) NSDictionary *cellData;

@end
