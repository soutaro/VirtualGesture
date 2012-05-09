//
//  VGVirtualLongPressGestureRecognizer.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VGVirtualLongPressGestureRecognizer.h"

@implementation VGVirtualLongPressGestureRecognizer {
	CGPoint* _points;
	NSUInteger _fingers;
	UIView* _pointView;
}

#pragma mark - NSObject

- (void)dealloc {
	free(self->_points);
}

#pragma mark - UIGestureRecognizer

- (CGPoint)locationInView:(UIView *)view {
	CGFloat x = 0;
	CGFloat y = 0;
	
	for (int i = 0; i < self->_fingers; i++) {
		x += self->_points[i].x;
		y += self->_points[i].y;
	}
	
	CGPoint point = CGPointMake(x/self->_fingers, y/self->_fingers);
	
	return [_pointView convertPoint:point toView:view];
}

- (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView *)view {
	return [_pointView convertPoint:self->_points[touchIndex] toView:view];
}

- (NSUInteger)numberOfTouches {
	return _fingers;
}

#pragma mark -

+(id)newVirtualLongPressGestureRecognizer:(UILongPressGestureRecognizer *)parent {
	VGVirtualLongPressGestureRecognizer* g = [[VGVirtualLongPressGestureRecognizer alloc] initWithParent:parent];
	return g;
}

- (void)setPointView:(UIView *)view {
	_pointView = view;
}

- (void)setTouches:(NSUInteger)fingers points:(const CGPoint *)points {
	self->_fingers = fingers;
	self->_points = malloc(sizeof(CGPoint) * fingers);
	memcpy(self->_points, points, fingers * sizeof(CGPoint));
}

- (void)clearTouches {
	self->_fingers = 0;
	free(self->_points);
	self->_points = NULL;
}

@end
