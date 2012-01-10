//
//  ACFacebookShareView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/10/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACFacebookShareView.h"

@implementation ACFacebookShareView
@synthesize fbShareTextView,delegate;

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

- (IBAction)cancelButtonTapped:(id)sender {
    
    [delegate cancelButtonTapped:sender];
}



- (IBAction)sendButtonTapped:(id)sender {
    
    [delegate sendButtonTapped:sender];
}
@end
