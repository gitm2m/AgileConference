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
    self.title = [NSString stringWithFormat:@"%@,%@",[[topicArray objectAtIndex:0]valueForKey:kTopicDate],[[topicArray objectAtIndex:0]valueForKey:kTopicTrack]];
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

- (void)viewDidAppear:(BOOL)animated
{
    [eventsListTableView reloadData];
    [super viewDidAppear:animated];
}

-(void)setupInitialView{
    
    
    UIImageView *bgHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0.0,0, 320.0, 44.0)];
    [bgHeader setBackgroundColor:[UIColor clearColor]];
    [bgHeader setImage:[UIImage imageNamed:@"titleRow.png"]];
    [[self view] addSubview:bgHeader];
        //[bgHeader release];
    
    leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setBackgroundImage:[UIImage imageNamed:@"Action.png"] forState:UIControlStateNormal];
    leftBarButton.frame = CGRectMake(15, 10, 25, 24); 
    [leftBarButton addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBarButton];
    
    rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setBackgroundImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    rightBarButton.frame = CGRectMake(278, 10, 25, 24) ; 
    [rightBarButton setHidden:YES];
    [rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBarButton];
    
    
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 5, 300, 35)];
    [headerLabel setFont:[CommonUtility fontSegoiBold:17]];
    [headerLabel setText:[NSString stringWithFormat:@"%@,%@",[[topicArray objectAtIndex:0]valueForKey:kTopicDay],[[topicArray objectAtIndex:0]valueForKey:kTopicTrack]]];
    [headerLabel setTextAlignment:UITextAlignmentCenter];
    [headerLabel setTextColor:[UIColor darkGrayColor]];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headerLabel];

    
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
        //  if(cell == nil){
        if([[[topicArray objectAtIndex:indexPath.row] valueForKey:kTopicType] isEqualToString:@"BUSINESS"]){
            cell = [[AVEventsListTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"BUSINESS"];}
        
        else if([[[topicArray objectAtIndex:indexPath.row] valueForKey:kTopicType] isEqualToString:@"BREAK"]){
            cell = [[AVEventsListTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"BREAK"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if([[[topicArray objectAtIndex:indexPath.row] valueForKey:kTopicType] isEqualToString:@"NORMAL"]){
            cell = [[AVEventsListTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"NORMAL"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
      cell.rowNumber = indexPath.row;	  
            //}
    
    [cell setCellData:[topicArray objectAtIndex:indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedEventTrackIndexPath = indexPath;
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if([[[topicArray objectAtIndex:indexPath.row] valueForKey:kTopicType] isEqualToString:@"BUSINESS"]){
        
        ACEventDetailViewController *detailViewController = [[ACEventDetailViewController alloc] initWithNibName:@"ACEventDetailViewController" bundle:nil andTopicDict:[topicArray objectAtIndex:indexPath.row]];
        detailViewController.delegate = self;
        [detailViewController setIsNavigatedFromOrganizerView:NO];
        [detailViewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        
        [self.navigationController pushViewController:detailViewController animated:YES];

        
    }
    
       
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[[topicArray objectAtIndex:indexPath.row] valueForKey:kTopicType] isEqualToString:@"BUSINESS"])
        return kEventTableCellHeight;
    else if([[[topicArray objectAtIndex:indexPath.row] valueForKey:kTopicType] isEqualToString:@"BREAK"])
        return 24;
    else if([[[topicArray objectAtIndex:indexPath.row] valueForKey:kTopicType] isEqualToString:@"NORMAL"])
        return 24;
    else
        return 24;
}

#pragma mark - ACEventDetailViewControllerDelegateMethods

-(void) viewEventDescriptionButtonTapped : (id)sender inView:(ACEventDetailViewController *)descriptionController{
    
    [self performSelector:@selector(delayinNavigation) withObject:nil afterDelay:.5];
 
   
}

#pragma mark - ACEventDescriptionWebviewControllerDelegate Methods
-(void)eventDescriptionViewBackButtonTapped{
    [self performSelector:@selector(delayInSelectingTableCell) withObject:nil afterDelay:.5];
}

#pragma mark - Events Methods

-(void)leftBarButtonClicked : (id)sender{
        
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBarButtonClicked : (id)sender{
    
    
}


@end
