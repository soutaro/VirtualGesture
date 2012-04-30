//
//  UIView+VirtualGesture.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+VirtualLongPress.h"
#import "VGVirtualLongPressGestureRecognizer.h"
#import "UIGestureRecognizer+VirtualGesture.h"

@implementation UIView (VirtualLongPress)

- (void)recognizeLongPress {
	CGSize size = self.frame.size;
	CGPoint point = CGPointMake(size.width/2, size.height/2);
	[self recognizeLongPress:point];
}

- (void)recognizeLongPress:(CGPoint)pointInView {
	[self recognizeLongPress:1 sequenceOfTouchInView:&pointInView];
}

- (void)recognizeLongPress:(NSUInteger)points sequenceOfTouchInView:(CGPoint *)pointsInView {
	[self recognizeLongPress:1 points:1 sequenceOfTouchesInView:pointsInView];
}

- (void)recognizeLongPress:(NSUInteger)touches points:(NSUInteger)points sequenceOfTouchesInView:(CGPoint *)pointsInViews {
	NSUInteger startIndex = 0;
	NSUInteger endIndex = touches * (points-1);
	
	UILongPressGestureRecognizer* original = nil;
	for (UIGestureRecognizer* r in self.gestureRecognizers) {
		if ([r isKindOfClass:[UILongPressGestureRecognizer class]]) {
			UILongPressGestureRecognizer* o = (UILongPressGestureRecognizer*)r;
			if (o.numberOfTouchesRequired == touches) {
				original = o;
			}
		}
	}
	
	if (!original) {
		return;
	}
	
	VGVirtualLongPressGestureRecognizer* v = [VGVirtualLongPressGestureRecognizer newVirtualLongPressGestureRecognizer:original];
	
	[v setState:UIGestureRecognizerStateBegan];
	[v setTouches:touches points:pointsInViews+startIndex];
	fireGestureRecognizer(v, original);
	[v clearTouches];
	
	for (NSUInteger i = 0; i < points; i++) {
		[v setState:UIGestureRecognizerStateChanged];
		[v setTouches:touches points:pointsInViews+i*touches];
		fireGestureRecognizer(v, original);
		[v clearTouches];
	}
	
	[v setState:UIGestureRecognizerStateEnded];
	[v setTouches:touches points:pointsInViews+endIndex];
	fireGestureRecognizer(v, original);
	[v clearTouches];
}

@end
