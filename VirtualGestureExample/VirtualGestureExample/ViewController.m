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

- (void)handleSwipe:(UIGestureRecognizer*)g;

@end

@implementation ViewController
@synthesize longPressView;
@synthesize tableView;

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
	//[self.longPressView addGestureRecognizer:pan];
	
	UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognized:)];
	[self.longPressView addGestureRecognizer:pinch];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	
	cell.textLabel.text = [indexPath description];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - 

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

#pragma mark - Actions

- (IBAction)simulateLongPress:(id)sender {
	CGPoint* points = malloc(sizeof(CGPoint)*3);
	points[0] = CGPointMake(10, 20);
	points[1] = CGPointMake(20, 20);
	points[2] = CGPointMake(30, 20);
	[self.longPressView recognizeLongPress:1 points:3 sequenceOfTouchesInView:points];
	free(points);
}

- (IBAction)swipeButtonTap:(id)sender {
	[self.tableView recognizeSwipe:UISwipeGestureRecognizerDirectionRight];
}


@end
