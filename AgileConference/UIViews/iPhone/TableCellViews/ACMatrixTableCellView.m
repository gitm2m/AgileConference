//
//  ACMatrixTableCellView.m
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/17/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import "ACMatrixTableCellView.h"

@implementation ACMatrixTableCellView
@synthesize cellData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACMatrixCellView" owner:self options:nil];
            // assuming the view is the only top-level object in the nib file (besides File's Owner and First Responder)
        for (id object in nibObjects) {
            if ([object isKindOfClass:[ACMatrixCellView class]])
                cellView = (ACMatrixCellView*)object;
        }   
		[self.contentView addSubview: cellView];

    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)isHeader{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
        isHeaderCell = isHeader;
        
        NSArray *nibObjects = nil;
        
        if ([isHeader isEqualToString:@"YES"]) {
            nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACMatrixHeaderCellView" owner:self options:nil];
        }else if ([isHeader isEqualToString:@"NO"]){
            nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ACMatrixCellView" owner:self options:nil];
        }
        
        
        for (id object in nibObjects) {
            if ([object isKindOfClass:[ACMatrixCellView class]])
                cellView = (ACMatrixCellView*)object;
        }   

		[self.contentView addSubview: cellView];

        
    }
    return self;

    
}


-(void)layoutSubviews
{
	[super layoutSubviews];
    
    cellView.frame = CGRectMake(0, 0, 320,47);
    
    if ([isHeaderCell isEqualToString:@"YES"])
        cellView.frame = CGRectMake(0, 0, 320,35);
    
	[cellView setNeedsLayout];
	[cellView setNeedsDisplay];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSMutableDictionary *)inCellData
{

}
@end
