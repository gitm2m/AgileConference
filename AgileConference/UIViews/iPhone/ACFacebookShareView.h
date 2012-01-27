//
//  ACFacebookShareView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/10/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACFacebookShareViewDelegate;

@interface ACFacebookShareView : UIView

@property (strong, nonatomic) IBOutlet UITextView *fbShareTextView;
@property (strong, nonatomic) id<ACFacebookShareViewDelegate>delegate;
@property (strong, nonatomic) NSDictionary *topicDict;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)sendButtonTapped:(id)sender;


@end



@protocol ACFacebookShareViewDelegate 

@optional
-(void)cancelButtonTapped : (id)sender;
-(void)sendButtonTapped : (id)sender;

@end