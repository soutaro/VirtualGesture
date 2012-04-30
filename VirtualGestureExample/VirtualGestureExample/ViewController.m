//
//  ViewController.m
//  VirtualGestureExample
//
//  Created by 宗太郎 松本 on 12/04/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (void)longPressWithTwoFingerRecognized:(UILongPressGestureRecognizer*)gesture;
- (void)swipeGestureRecognized:(UISwipeGestureRecognizer*)gesture;
- (void)panGestureRecognized:(UIPanGestureRecognizer*)gesture;
- (void)pinchGestureRecognized:(UIPinchGestureRecognizer*)gesture;

@end

@implementation ViewController
@synthesize longPressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UILongPressGestureRecognizer* g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressWithTwoFingerRecognized:)];
	[self.longPressView addGestureRecognizer:g];
	
	UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognized:)];
	swipe.direction = UISwipeGestureRecognizerDirectionRight;
	[self.longPressView addGestureRecognizer:swipe];
	
	UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
	//pan.maximumNumberOfTouches = 1;
	[self.longPressView addGestureRecognizer:pan];
	
	UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognized:)];
	[self.longPressView addGestureRecognizer:pinch];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)simulateLongPress:(id)sender {
	CGPoint* points = malloc(sizeof(CGPoint)*3);
	points[0] = CGPointMake(10, 20);
	points[1] = CGPointMake(20, 20);
	points[2] = CGPointMake(30, 20);
	[self.longPressView recognizeLongPress:1 points:3 sequenceOfTouchesInView:points];
	free(points);
}

- (void)longPressWithTwoFingerRecognized:(UILongPressGestureRecognizer *)gesture {
	CGPoint point = [gesture locationInView:gesture.view];
	NSLog(@"longpress: state=%d, point=(%.0f,%.0f)", gesture.state, point.x, point.y);
}

- (void)swipeGestureRecognized:(UISwipeGestureRecognizer *)gesture {
	CGPoint point = [gesture locationInView:gesture.view];
	NSLog(@"swipe: state=%d, direction=%d, point=(%.0f,%.0f)", gesture.state, gesture.direction, point.x, point.y);
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gesture {
	CGPoint point = [gesture locationInView:gesture.view];
	CGPoint v = [gesture velocityInView:gesture.view];
	NSLog(@"pan: state=%d, point=(%.0f,%.0f), velocity=(%.2f,%.2f)", gesture.state, point.x, point.y, v.x, v.y);
}

- (void)pinchGestureRecognized:(UIPinchGestureRecognizer *)gesture {
	CGPoint point = [gesture locationInView:gesture.view];
	NSLog(@"pinch: state=%d, point=(%.0f,%.0f), scale=%.2f, velocity=%.2f", gesture.state, point.x, point.y, gesture.scale, gesture.velocity);
}

@end
