//
//  ACUpcomingCellView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/18/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACUpcomingCellView.h"

@implementation ACUpcomingCellView
@synthesize topicLabel;
@synthesize breakImageView;
@synthesize timeLabel;
@synthesize statusImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [topicLabel setFont:[CommonUtility fontSegoiBold:11]];
    [timeLabel setFont:[CommonUtility fontSegoi:10]];
}


@end
