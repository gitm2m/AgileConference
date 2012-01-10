//
//  ACEventsListHeaderView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/2/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACEventsListHeaderView.h"

@implementation ACEventsListHeaderView
@synthesize delegate;
@synthesize eventsListHeaderButton;
@synthesize evemtsListTableHeaderLabel;
@synthesize headerAccesoryImage;
@synthesize indexOfSection;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Events Methods

- (IBAction)headerButtontapped:(id)sender {
    
        [delegate eventsListHeaderButtonTapped:sender inView:self];
}
@end
