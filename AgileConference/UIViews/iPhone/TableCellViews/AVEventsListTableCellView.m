//
//  AVEventsListTableCellView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 31/12/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "AVEventsListTableCellView.h"

@implementation AVEventsListTableCellView
@synthesize cellData;

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

-(void)layoutSubviews
{
	[super layoutSubviews];

	cellView.frame = CGRectMake(0, 0, 320,116);
	[cellView setNeedsLayout];
	[cellView setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

-(void)setCellData:(NSDictionary *)inCellData
{
	cellView.cellData = inCellData;
    //ACLog(@"Cell view %@ %@", cellView,cellView.cellData);
    cellView.topicLabel.text=[inCellData objectForKey:kTopicTitle];
    cellView.speakerLabel.text=[inCellData objectForKey:kTopicSpeaker];
    cellView.timeLabel.text=[inCellData objectForKey:kTopicTime];
    cellView.statusLabel.text=[inCellData objectForKey:kTopicOver];

    
}


@end
