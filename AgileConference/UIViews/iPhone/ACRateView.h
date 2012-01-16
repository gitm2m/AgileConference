//
//  ACRateView.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 1/16/12.
//  Copyright (c) 2012 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACRateView;

@protocol ACRateViewDelegate
- (void)rateView:(ACRateView *)rateView ratingDidChange:(float)rating;
@end

@interface ACRateView : UIView {
    UIImage *_notSelectedImage;
    UIImage *_halfSelectedImage;
    UIImage *_fullSelectedImage;
    float _rating;
    BOOL _editable;
    NSMutableArray *_imageViews;
    int _maxRating;
    int _midMargin;
    int _leftMargin;
    CGSize _minImageSize;
    id <ACRateViewDelegate> _delegate;
}

@property (strong,nonatomic) UIImage *notSelectedImage;
@property (strong,nonatomic) UIImage *halfSelectedImage;
@property (strong,nonatomic) UIImage *fullSelectedImage;
@property (nonatomic) float rating;
@property  BOOL editable;
@property (nonatomic) int maxRating;
@property (strong,nonatomic) id <ACRateViewDelegate> delegate;
@property  int leftMargin;

@end