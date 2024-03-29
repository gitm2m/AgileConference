//
//  ACAppConstants.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//





#define KAppName @"Agile 2012"
#define kEventTableCellHeight 60


//Social Network Keys
#define kFaceBookAPIKey @"214952098593793"

//Add Remove Favourites Lable Constants
#define kAddtoFavs @"Add to favourites"
#define kRemoveFromFavs @"Remove favourite"

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

//plist cataloge key

#define kTopicType              @"Topic_Type"
#define kTopicTitle             @"Topic_Title"
#define kTopicSummary           @"Topic_Summary"
#define kTopicSpeaker           @"Topic_Speaker"
#define kTopicSpeakerSummary    @"Speaker_Summary"
#define kTopicTime              @"Topic_Time"
#define kTopicTrack             @"Topic_Track"
#define kTopicDate              @"Topic_Date"
#define kTopicDay               @"Topic_Day"
#define kTopicFavorite          @"Topic_Favorite"
#define kTopicParticipated      @"Topic_Participated"
#define kTopicMissed            @"Topic_Missed"
#define kTopicStatus            @"Topic_Status"
#define kTopicSpeakerLink       @"SpeakerLink"
#define kTopicLink              @"Topic_Link"




#define kRemindMeNotificationDataKey @"kRemindMeNotificationDataKey"

#define kShareMessage @"Check out %@ - Posted via Valtech's Agile2012 iPhone app."





