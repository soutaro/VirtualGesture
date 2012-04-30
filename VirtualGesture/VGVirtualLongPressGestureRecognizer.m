//
//  VGVirtualLongPressGestureRecognizer.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VGVirtualLongPressGestureRecognizer.h"

@implementation VGVirtualLongPressGestureRecognizer {
	UILongPressGestureRecognizer* _parent;
	CGPoint* _points;
	NSUInteger _fingers;
	UIGestureRecognizerState _state;
}

#pragma mark - NSObject

- (void)dealloc {
	free(self->_points);
}

#pragma mark - NSProxy

- (void)forwardInvocation:(NSInvocation *)invocation {
	[invocation setTarget:self->_parent];
	[invocation invoke];
	return;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	return [self->_parent methodSignatureForSelector:sel];
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
	
	return [self->_parent.view convertPoint:point toView:view];
}

- (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView *)view {
	return [self->_parent.view convertPoint:self->_points[touchIndex] toView:view];
}

- (NSUInteger)numberOfTouches {
	return _fingers;
}

- (UIGestureRecognizerState)state {
	return self->_state;
}

#pragma mark -

+(id)newVirtualLongPressGestureRecognizer:(UILongPressGestureRecognizer *)parent {
	VGVirtualLongPressGestureRecognizer* g = [[VGVirtualLongPressGestureRecognizer alloc] initWithParent:parent];
	return g;
}

- (void)setState:(UIGestureRecognizerState)state {
	self->_state = state;
}

- (id)initWithParent:(UILongPressGestureRecognizer *)parent {
	self->_parent = parent;
	self->_points = NULL;
	self->_fingers = 0;
	
	return self;
}

- (void)setTouches:(NSUInteger)fingers points:(CGPoint *)points {
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
