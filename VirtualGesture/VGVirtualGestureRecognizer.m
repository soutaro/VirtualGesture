//
//  VGVirtualGestureRecognizer.m
//  
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VGVirtualGestureRecognizer.h"

@implementation VGVirtualGestureRecognizer {
    UIGestureRecognizer *parent_;
    UIGestureRecognizerState state_;
	NSUInteger numberOfTouches_;
}

@synthesize parent=parent_;
@synthesize state=state_;
@synthesize numberOfTouches=numberOfTouches_;

- (id)initWithParent:(UIGestureRecognizer*)parent {
	self.parent = parent;
	self.state = 0;
	
	return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
	[invocation setTarget:self.parent];
	[invocation invoke];
	return;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	return [self.parent methodSignatureForSelector:sel];
}

@end
