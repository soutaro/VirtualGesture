//
//  UIView+VirtualSwipe.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+VirtualSwipe.h"
#import "GestureRecognizerUtil.h"
#import "VGVirtualSwipeGestureRecognizer.h"

@implementation UIView (VirtualSwipe)

- (void)recognizeSwipe:(UISwipeGestureRecognizerDirection)direction {
	CGSize size = self.bounds.size;
	[self recognizeSwipe:direction positionInView:CGPointMake(size.width/2, size.height/2)];
}

- (void)recognizeSwipe:(UISwipeGestureRecognizerDirection)direction positionInView:(CGPoint)point {
	[self recognizeSwipe:direction touches:1 positionInView:point];
}

- (void)recognizeSwipe:(UISwipeGestureRecognizerDirection)direction touches:(NSUInteger)touches positionInView:(CGPoint)point {
	UISwipeGestureRecognizer* original = nil;

	for (UIGestureRecognizer* r in self.gestureRecognizers) {
		if ([r isKindOfClass:[UISwipeGestureRecognizer class]]) {
			UISwipeGestureRecognizer* a = (UISwipeGestureRecognizer*)r;
			if (a.numberOfTouchesRequired == touches && (a.direction & direction) > 0) {
				original = a;
			}
		}
	}
	
	if (!original) {
		return;
	}
	
	VGVirtualSwipeGestureRecognizer* v = [[VGVirtualSwipeGestureRecognizer alloc] initWithParent:original];
	v.numberOfTouches = touches;
	[v setPoint:point];
	fireGestureRecognizer(v, original);
}

@end
