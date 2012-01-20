//
//  AVEventsListTableCellView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "AVEventsListTableCellView.h"

@implementation AVEventsListTableCellView
@synthesize cellData,rowNumber;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"AVEventsListCellView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
        for (id object in nibObjects) {
            if ([object isKindOfClass:[AVEventsListCellView class]])
                cellView = (AVEventsListCellView*)object;
        }   
		[self.contentView addSubview: cellView];
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)normalBusiness
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
        
        isNormalBusiness = normalBusiness;
        
        NSArray *nibObjects = nil;
        
        if ([normalBusiness isEqualToString:@"BUSINESS"]) 
            nibObjects = [[NSBundle mainBundle] loadNibNamed:@"AVEventsListCellView" owner:self options:nil];
        else if([normalBusiness isEqualToString:@"BREAK"])
            nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACEventListTeaBreakCellView" owner:self options:nil];
        else if([normalBusiness isEqualToString:@"NORMAL"])
            nibObjects = [[NSBundle mainBundle] loadNibNamed:@"AVEventsListCellView" owner:self options:nil];

            // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
        for (id object in nibObjects) {
            if ([object isKindOfClass:[AVEventsListCellView class]])
                cellView = (AVEventsListCellView*)object;
        }   
		[self.contentView addSubview: cellView];
    }
    return self;
}




-(void)layoutSubviews
{
	[super layoutSubviews];

    cellView.frame = CGRectMake(0, 0, 320,kEventTableCellHeight);
    
    if ([isNormalBusiness isEqualToString:@"BREAK"])
        cellView.frame = CGRectMake(0, 0, 320,24);
    
	[cellView setNeedsLayout];
	[cellView setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

-(void)setCellData:(NSMutableDictionary *)inCellData
{
    if((rowNumber % 2)==0)
        [cellView.cellBgView setImage:[UIImage imageNamed:@"rowBg1.png"]];
    else
        [cellView.cellBgView setImage:[UIImage imageNamed:@"rowBg2.png"]];
    cellView.cellData = inCellData;
    
    if ([isNormalBusiness isEqualToString:@"BUSINESS"]){
        
        cellView.cellData = inCellData;
        cellView.topicLabel.text=[inCellData objectForKey:kTopicTitle];
        cellView.speakerLabel.text=[inCellData objectForKey:kTopicSpeaker];
        if([[inCellData objectForKey:kTopicSpeaker] isEqualToString:@""]&&[[inCellData objectForKey:kTopicType] isEqualToString:@"BUSINESS"])
            cellView.speakerLabel.text=@"Presenter";
        cellView.timeLabel.text=[inCellData objectForKey:kTopicTime];
        cellView.statusLabel.text=[inCellData objectForKey:kTopicStatus];
        
        NSString *dayKey=[inCellData objectForKey:kTopicDay];
        if([dayKey hasSuffix:@"1"]){
            dayKey=@"D1";
        }
        else if([dayKey hasSuffix:@"2"]){

            dayKey=@"D2";
            
        }
        else if([dayKey hasSuffix:@"3"]){

            dayKey=@"D3";
            
        }

        NSString *trackKey=[inCellData objectForKey:kTopicTrack];
        
        trackKey = [NSString stringWithFormat:@"T%@",[trackKey substringFromIndex:[trackKey length]-1]];
        
        cellView.dateTrackLabel.text = [NSString stringWithFormat:@"%@,%@",dayKey,trackKey];
        
        if ([[inCellData objectForKey:kTopicFavorite] isEqualToString:@"YES"])
            [cellView.favButton setBackgroundImage:[UIImage imageNamed:@"Fav.png"] forState:UIControlStateNormal];
        else
            [cellView.favButton setBackgroundImage:[UIImage imageNamed:@"EmptyFavourites Icon.png"] forState:UIControlStateNormal];

    }
    else if ([isNormalBusiness isEqualToString:@"BREAK"]){
        cellView.breakCellTopicLabel.text = [inCellData objectForKey:kTopicTitle];
        cellView.breakLabelTimeLabel.text = [inCellData objectForKey:kTopicTime];
    }
    else if ([isNormalBusiness isEqualToString:@"NORMAL"]){
        cellView.breakCellTopicLabel.text = [inCellData objectForKey:kTopicTitle];
        cellView.breakLabelTimeLabel.text = [inCellData objectForKey:kTopicTime];
    }
	    
}


@end
