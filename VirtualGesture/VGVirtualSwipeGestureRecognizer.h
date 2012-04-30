//
//  VGVirtualSwipeGestureRecognizer.h
//  VirtualGesture
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VGVirtualSwipeGestureRecognizer : NSProxy

- (id)initWithOriginalGestureRecognizer:(UISwipeGestureRecognizer*)original;

- (void)setPoint:(CGPoint)point;

@end
