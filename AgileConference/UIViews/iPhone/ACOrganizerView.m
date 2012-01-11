//
//  ACOrganizerView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/3/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACOrganizerView.h"

@implementation ACOrganizerView
@synthesize organizerListTableView,delegate;

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


-(void)layoutSubviews{
    NSMutableDictionary *favDict=[[ACOrganiser getOrganiser] getCatalogListOfType:kTopicFavorite
                                                            andCatalogTypeContent:@"YES"];
    eventArray=[[ACOrganiser getOrganiser] getArrayOfDict:favDict];

    
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    

    return [eventArray count];

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
    [cell setCellData:[eventArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kEventTableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [delegate organizerListTableView:tableView didSelectRowAtIndexPath:indexPath withDict:[eventArray objectAtIndex:indexPath.row]];
}


#pragma mark - Events Methods

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:{
            
            NSMutableDictionary *favDict=[[ACOrganiser getOrganiser] getCatalogListOfType:kTopicFavorite
                                                                    andCatalogTypeContent:@"YES"];
            eventArray=[[ACOrganiser getOrganiser] getArrayOfDict:favDict];

        }
            break;
            
        case 1:{
            
            NSMutableDictionary *favDict=[[ACOrganiser getOrganiser] getCatalogListOfType:kTopicParticipated
                                                                    andCatalogTypeContent:@"YES"];
            eventArray=[[ACOrganiser getOrganiser] getArrayOfDict:favDict];

        }
            break;
            
        case 2:{
            
            NSMutableDictionary *favDict=[[ACOrganiser getOrganiser] getCatalogListOfType:kTopicMissed
                                                                    andCatalogTypeContent:@"YES"];
            eventArray=[[ACOrganiser getOrganiser] getArrayOfDict:favDict];

            
        }
            break;

            
        default:
            break;
    }
    
    [organizerListTableView reloadData];
    ACLog(@">>>>>>>>>>>>>>>>segment value changed");
    
    
}
@end
