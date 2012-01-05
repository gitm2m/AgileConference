//
//  ACSearchView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/30/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "ACSearchView.h"

@implementation ACSearchView
@synthesize searchResultTableView,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // [searchResultTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

-(void)layoutSubviews
{
    reloadHeaderNeeded = YES;
    accordionViewTrackArray = [[NSMutableArray alloc] initWithObjects:@"1",@"0",@"0",nil];
    eventsListTableHeaderArray = [[NSMutableArray alloc] initWithObjects:@"17th Feb",@"18th Feb",@"19th Feb",nil];
    array = [[NSArray  alloc ]initWithObjects:@"a",@"s",@"d",@"r", nil];
    eventsListTableContentsDict = [[NSDictionary alloc] initWithObjectsAndKeys:array,@"1",array,@"2",array,@"3", nil];
	
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [eventsListTableContentsDict count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    if([[accordionViewTrackArray objectAtIndex:section] isEqualToString:@"0"])
        return 0;
    else
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 126;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.0f;
}


/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"17th Feb";
    
}*/


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACEventsListHeaderView" owner:self options:nil];
        // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
    ACLog(@"nibObjects %@", nibObjects);
    
    for (id object in nibObjects) {
        if ([object isKindOfClass:[ACEventsListHeaderView class]]){
            reloadHeaderNeeded = NO;
            [[(ACEventsListHeaderView*)object eventsListHeaderButton] setTag:section];
            [(ACEventsListHeaderView*)object setDelegate:self];
            [[(ACEventsListHeaderView*)object evemtsListTableHeaderLabel] setText:[eventsListTableHeaderArray objectAtIndex:section]];
            if([[accordionViewTrackArray objectAtIndex:section] isEqualToString:@"0"]){
                [[(ACEventsListHeaderView*)object headerAccesoryImage] setImage:[UIImage imageNamed:@"A_1@2x.png"]];
                [[(ACEventsListHeaderView*)object headerAccesoryImage] setTag:1111];
            }else{
                [[(ACEventsListHeaderView*)object headerAccesoryImage] setTag:2222];
                [[(ACEventsListHeaderView*)object headerAccesoryImage] setImage:[UIImage imageNamed:@"A_5@2x.png"]];
            }
                
                 
            return  (ACEventsListHeaderView*)object;
        }
    } 
    return nil;
}

#pragma mark - ACEventsListHeaderViewDelegate Methods

- (void)eventsListHeaderButtonTapped : (id)sender inView : (ACEventsListHeaderView *)headerView{
    
       
    ACLog(@"eventsListHeaderButtonTapped %d", [sender tag]);
    if([[headerView headerAccesoryImage] tag]==1111){
        [[headerView headerAccesoryImage] setImage:[UIImage imageNamed:@"A_5@2x.png"]];
        [[headerView headerAccesoryImage] setTag:2222];
        [accordionViewTrackArray replaceObjectAtIndex:[sender tag] withObject:@"1"];
        NSIndexSet *indicies = [NSIndexSet indexSetWithIndex:[sender tag]];
        [searchResultTableView beginUpdates];
        [searchResultTableView reloadSections:indicies withRowAnimation:UITableViewRowAnimationAutomatic];
        [searchResultTableView endUpdates];
    }else if([[headerView headerAccesoryImage] tag]==2222){
        [[headerView headerAccesoryImage] setImage:[UIImage imageNamed:@"A_1@2x.png"]];
        [[headerView headerAccesoryImage] setTag:1111];
        [accordionViewTrackArray replaceObjectAtIndex:[sender tag] withObject:@"0"];
        NSIndexSet *indicies = [NSIndexSet indexSetWithIndex:[sender tag]];
        [searchResultTableView beginUpdates];
        [searchResultTableView reloadSections:indicies withRowAnimation:UITableViewRowAnimationAutomatic];
        [searchResultTableView endUpdates];
    }
    if(![accordionViewTrackArray containsObject:@"1"]){
        [searchResultTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [searchResultTableView setBackgroundColor:[UIColor clearColor]];
    }else{
        [searchResultTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [searchResultTableView setBackgroundColor:[UIColor clearColor]];
    }
        


}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}

@end
