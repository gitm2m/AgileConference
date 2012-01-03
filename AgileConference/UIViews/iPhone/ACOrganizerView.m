//
//  ACOrganizerView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/3/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACOrganizerView.h"

@implementation ACOrganizerView
@synthesize organizerListTableView;

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


#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    return 4;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CategoryCell";
    
	AVEventsListTableCellView *cell = (AVEventsListTableCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];	
	if(cell == nil)
    {
		cell = [[AVEventsListTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 126;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
