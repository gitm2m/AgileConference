//
//  ACAppConstants.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//





#define KAppName @"AgileConference"


//
typedef enum _viewType {
    
    //controoler
    viewType_UIViewController=0,
    viewType_UITabBarController = 1,
	viewType_UINavigationController = 2,
    //view
    viewType_UILabel = 3,
    viewType_UIView = 4,
    viewType_UIScrollView = 5,
    viewType_UIImageView  = 6,
    //controlls
    viewType_UIButton = 7,
    viewType_UISegment = 8,
    viewType_UISwitch = 9,
	viewType_UISlider = 10,
    viewType_UIToolBar = 11,
    viewType_UIPageControl = 12
    //
	
} viewType;
