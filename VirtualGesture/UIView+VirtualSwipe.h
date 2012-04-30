//
//  UIView+VirtualSwipe.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VirtualSwipe)

- (void)recognizeSwipe:(UISwipeGestureRecognizerDirection)direction;
- (void)recognizeSwipe:(UISwipeGestureRecognizerDirection)direction positionInView:(CGPoint)point;
- (void)recognizeSwipe:(UISwipeGestureRecognizerDirection)direction touches:(NSUInteger)touches positionInView:(CGPoint)point;

@end
