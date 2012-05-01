//
//  VGVirtualPinchGestureRecognizer.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VGVirtualGestureRecognizer.h"

@interface VGVirtualPinchGestureRecognizer : VGVirtualGestureRecognizer

@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat velocity;

- (void)setPoint:(CGPoint)point;

@end
