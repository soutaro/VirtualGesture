//
//  UIView+VirtualPinch.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VirtualPinch)

- (void)recognizePinch:(CGFloat)scale;
- (void)recognizePinch:(CGFloat)scale duration:(NSTimeInterval)duration;
- (void)recognizePinch:(CGFloat)scale duration:(NSTimeInterval)duration point:(CGPoint)point;
- (void)recognizePinch:(CGFloat)scale duration:(NSTimeInterval)duration point:(CGPoint)point touches:(NSUInteger)touches;

@end
