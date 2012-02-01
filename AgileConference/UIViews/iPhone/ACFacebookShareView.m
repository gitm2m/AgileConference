//
//  ACFacebookShareView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/10/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACFacebookShareView.h"

@implementation ACFacebookShareView
@synthesize fbShareTextView,delegate,topicDict;

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


-(void)layoutSubviews{
    
    if (topicDict != nil) {
        NSString *shareFormatSrtring = [NSString stringWithFormat:@"%@ \n",kShareMessage];
        NSMutableString *shareMessage = [[NSMutableString alloc] init];
        if ([[topicDict valueForKey:kTopicTitle] length]>0) {
            
            [shareMessage appendFormat:[NSString stringWithFormat:shareFormatSrtring,[topicDict valueForKey:kTopicTitle]]];
            
        }else{
            [shareMessage appendString:@"Write your share message here..!!"];
        }
        
        if ([[topicDict valueForKey:kTopicLink] length]>0){
            [shareMessage appendString:[topicDict valueForKey:kTopicLink]];
        }
        
        ACLog(@"shareMessage %@", topicDict);
        if ([shareMessage length]>0) {
            [fbShareTextView setText:shareMessage];
        }

    }else{
        [fbShareTextView setText:@"Agile 2012 \nhttp://agile2012.in/ - Posted via Valtech's Agile2012 iPhone app."];
    }
    
   
    
}

#pragma mark - Events Methods

- (IBAction)cancelButtonTapped:(id)sender {
    
    [delegate cancelButtonTapped:sender];
}



- (IBAction)sendButtonTapped:(id)sender {
    
    [delegate sendButtonTapped:sender];
}
@end
