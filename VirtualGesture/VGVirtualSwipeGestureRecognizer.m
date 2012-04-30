//
//  VGVirtualSwipeGestureRecognizer.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VGVirtualSwipeGestureRecognizer.h"

@implementation VGVirtualSwipeGestureRecognizer {
	UISwipeGestureRecognizer* parent_;
	CGPoint point_;
}

#pragma mark - NSObject

- (void)dealloc {

}

#pragma mark - NSProxy

- (void)forwardInvocation:(NSInvocation *)invocation {
	[invocation setTarget:self->parent_];
	[invocation invoke];
	return;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	return [self->parent_ methodSignatureForSelector:sel];
}

#pragma mark - UISwipeGestureRecognizer

- (UIGestureRecognizerState)state {
	return UIGestureRecognizerStateEnded;
}

- (CGPoint)locationInView:(UIView *)view {
	return [view convertPoint:self->point_ toView:view];
}

- (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView *)view {
	return [view convertPoint:self->point_ toView:view];
}

#pragma mark -

- (id)initWithOriginalGestureRecognizer:(UISwipeGestureRecognizer *)original {
	self->parent_ = original;
	return self;
}

- (void)setPoint:(CGPoint)point {
	self->point_ = point;
}

@end
