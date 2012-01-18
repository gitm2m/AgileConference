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
    NSString *isNormalBusiness;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)normalBusiness;
@property (strong,nonatomic) NSMutableDictionary *cellData;

@end
