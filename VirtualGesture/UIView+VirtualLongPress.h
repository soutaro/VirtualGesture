//
//  UIView+VirtualGesture.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VirtualLongPress)

/*
 Invoke long press gesture on this view.
 Touch is done in the center of this view.
 */
- (void)recognizeLongPress;

/*
 Invokes long press gesture on this view.
 Touch is done in the |pointInView|.
 */
- (void)recognizeLongPress:(CGPoint)pointInView;

/*
 Invokes long press gesture on this view.
 Touch is done in |pointsInView|, it moves.
 */
- (void)recognizeLongPress:(NSUInteger)points sequenceOfTouchInView:(CGPoint*)pointsInView;

/*
 Invokes long press gesture on this view.
 |pointsInViews| are as follows:
   [
    pointOfFirstFinger[0],
    pointOfSecondFinger[0],
    pointOfThirdFinger[0],
    ...,
	pointOfFirstFinger[1],
	pointOfSecondFinger[1],
	pointOfThirdFinger[1],
    ...,
   ]
 */
- (void)recognizeLongPress:(NSUInteger)touches points:(NSUInteger)points sequenceOfTouchesInView:(CGPoint*)pointsInViews;

@end
