//
//  ViewController.h
//  VirtualGestureExample
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VirtualGesture.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *longPressView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)simulateLongPress:(id)sender;
- (IBAction)swipeButtonTap:(id)sender;

@end
