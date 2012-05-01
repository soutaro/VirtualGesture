//
//  VGVirtualLongPressGestureRecognizer.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VGVirtualGestureRecognizer.h"

@interface VGVirtualLongPressGestureRecognizer : VGVirtualGestureRecognizer

+ (id)newVirtualLongPressGestureRecognizer:(UILongPressGestureRecognizer*)parent;

- (void)setTouches:(NSUInteger)fingers points:(CGPoint*)points;
- (void)clearTouches;

@end
