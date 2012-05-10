//
//  UIView+VirtualPan.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+VirtualPan.h"
#import "VGVirtualPanGestureRecognizer.h"
#import "GestureRecognizerUtil.h"

@implementation UIView (VirtualPan)

- (void)recognizePanInApp:(NSArray *)points duration:(NSTimeInterval)duration {
	UIPanGestureRecognizer* original = nil;
	for (UIGestureRecognizer* r in self.gestureRecognizers) {
		if ([r isKindOfClass:[UIPanGestureRecognizer class]]) {
			UIPanGestureRecognizer* o = (UIPanGestureRecognizer*)r;
			original = o;
		}
	}
	
	if (!original) {
		return;
	}
	
	UIView* appView = self;
	while (![appView.superview isKindOfClass:[UIWindow class]]) {
		appView = appView.superview;
	}
	
	NSMutableArray* normalizedPoints = [points mutableCopy];
	if ([normalizedPoints count] == 1) {
		[normalizedPoints addObject:[points lastObject]];
	}
	
	// 20 FPS
	NSUInteger steps = duration * 20;
	CGPoint* ps = malloc(sizeof(CGPoint) * steps);
	CGFloat diff = 1.0 / steps;
	
	CGPoint firstPoint = pointFromArray([normalizedPoints objectAtIndex:0]);
	CGPoint lastPoint = pointFromArray([normalizedPoints lastObject]);
	
	if ([normalizedPoints count] == 2) {
		for (NSUInteger i = 0; i < steps; i++) {
			CGFloat t = diff * i;
			ps[i] = splitLine(t, firstPoint, lastPoint);
		}
	}
	if ([normalizedPoints count] == 3) {
		CGPoint p0 = pointFromArray([normalizedPoints objectAtIndex:0]);
		CGPoint p1 = pointFromArray([normalizedPoints objectAtIndex:1]);
		CGPoint p2 = pointFromArray([normalizedPoints objectAtIndex:2]);
		
		CGPoint p3, p4, p5;
		
		for (NSUInteger i = 0; i < steps; i++) {
			CGFloat t = diff * i;
			
			p3 = splitLine(t, p0, p1);
			p4 = splitLine(t, p1, p2);
			p5 = splitLine(t, p3, p4);
			
			ps[i] = p5;
		}
	}
	
	if ([normalizedPoints count] == 4) {
		CGPoint p0 = pointFromArray([normalizedPoints objectAtIndex:0]);
		CGPoint p1 = pointFromArray([normalizedPoints objectAtIndex:1]);
		CGPoint p2 = pointFromArray([normalizedPoints objectAtIndex:2]);
		CGPoint p3 = pointFromArray([normalizedPoints objectAtIndex:3]);
		
		CGPoint p4, p5, p6, p7, p8, p9;
		
		for (NSUInteger i = 0; i < steps; i++) {
			CGFloat t = diff * i;
			
			p4 = splitLine(t, p0, p1);
			p5 = splitLine(t, p1, p2);
			p6 = splitLine(t, p2, p3);
			
			p7 = splitLine(t, p4, p5);
			p8 = splitLine(t, p5, p6);
			
			p9 = splitLine(t, p7, p8);
			
			ps[i] = p9;
		}
	}
	
	VGVirtualPanGestureRecognizer* v = [[VGVirtualPanGestureRecognizer alloc] initWithParent:original];
	[v setPointView:appView];
	
	dispatch_async(dispatch_get_main_queue(), ^ {
		[v setState:UIGestureRecognizerStateBegan];
		[v setTouches:1 points:&firstPoint];
		fireGestureRecognizer(v, original);
		[v clearTouches];
	});
	
	double delayInSeconds = 0;
	
	for (NSUInteger i = 0; i < steps; i++) {
		delayInSeconds = i * 0.05;
		
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[v setState:UIGestureRecognizerStateChanged];
			[v setTouches:1 points:ps+i];
			fireGestureRecognizer(v, original);
			[v clearTouches];
		});
	}
	
	delayInSeconds = duration;// [duration floatValue];
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[v setState:UIGestureRecognizerStateEnded];
		[v setTouches:1 points:&lastPoint];
		fireGestureRecognizer(v, original);
		[v clearTouches];
		
		free(ps);
	});
}

@end
