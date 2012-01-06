
//
//  ACAppConstants.h
//  AgileConference
//
//  Created by Supreeth Doddabela on 12/28/11.
//  Copyright (c) 2011 Valtech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "DataCache.h"

@protocol FlowCoverViewDelegate;

/*	FlowCoverView
 *
 *		The flow cover view class; this is a drop-in view which calls into
 *	a delegate callback which controls the contents. This emulates the CoverFlow
 *	thingy from Apple.
 */

@interface FlowCoverView : UIView 
{
	// Current state support
	double offset;
	
	NSTimer *timer;
	double startTime;
	double startOff;
	double startPos;
	double startSpeed;
	double runDelta;
	BOOL touchFlag;
	CGPoint startTouch;
	
	double lastPos;
	
	// Delegate
	IBOutlet id<FlowCoverViewDelegate> delegate;
	
	DataCache *cache;
	
	// OpenGL ES support
    GLint backingWidth;
    GLint backingHeight;
    EAGLContext *context;
    GLuint viewRenderbuffer, viewFramebuffer;
    GLuint depthRenderbuffer;
    
    CGPoint startWhere; //Added after analyze
}
@property (readwrite) double startOff;
- (void)startAnimation:(double)speed;

@property (strong) id<FlowCoverViewDelegate> delegate;
@property (strong,nonatomic) DataCache *cache;

- (void)draw;					// Draw the FlowCover view with current state
-(void) flowCoverRefresh:(int) cover;
- (void)setOffSet:(int)inOffSet;
-(void) setCache:(DataCache *) inCache;

@end

/*	FlowCoverViewDelegate
 *
 *		Provides the interface for the delegate used by my flow cover. This
 *	provides a way for me to get the image, to get the total number of images,
 *	and to send a select message
 */


@protocol FlowCoverViewDelegate
- (int)flowCoverNumberImages:(FlowCoverView *)view;
- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)cover;
- (void)flowCover:(FlowCoverView *)view didSelect:(int)cover;
-(void)slideChanged:(int)index;
-(void)didSelectSlide:(NSInteger)index;
@end
