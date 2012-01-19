//
//  ACMatrixCatalogView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/17/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACMatrixCatalogView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ACMatrixCatalogView
@synthesize matrixTableView;

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
    
    [matrixTableView.layer setCornerRadius:9.0f];
    
    [matrixTableView.layer setBorderColor:[UIColor blackColor].CGColor];
    [matrixTableView.layer setBorderWidth:1.0f];
    
    [self.layer setCornerRadius:9.0f];
    
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.layer setBorderWidth:1.0f];
    // Drawing code
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    
    
    return 8;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CategoryCell";
    
	ACMatrixTableCellView *cell = (ACMatrixTableCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];	
	if(cell == nil)
    {
        if(indexPath.row==0)
            cell = [[ACMatrixTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"YES"];
        else
            cell = [[ACMatrixTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:@"NO"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
    
    //[cell setCellData:[eventArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   if(indexPath.row==0) 
       return 35;
   else
       return 47;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}

@end
