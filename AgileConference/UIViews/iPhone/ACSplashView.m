//
//  ACSplashView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/6/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACSplashView.h"

@implementation ACSplashView
@synthesize logoImageView;
@synthesize logo2;

@synthesize menuTbView;
@synthesize poweredbyLable,delegate,agileIndiaLogoImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    array = [[NSArray alloc] initWithObjects:@"Proceed to application",@"About Valtech",nil];
    
        //[menuTbView reloadData];
    [self performSelector:@selector(removeViewFromSuperView) withObject:nil afterDelay:3.0];
    
}

-(void)removeViewFromSuperView{
    [self removeFromSuperview];
}

#pragma mark - UITableViewDelegate Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CategoryCell";
    
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];	
	if(cell == nil)
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        cell.backgroundColor = [UIColor clearColor];
		
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.section];
        //cell.image = [UIImage imageNamed:[array objectAtIndex:indexPath.section]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [self setAlpha:0.0];
        [UIView commitAnimations];
            // [self performSelector:@selector(removeViewFromSuperView) withObject:nil afterDelay:0.7];
    }else if(indexPath.section == 1){
        
        [delegate aboutValtechTapped:indexPath];
    
    }
    
}

@end
