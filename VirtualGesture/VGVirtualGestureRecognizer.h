//
//  VGVirtualGestureRecognizer.h
//  
//
//  Created by 宗太郎 松本 on 12/05/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VGVirtualGestureRecognizer : NSProxy

@property (nonatomic, strong) UIGestureRecognizer* parent;
@property (nonatomic) UIGestureRecognizerState state;
@property (nonatomic) NSUInteger numberOfTouches;

- (id)initWithParent:(UIGestureRecognizer*)parent;

@end
