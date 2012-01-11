//
//  ACSplashView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/6/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACSplashViewDelegate;

@interface ACSplashView : UIView{
    
    NSArray *array ;
    
}

-(void)removeViewFromSuperView;

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UIImageView *logo2;
@property (strong, nonatomic) IBOutlet UITableView *menuTbView;
@property (strong, nonatomic) IBOutlet UILabel *poweredbyLable;
@property (strong, nonatomic) id<ACSplashViewDelegate>delegate;

@end


@protocol ACSplashViewDelegate 

@optional
-(void) aboutValtechTapped : (NSIndexPath *)indexPath;

@end