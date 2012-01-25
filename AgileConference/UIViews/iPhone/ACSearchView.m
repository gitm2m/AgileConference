//
//  ACSearchView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/30/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "ACSearchView.h"
#import "ViewUtility.h"

@implementation ACSearchView
@synthesize searchResultTableView,delegate,eventsSearchBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//
-(void)setSectionArrayForSearchView:(NSString *)sectionType{
    
    if([sectionType hasPrefix:@"Track"]){
        commonSectionArray=trackSectionArray;
        accordionViewCommonArray =accordionViewTrackArray;
        
    }else{
        commonSectionArray=daySectionArray;
        accordionViewCommonArray =accordionViewDayArray;
        //[commonTableView setFrame:CGRectMake(commonTableView.frame.origin.x, commonTableView.frame.origin.y, commonTableView.frame.size.width, 200)];
    }
    [searchResultTableView reloadData];
}

-(void)searchCatalogAndShowResult{
    
        commonSectionArray=[[NSMutableArray alloc] init];
        accordionViewCommonArray =accordionViewDayArray;
        NSString *alertMessage=@"";
        //
        if([sortBy hasPrefix:@"Topic"]){
        searchDataDictionary=[[ACOrganiser getOrganiser] searchCatalogWithSearchKey:@"Topic_Title"
                                                                     andSearchValue:searchContent];
            alertMessage=@"No topic records found!";

        }else{
        searchDataDictionary=[[ACOrganiser getOrganiser] searchCatalogWithSearchKey:@"Topic_Speaker"
                                                                         andSearchValue:searchContent];
            alertMessage=@"No speaker records found!";

        }
        if([searchDataDictionary count]==0){
            commonSectionArray=nil;
            [ViewUtility showAlertViewWithMessage:alertMessage];
        }else{
            [commonSectionArray addObjectsFromArray:[CommonUtility getSortedArrayByAlphabet:[searchDataDictionary allKeys]]];
        }
        [searchResultTableView reloadData];
}
//
-(void)layoutSubviews
{
    reloadHeaderNeeded = YES;
    accordionViewDayArray = [[NSMutableArray alloc] initWithObjects:@"1",@"0",@"0",nil];
    accordionViewTrackArray = [[NSMutableArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    //
    
    daySectionArray = [[NSMutableArray alloc] initWithObjects:@"Day1",@"Day2",@"Day3",nil];
    trackSectionArray= [[NSMutableArray alloc] initWithObjects:@"Track1",@"Track2",@"Track3",@"Track4",@"Track5",@"Track6",@"Track7",nil];
    //
    NSMutableDictionary *catalogeDict=[[ACOrganiser getOrganiser] getCatalogDict];
    searchDataDictionary=[[NSMutableDictionary alloc] initWithDictionary:catalogeDict];
    sortBy=@"Topic";
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [commonSectionArray count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    NSString *keyString=[commonSectionArray objectAtIndex:section];
    NSMutableDictionary *trackDict=[searchDataDictionary objectForKey:keyString];
    commonRowArray=[[NSMutableArray alloc] init];
    NSArray *allKeys=[trackDict allKeys];
    for (NSString *key in allKeys) {
        NSMutableArray *array1=[trackDict objectForKey:key];
        [commonRowArray addObjectsFromArray:array1];
    }
    if([[accordionViewCommonArray objectAtIndex:section] isEqualToString:@"0"]){
        commonRowArray=nil;
    }

    return [commonRowArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CategoryCell";
    
	AVEventsListTableCellView *cell = (AVEventsListTableCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];	
    
    
    NSString *keyString=[commonSectionArray objectAtIndex:indexPath.section];
    NSMutableDictionary *trackDict=[searchDataDictionary objectForKey:keyString];
    NSMutableArray *commonRowArray1=[[NSMutableArray alloc] init];
    NSArray *allKeys=[trackDict allKeys];
    for (NSString *key in allKeys) {
        NSMutableArray *array1=[trackDict objectForKey:key];
        [commonRowArray1 addObjectsFromArray:array1];
    }
    
    NSMutableDictionary *eventDict=[commonRowArray1 objectAtIndex:indexPath.row];
    
        //if(cell == nil)
        //{
        if([[eventDict valueForKey:kTopicType] isEqualToString:@"BUSINESS"])
            cell = [[AVEventsListTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"BUSINESS"];
        else if([[eventDict valueForKey:kTopicType] isEqualToString:@"BREAK"])
            cell = [[AVEventsListTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"BREAK"];
        else if([[eventDict valueForKey:kTopicType] isEqualToString:@"NORMAL"])
            cell = [[AVEventsListTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"NORMAL"];

            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
     cell.rowNumber = indexPath.row;
        //}

    [cell setCellData:eventDict];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *keyString=[commonSectionArray objectAtIndex:indexPath.section];
    NSMutableDictionary *trackDict=[searchDataDictionary objectForKey:keyString];
    NSMutableArray *commonRowArray1=[[NSMutableArray alloc] init];
    NSArray *allKeys=[trackDict allKeys];
    for (NSString *key in allKeys) {
        NSMutableArray *array1=[trackDict objectForKey:key];
        [commonRowArray1 addObjectsFromArray:array1];
    }
    
    NSMutableDictionary *eventDict=[commonRowArray1 objectAtIndex:indexPath.row];

    
    [delegate tableView:tableView didSelectRowAtIndexPath:indexPath withDict:eventDict];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *keyString=[commonSectionArray objectAtIndex:indexPath.section];
    NSMutableDictionary *trackDict=[searchDataDictionary objectForKey:keyString];
    NSMutableArray *commonRowArray1=[[NSMutableArray alloc] init];
    NSArray *allKeys=[trackDict allKeys];
    for (NSString *key in allKeys) {
        NSMutableArray *array1=[trackDict objectForKey:key];
        [commonRowArray1 addObjectsFromArray:array1];
    }

    
    NSMutableDictionary *eventDict=[commonRowArray1 objectAtIndex:indexPath.row];
    
    if([[eventDict valueForKey:kTopicType] isEqualToString:@"BUSINESS"])
          return kEventTableCellHeight;
    else 
        return 24.0f;
      
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.0f;
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
            [(ACEventsListHeaderView*)object setIndexOfSection:section];
            [[(ACEventsListHeaderView*)object evemtsListTableHeaderLabel] setText:[commonSectionArray objectAtIndex:section]];
            //
            if([[accordionViewCommonArray objectAtIndex:section] isEqualToString:@"0"]){
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
    
       
    ACLog(@"eventsListHeaderButtonTapped %d",headerView);
    if([[headerView headerAccesoryImage] tag]==1111){
        
        [[headerView headerAccesoryImage] setImage:[UIImage imageNamed:@"A_5@2x.png"]];
        [[headerView headerAccesoryImage] setTag:2222];
        [accordionViewCommonArray replaceObjectAtIndex:[sender tag] withObject:@"1"];
        NSIndexSet *indicies = [NSIndexSet indexSetWithIndex:[sender tag]];
        
        [searchResultTableView beginUpdates];
        [searchResultTableView reloadSections:indicies withRowAnimation:UITableViewRowAnimationAutomatic];
        [searchResultTableView endUpdates];
    }else if([[headerView headerAccesoryImage] tag]==2222){
        
        [[headerView headerAccesoryImage] setImage:[UIImage imageNamed:@"A_1@2x.png"]];
        [[headerView headerAccesoryImage] setTag:1111];
        [accordionViewCommonArray replaceObjectAtIndex:[sender tag] withObject:@"0"];
        NSIndexSet *indicies = [NSIndexSet indexSetWithIndex:[sender tag]];
        [searchResultTableView beginUpdates];
        [searchResultTableView reloadSections:indicies withRowAnimation:UITableViewRowAnimationAutomatic];
        [searchResultTableView endUpdates];
    }

}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    searchContent=[[searchBar text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self searchCatalogAndShowResult];    
    [searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    
    ACLog(@">>>>>>%i", selectedScope);
    searchContent=[searchBar text];
    switch (selectedScope) {
        case 0:{
            
            sortBy=@"Topic";
        }
            break;
        case 1:{
            sortBy=@"Speaker";
        }

            break;
        default:
            break;
    }
    
    ///
    [searchBar resignFirstResponder];
    
    if([searchBar.text length]>0){
        
        [self searchCatalogAndShowResult];    
        
    }else{
        //[searchBar setSelectedScopeButtonIndex:];
        [ViewUtility showAlertViewWithMessage:@"Please enter the Topic/Speaker in search field"];
        
    }

    
}

-(void)cleanSearchView{
    commonSectionArray=nil;
    [searchResultTableView reloadData];
}

@end
