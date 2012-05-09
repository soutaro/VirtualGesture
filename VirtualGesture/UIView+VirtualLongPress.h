//
//  UIView+VirtualGesture.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VirtualLongPress)

/**
 Invoke long press gesture on this view.
 Touch is done in the center of this view.
 */
- (void)recognizeLongPress;

/**
 |points| is array of x-y pair which represents point in application's coordinate.
 If size of |points| is only one, there is no pan.
 If size of |points| is two, pan on a line will be recognized (in 20 moves per second).
 If size of |points| is three, pan on a quadratic bezier curve will be recognized.
 If size of |points| is four, pan on a cubic bezier curve will be recognized.
 */
- (void)recognizeLongPressInApp:(NSArray*)points duration:(NSTimeInterval)duration;

@end
