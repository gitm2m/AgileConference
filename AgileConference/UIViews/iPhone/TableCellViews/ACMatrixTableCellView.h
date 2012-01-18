//
//  ACMatrixTableCellView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/17/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACMatrixCellView.h"

@interface ACMatrixTableCellView : UITableViewCell{
    ACMatrixCellView *cellView;
    NSString *isHeaderCell;
}


@property (strong,nonatomic) NSMutableDictionary *cellData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)isHeader;
@end
