//
//  VGVirtualLongPressGestureRecognizer.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VGVirtualLongPressGestureRecognizer : NSProxy

+ (id)newVirtualLongPressGestureRecognizer:(UILongPressGestureRecognizer*)parent;

- (id)initWithParent:(UILongPressGestureRecognizer*)parent;

- (void)setState:(UIGestureRecognizerState)state;
- (void)setTouches:(NSUInteger)fingers points:(CGPoint*)points;
- (void)clearTouches;

@end
