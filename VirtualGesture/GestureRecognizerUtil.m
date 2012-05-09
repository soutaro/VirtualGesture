//
//  UIGestureRecognizer+VirtualGesture.m
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GestureRecognizerUtil.h"
#import <objc/runtime.h>

void fireGestureRecognizer(id that, UIGestureRecognizer* original) {
	NSArray* targets = nil;
	object_getInstanceVariable(original, [@"_targets" cStringUsingEncoding:NSUTF8StringEncoding], (void**)&targets);
	
	for (NSObject* target in targets) {
		NSObject* t = NULL;
		SEL a = NULL;
		
		object_getInstanceVariable(target, "_target", (void**)&t);
		object_getInstanceVariable(target, "_action", (void**)&a);
		
		[t performSelector:a withObject:that];
	}
}

CGPoint splitLine(CGFloat t, CGPoint p1, CGPoint p2) {
	return CGPointMake(p1.x*(1-t) + p2.x*t, p1.y*(1-t) + p2.y*t);
}

CGPoint pointFromArray(NSArray* point) {
	return CGPointMake([[point objectAtIndex:0] floatValue], [[point objectAtIndex:1] floatValue]);
}