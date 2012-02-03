//
//  ACTracksEventsListViewController.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import "ACOrganiser.h"
#import "ACAppSetting.h"
#import "ViewUtility.h"

#import "ACTracksEventsListViewController.h"

@implementation ACTracksEventsListViewController
@synthesize eventsTableView,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(notifyToReloadEvent) 
                                                     name:@"UPDATE_UPCOMING_EVENTS" 
                                                   object:nil];
        
        isBottomAnimation=NO;
        NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
        //NSLog(@">>daySelected>>>%@",daySelected);
        
        NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];
        // NSLog(@">>trackSelected>>>%@",trackSelected);
        
        
        NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
        NSMutableArray *wholeTopicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];
        topicArray=[[NSMutableArray alloc] init];
        //
        for (NSMutableDictionary *topicDict in wholeTopicArray){
            
            NSString *timeAMPM=[CommonUtility convertDateToAMPMFormat:[topicDict objectForKey:kTopicTime]];
            switch ([[ACOrganiser getOrganiser] updateStatusOfEventOnTime:timeAMPM andDate:[topicDict objectForKey:kTopicDate]]) {
                case -1:{
                    // [cellView.statusImageView setImage:[UIImage imageNamed:@"ClosedStatus.png"]];
                   // NSLog(@"-1111111111111111");
                    //[topicArray addObject:topicDict];
                    
                    
                }
                    break;
                    
                case 0:{
                    [topicArray addObject:topicDict];
                    
                }
                    break;
                    
                case 1:{
                    [topicArray addObject:topicDict];
                    
                }
                    
                    break;
                    
                    
                default:
                    break;
            }    
            
            //
            if([topicArray count]>=3){
                break;
            }
        } 
        
        //
        if([topicArray count]<3){
            for(int index=0; index<3;index++){
                NSMutableDictionary *blankDict=[[NSMutableDictionary alloc] init];
                [blankDict setObject:@"BLANK" forKey:kTopicType];
                [topicArray addObject:blankDict];
                if([topicArray count]==3){
                    break;  
                }
            }
        }
        
        //
        [CommonUtility cancelUpdateNotificationOfEvent:[topicArray objectAtIndex:0]];
        [CommonUtility schedulUpdateNotificationOfEvent:[topicArray objectAtIndex:0]];
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
    viewMoreButton = nil;
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
    
    [viewMoreButton.titleLabel  setFont:[CommonUtility fontSegoiBold:15]]; 
    [[eventsTableView layer] setCornerRadius:5.0f];
    [eventsTableView setBackgroundColor:[UIColor clearColor]];
    [eventsTableView setScrollEnabled:NO];
    
}

#pragma mark - ChangeCellsLables Method

