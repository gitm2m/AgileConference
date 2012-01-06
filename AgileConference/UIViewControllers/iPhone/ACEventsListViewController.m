//
//  ACEventsListViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/3/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACEventsListViewController.h"
#import "ACAppSetting.h"
#import "ACOrganiser.h"



@implementation ACEventsListViewController
@synthesize eventsListTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
        NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];
        
        NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
        topicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setEventsListTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Setup and Modify Views Methods

-(void)delayinNavigation{
    
    ACEventDescriptionWebviewController *descriptionViewController = [[ACEventDescriptionWebviewController alloc] initWithNibName:@"ACEventDescriptionWebviewController" bundle:nil];
    descriptionViewController.delegate = self;
    
    [self.navigationController pushViewController:descriptionViewController animated:YES];
}

-(void)delayInSelectingTableCell{
    
    [[eventsListTableView delegate] tableView:eventsListTableView didSelectRowAtIndexPath:selectedEventTrackIndexPath];
}


#pragma mark UITableViewDelegateMethods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    return [topicArray count];

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

    [cell setCellData:[topicArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedEventTrackIndexPath = indexPath;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil];
    detailViewController.delegate = self;
    [detailViewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kEventTableCellHeight;
}

#pragma mark - ACEventDetailViewControllerDelegateMethods

-(void) viewEventDescriptionButtonTapped : (id)sender inView:(ACEventDetailViewController *)descriptionController{
    
    [self performSelector:@selector(delayinNavigation) withObject:nil afterDelay:.5];
 
   
}

#pragma mark - ACEventDescriptionWebviewControllerDelegate Methods
-(void)eventDescriptionViewBackButtonTapped{
    [self performSelector:@selector(delayInSelectingTableCell) withObject:nil afterDelay:.5];
}


@end
