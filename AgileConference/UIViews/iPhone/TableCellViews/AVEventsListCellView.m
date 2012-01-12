//
//  AVEventsListCellView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "AVEventsListCellView.h"

@implementation AVEventsListCellView
@synthesize speakerLabel;
@synthesize timeLabel;
@synthesize statusLabel;
@synthesize topicLabel;
@synthesize cellData;
@synthesize favImageView;
@synthesize breakCellTopicLabel;
@synthesize breakLabelTimeLabel;
@synthesize dateTrackLabel;

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
}


-(void)layoutSubviews
{
	
}

@end
