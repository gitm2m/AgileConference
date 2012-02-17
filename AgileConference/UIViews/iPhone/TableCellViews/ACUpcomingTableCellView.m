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
    
    
    if([[cellView.topicLabel.text uppercaseString] isEqualToString:@"LUNCH"]){    

        
        NSString *topicDay=[inCellData objectForKey:kTopicDate];
        NSString *topicTime=[inCellData objectForKey:kTopicTime];//
        
        NSArray  *topicTimeArray=[topicTime componentsSeparatedByString:@", "];
        NSString *topicTimeFirstObject=[topicTimeArray objectAtIndex:0];
        NSString  *startTime=[[topicTimeFirstObject componentsSeparatedByString:@"-"] objectAtIndex:0];
        //
        
        NSInteger startprefix=0;
        NSArray *startTimeArray=[startTime componentsSeparatedByString:@":"];
        
        if([[startTimeArray objectAtIndex:0] intValue]>=1
           && [[startTimeArray objectAtIndex:0] intValue]<=8){
            
            startprefix=12+[[startTimeArray objectAtIndex:0] intValue];
            NSString *timeSuffix=[startTimeArray objectAtIndex:1];
            startTime=[NSString stringWithFormat:@"%i:%@",startprefix, timeSuffix];
            
        }
        NSString *stringDate=[NSString stringWithFormat:@"%@, %@",topicDay, startTime];
        NSDate *eventStartDate=[CommonUtility convertStringToDate:stringDate format:@"dd-MM-yyyy, HH:mm"]; 
        //
        
        NSString *topicTimeFirstObject1=[topicTimeArray lastObject];
        NSString  *startTime1=[[topicTimeFirstObject1 componentsSeparatedByString:@"-"] objectAtIndex:1];
        //
        
        NSInteger startprefix1=0;
        NSArray *startTimeArray1=[startTime1 componentsSeparatedByString:@":"];
        
        if([[startTimeArray1 objectAtIndex:0] intValue]>=1
           && [[startTimeArray1 objectAtIndex:0] intValue]<=8){
            
            startprefix1=12+[[startTimeArray1 objectAtIndex:0] intValue];
            NSString *timeSuffix1=[startTimeArray1 objectAtIndex:1];
            startTime1=[NSString stringWithFormat:@"%i:%@",startprefix1, timeSuffix1];
            
        }
        NSString *stringDate1=[NSString stringWithFormat:@"%@, %@",topicDay, startTime1];
        NSDate *evenEendDate=[CommonUtility convertStringToDate:stringDate1 format:@"dd-MM-yyyy, HH:mm"]; 
        
        if([[NSDate date] isEqualToDate:eventStartDate] || [[NSDate date] laterDate:eventStartDate]){
            
            if( [[NSDate date] earlierDate:evenEendDate]){
                
                [cellView.statusImageView setImage:[UIImage imageNamed:@"RunningStatus.png"]];

            }

            
        }



}
        


}

@end
