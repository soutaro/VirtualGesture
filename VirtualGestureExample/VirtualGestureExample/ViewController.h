//
//  ViewController.h
//  VirtualGestureExample
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VirtualGesture.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *longPressView;

- (IBAction)simulateLongPress:(id)sender;

@end
