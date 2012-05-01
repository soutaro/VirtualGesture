//
//  UIView+VirtualPinch.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+VirtualPinch.h"
#import "VGVirtualPinchGestureRecognizer.h"
#import "GestureRecognizerUtil.h"

@implementation UIView (VirtualPinch)

- (void)recognizePinch:(CGFloat)scale {
	[self recognizePinch:scale duration:1];
}

- (void)recognizePinch:(CGFloat)scale duration:(NSTimeInterval)duration {
	CGSize size = self.bounds.size;
	[self recognizePinch:scale duration:duration point:CGPointMake(size.width/2, size.height/2)];
}

- (void)recognizePinch:(CGFloat)scale duration:(NSTimeInterval)duration point:(CGPoint)point {
	[self recognizePinch:scale duration:duration point:point touches:2];
}

- (void)recognizePinch:(CGFloat)scale duration:(NSTimeInterval)duration point:(CGPoint)point touches:(NSUInteger)touches {
	UIPinchGestureRecognizer* original = nil;
	
	for (UIPinchGestureRecognizer* r in self.gestureRecognizers) {
		if ([r isKindOfClass:[UIPinchGestureRecognizer class]]) {
			UIPinchGestureRecognizer* a = (UIPinchGestureRecognizer*)r;
			original = a;
		}
	}
	
	if (!original) {
		return;
	}
	
	if (duration < 0.1) {
		duration = 0.1;
	}
	
	CGFloat velocity = (scale - 1) / duration;
	CGFloat timeSteps = 0.1;
	CGFloat scaleSteps = (scale - 1) / (duration/timeSteps);
	
	VGVirtualPinchGestureRecognizer* v = [[VGVirtualPinchGestureRecognizer alloc] initWithParent:original];
	[v setPoint:point];
	v.numberOfTouches = touches;
	v.velocity = velocity;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		v.scale = 1;
		v.state = UIGestureRecognizerStateBegan;
		fireGestureRecognizer(v, v.parent);
	});
	
	for (int i = 0; i < duration/timeSteps; i++) {
		CGFloat scale = 1 + scaleSteps*i;
		
		double delayInSeconds = timeSteps*i;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			v.state = UIGestureRecognizerStateChanged;
			v.scale = scale;
			fireGestureRecognizer(v, v.parent);
		});
	}
	
	double delayInSeconds = duration;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		v.state = UIGestureRecognizerStateEnded;
		v.scale = scale;
		fireGestureRecognizer(v, v.parent);
	});
}

@end
