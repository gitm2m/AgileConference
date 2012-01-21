//
//  AVEventsListCellView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "AVEventsListCellView.h"

@implementation AVEventsListCellView
@synthesize favButton;
@synthesize speakerLabel;
@synthesize timeLabel;
@synthesize statusLabel;
@synthesize topicLabel;
@synthesize cellData;
@synthesize favImageView;
@synthesize breakCellTopicLabel;
@synthesize breakLabelTimeLabel;
@synthesize dateTrackLabel;
@synthesize cellBgView;

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
    [topicLabel setFont:[CommonUtility fontSegoiBold:13.0f]];
    [timeLabel setFont:[CommonUtility fontSegoi:10.0f]];
    [speakerLabel setFont:[CommonUtility fontSegoi:11.0f]];
    [dateTrackLabel setFont:[CommonUtility fontSegoi:10.0f]];
	
}


#pragma Events Methods
- (IBAction)favouriteButtonTapped:(id)sender {
    
    if ([[cellData valueForKey:kTopicFavorite] isEqualToString:@"NO"]) {
        [cellData setObject:@"YES" forKey:kTopicFavorite];
        [favButton setBackgroundImage:[UIImage imageNamed:@"Fav.png"] forState:UIControlStateNormal];
        [[ACOrganiser getOrganiser]updateCatalogDict:cellData];
        [CommonUtility schedulPreNotificationOfEvent:cellData];
        
    }else if([[cellData valueForKey:kTopicFavorite] isEqualToString:@"YES"]){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAppName 
                                                            message:@"Are you sure you want to remove from favourites." 
                                                           delegate:self 
                                                  cancelButtonTitle:@"No" 
                                                  otherButtonTitles:@"Yes", nil];
        [alertView show];
        
        
    }

    
}

# pragma mark UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [cellData setObject:@"NO" forKey:kTopicFavorite];
        [favButton setBackgroundImage:[UIImage imageNamed:@"EmptyFavourites Icon.png"] forState:UIControlStateNormal];
        [[ACOrganiser getOrganiser]updateCatalogDict:cellData];
        [CommonUtility cancelNotificationOfEvent:cellData];
        
    }
}

@end
