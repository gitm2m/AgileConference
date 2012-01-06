//
//  ACTracksEventsListViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "ACOrganiser.h"
#import "ACAppSetting.h"

#import "ACTracksEventsListViewController.h"

@implementation ACTracksEventsListViewController
@synthesize eventsTableView,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
        NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];

        NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
        topicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];
         self.contentSizeForViewInPopover = CGSizeMake(300, 176);
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setupView];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setEventsTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - SetupViews Methods

-(void)setupView{
    
    [[eventsTableView layer] setCornerRadius:5.0f];
    [eventsTableView setBackgroundColor:[UIColor clearColor]];
    [eventsTableView setScrollEnabled:NO];
    
}

#pragma mark - ChangeCellsLables Method

-(void)changeCellsLables : (NSArray *)topicNamesArray{
    
    
    
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
        // Configure the cell.
    
    NSMutableDictionary *topicDict=[topicArray objectAtIndex:indexPath.row];
    
    ACLog(@"Topic dict:%@",topicDict);
    cell.textLabel.text = [topicDict objectForKey:kTopicTitle];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    [cell.textLabel setNumberOfLines:3];
    cell.detailTextLabel.text =[topicDict objectForKey:kTopicTime];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 49;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [delegate eventsTableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Events Methods

- (IBAction)viewMoreTopicsButtonTapped:(id)sender {

    [delegate viewMoreTopicsButtonTapped:sender inView:self];
}

-(void)reloadEventTableView{
    
    NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
    NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];
    ACLog(@"daySelected:%@>>>>>>>>",daySelected);
    ACLog(@"trackSelected:%@>>>>>>",trackSelected);
    
    //
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSIndexPath *indwxPath0 =[NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indwxPath1 =[NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *indwxPath2 =[NSIndexPath indexPathForRow:2 inSection:0];
    [array addObject:indwxPath0];
    [array addObject:indwxPath1];
    [array addObject:indwxPath2];
    //
    NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
    topicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];
    [eventsTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];

    //[eventsTableView reloadData];
    
}




@end
