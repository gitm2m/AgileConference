//
//  ACUpcomingTableCellView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/18/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACUpcomingTableCellView.h"

@implementation ACUpcomingTableCellView
@synthesize cellData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACUpcomingCellView" owner:self options:nil];
            // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
        for (id object in nibObjects) {
            if ([object isKindOfClass:[ACUpcomingCellView class]])
                cellView = (ACUpcomingCellView*)object;
        }   
		[self.contentView addSubview: cellView];
    }
    return self;

}

-(void)layoutSubviews
{
    cellView.frame = CGRectMake(0, 0, 320,49);
    [cellView setNeedsLayout];
	[cellView setNeedsDisplay];
	[super layoutSubviews];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSMutableDictionary *)inCellData
{   
    if ([[inCellData valueForKey:kTopicType] isEqualToString:@"BUSINESS"]) {
        [cellView.breakImageView setHidden:YES];
    }
    else if([[inCellData valueForKey:kTopicType] isEqualToString:@"BREAK"]){
        [cellView.breakImageView setHidden:NO];
    }
    else if([[inCellData valueForKey:kTopicType] isEqualToString:@"NORMAL"]){
        [cellView.breakImageView setHidden:YES];

    }else if([[inCellData valueForKey:kTopicType] isEqualToString:@"BLANK"]){
        for (UIView *childView in cellView.subviews) {
            [childView setHidden:YES];
        }
        return;
    }
    
    cellView.topicLabel.text = [inCellData objectForKey:kTopicTitle];
    cellView.timeLabel.text =[CommonUtility convertDateToAMPMFormat:[inCellData objectForKey:kTopicTime]];
       
    switch ([[ACOrganiser getOrganiser] updateStatusOfEventOnTime:cellView.timeLabel.text 
                                                          andDate:[inCellData objectForKey:kTopicDate]]) {
        case -1:{
            [cellView.statusImageView setImage:[UIImage imageNamed:@"ClosedStatus.png"]];
            
        }
            break;
            
        case 0:{
            [cellView.statusImageView setImage:[UIImage imageNamed:@"RunningStatus.png"]];
            
        }
            break;
            
        case 1:{
            [cellView.statusImageView setImage:[UIImage imageNamed:@"openStatus.png"]];
            
        }
            
            break;
            
            
        default:
            break;
    }    

}

@end
