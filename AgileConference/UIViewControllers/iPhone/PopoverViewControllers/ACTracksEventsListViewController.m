//
//  ACTracksEventsListViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "ACTracksEventsListViewController.h"

@implementation ACTracksEventsListViewController
@synthesize eventsTableView,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.contentSizeForViewInPopover = CGSizeMake(300, (2*44)+30);
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
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
        // Configure the cell.
    cell.textLabel.text = @"Agile Conference";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    cell.detailTextLabel.text = @"10:30";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Events Methods

- (IBAction)viewMoreTopicsButtonTapped:(id)sender {
    
    [delegate viewMoreTopicsButtonTapped:sender inView:self];

}


@end