-(void)changeCellsLables : (NSArray *)topicNamesArray{
    
    
    
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    return [topicArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    ACUpcomingTableCellView *cell = (ACUpcomingTableCellView*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[ACUpcomingTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    NSMutableDictionary *topicDict=[topicArray objectAtIndex:indexPath.row];
    
    if ([[topicDict valueForKey:kTopicType] isEqualToString:@"BUSINESS"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if([[topicDict valueForKey:kTopicType] isEqualToString:@"NORMAL"]){
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if([[topicDict valueForKey:kTopicType] isEqualToString:@"BREAK"]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        
    } else if([[topicDict valueForKey:kTopicType] isEqualToString:@"BLANK"]){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

        [cell setCellData:[topicArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 49;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self updateContentArray];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *topicDict=[topicArray objectAtIndex:indexPath.row];
    if([[topicDict objectForKey:kTopicType] isEqualToString:@"BLANK"]){
        return;
    }
    //
    [[ACAppSetting getAppSession] setUpCommingEventDict:topicDict];
    //
    if (![[topicDict valueForKey:kTopicType] isEqualToString:@"BUSINESS"]){
        
        [ViewUtility showAlertViewWithMessage:[NSString stringWithFormat:@"%@ \n %@",[topicDict objectForKey:kTopicTitle],[topicDict objectForKey:kTopicTime]]];
        return;
    }
    
    
    [delegate eventsTableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Events Methods

- (IBAction)viewMoreTopicsButtonTapped:(id)sender {
    
    [delegate viewMoreTopicsButtonTapped:sender inView:self];
}

-(void)reloadEventTableViewWithAnimation:(BOOL)animated{
    
    isBottomAnimation=animated;
    NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
    NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];
    ACLog(@"daySelected:%@>>>>>>>>",daySelected);
    ACLog(@"trackSelected:%@>>>>>>",trackSelected);
    //
    NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
    NSMutableArray *wholeTopicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];
    [topicArray removeAllObjects];
    //
    for (NSMutableDictionary *topicDict in wholeTopicArray){
        
        NSString *timeAMPM=[CommonUtility convertDateToAMPMFormat:[topicDict objectForKey:kTopicTime]];
        switch ([[ACOrganiser getOrganiser] updateStatusOfEventOnTime:timeAMPM andDate:[topicDict objectForKey:kTopicDate]]) {
            case -1:{
                //[topicArray addObject:topicDict];
                
            }
                break;
                
            case 0:{
                [topicArray addObject:topicDict];
                
            }
                break;
                
            case 1:{
                [topicArray addObject:topicDict];
                
            }
                
                break;
                
                
            default:
                break;
        }    
        //
        if([topicArray count]>=3){
            break;
        }
    }  
    //
    NSMutableArray *array=[[NSMutableArray alloc] init];
    //
    NSIndexPath *indwxPath0 =[NSIndexPath indexPathForRow:0 inSection:0];
    [array addObject:indwxPath0];
    //
    NSIndexPath *indwxPath1 =[NSIndexPath indexPathForRow:1 inSection:0];
    [array addObject:indwxPath1];
    //
    NSIndexPath *indwxPath2 =[NSIndexPath indexPathForRow:2 inSection:0];
    [array addObject:indwxPath2];
    //
    if([topicArray count]<3){
        for(int index=0; index<3;index++){
            NSMutableDictionary *blankDict=[[NSMutableDictionary alloc] init];
            [blankDict setObject:@"BLANK" forKey:kTopicType];
            [topicArray addObject:blankDict];
            if([topicArray count]==3){
                break;  
            }
        }
    }
    //
    
    if(isBottomAnimation){
        [eventsTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationBottom];
        
    }else{
        [eventsTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
        
    }
    
    [CommonUtility cancelUpdateNotificationOfEvent:[topicArray objectAtIndex:0]];
    [CommonUtility schedulUpdateNotificationOfEvent:[topicArray objectAtIndex:0]];
    
}

//
-(void)notifyToReloadEvent{
    
    ACLog(@"notified:%@>>>>>>>>");

    NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
    NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];
    ACLog(@"daySelected:%@>>>>>>>>",daySelected);
    ACLog(@"trackSelected:%@>>>>>>",trackSelected);
    //
    NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
    NSMutableArray *wholeTopicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];
    [topicArray removeAllObjects];
    //
    for (NSMutableDictionary *topicDict in wholeTopicArray){
        
        NSString *timeAMPM=[CommonUtility convertDateToAMPMFormat:[topicDict objectForKey:kTopicTime]];
        switch ([[ACOrganiser getOrganiser] updateStatusOfEventOnTime:timeAMPM 
                                                              andDate:[topicDict objectForKey:kTopicDate]]) {
            case -1:{
                
            }
                break;
                
            case 0:{
                [topicArray addObject:topicDict];
                
            }
                break;
                
            case 1:{
                [topicArray addObject:topicDict];
                
            }
                
                break;
                
                
            default:
                break;
        }    
        //
        if([topicArray count]>=3){
            break;
        }
    }  
    //
    NSMutableArray *array=[[NSMutableArray alloc] init];
    //
    NSIndexPath *indwxPath0 =[NSIndexPath indexPathForRow:0 inSection:0];
    [array addObject:indwxPath0];
    //
    NSIndexPath *indwxPath1 =[NSIndexPath indexPathForRow:1 inSection:0];
    [array addObject:indwxPath1];
    //
    NSIndexPath *indwxPath2 =[NSIndexPath indexPathForRow:2 inSection:0];
    [array addObject:indwxPath2];
    //
    if([topicArray count]<3){
        for(int index=0; index<3;index++){
            NSMutableDictionary *blankDict=[[NSMutableDictionary alloc] init];
            [blankDict setObject:@"BLANK" forKey:kTopicType];
            [topicArray addObject:blankDict];
            if([topicArray count]==3){
                break;  
            }
        }
    }
    //
    
    [eventsTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
    [CommonUtility cancelUpdateNotificationOfEvent:[topicArray objectAtIndex:0]];
    [CommonUtility schedulUpdateNotificationOfEvent:[topicArray objectAtIndex:0]];
    
}
//
-(void)updateContentArray{
    
    ACLog(@"notified:>>>>>>>>");
    NSString* daySelected=[[ACAppSetting getAppSession] daySelected];
    NSString* trackSelected=[[ACAppSetting getAppSession] trackSelected];
    ACLog(@"daySelected:%@>>>>>>>>",daySelected);
    ACLog(@"trackSelected:%@>>>>>>",trackSelected);
    //
    NSMutableDictionary *catalogDict=[[ACOrganiser getOrganiser] getCatalogDict];
    NSMutableArray *wholeTopicArray=[[catalogDict objectForKey:daySelected] objectForKey:trackSelected];
    [topicArray removeAllObjects];
    //
    for (NSMutableDictionary *topicDict in wholeTopicArray){
        
        NSString *timeAMPM=[CommonUtility convertDateToAMPMFormat:[topicDict objectForKey:kTopicTime]];
        switch ([[ACOrganiser getOrganiser] updateStatusOfEventOnTime:timeAMPM 
                                                              andDate:[topicDict objectForKey:kTopicDate]]) {
            case -1:{
                
            }
                break;
                
            case 0:{
                [topicArray addObject:topicDict];
                
            }
                break;
                
            case 1:{
                [topicArray addObject:topicDict];
                
            }
                
                break;
                
                
            default:
                break;
        }    
        //
        if([topicArray count]>=3){
            break;
        }
    }  
    //
    NSMutableArray *array=[[NSMutableArray alloc] init];
    //
    NSIndexPath *indwxPath0 =[NSIndexPath indexPathForRow:0 inSection:0];
    [array addObject:indwxPath0];
    //
    NSIndexPath *indwxPath1 =[NSIndexPath indexPathForRow:1 inSection:0];
    [array addObject:indwxPath1];
    //
    NSIndexPath *indwxPath2 =[NSIndexPath indexPathForRow:2 inSection:0];
    [array addObject:indwxPath2];
    //
    if([topicArray count]<3){
        for(int index=0; index<3;index++){
            NSMutableDictionary *blankDict=[[NSMutableDictionary alloc] init];
            [blankDict setObject:@"BLANK" forKey:kTopicType];
            [topicArray addObject:blankDict];
            if([topicArray count]==3){
                break;  
            }
        }
    }
    //
    
}





@end
