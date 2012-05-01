//
//  VGVirtualPinchGestureRecognizer.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VGVirtualPinchGestureRecognizer.h"

@implementation VGVirtualPinchGestureRecognizer {
	CGPoint point_;
}

@synthesize scale;
@synthesize velocity;

#pragma mark - UIPinchGestureRecognizer

- (CGPoint)locationInView:(UIView *)view {
	return [view convertPoint:self->point_ toView:view];
}

- (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView *)view {
	return [view convertPoint:self->point_ toView:view];
}

#pragma mark - 

- (void)setPoint:(CGPoint)point {
	self->point_ = point;
}

@end
