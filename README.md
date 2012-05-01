# VirtualGesture

iOS gestures are source of headache for programmers. From the point of
view of automated integration testing, they are evil since it is
difficult to simulate from programs.

VirtualGesture simulate gestures by directoly invoking actions
associated with UIGestureRecognizers. If you are using built-in
gesture recognizers -- UISwipeGestureRecognizer,
UILongPressGestureRecognizer, etc --, you can use VirtualGesture to
simulate user's multi touch gestures.

## Example

    // Long press gesture
    [view recognizeLongPress];
    
    // Swipe gesture
    [view recognizeSwipe:UISwipeGestureRecognizerDirectionRight];
    
    // Pinch gesture
    [view recognizePinch:0.2];

## Pros

* Simple API. Instead of configureing every touches of every frame and
  every fingers, just say *swipe* or something like that.
* Timing matters. Some gesture recognizers have `velocity` property.
  It is difficult to set up such *time dependent properties* by
  sending touch events directory. VirtualGesture can do that. It just
  setup gesture recognizer's properties, and invoke an action
  associated with it.

## Cons

* Not simulating user input.
* Customized gesture recognizers are not supported. For example,
  UIWebView and MKMapView do not respond to virtual pinch gestures.
  They do not use UIPinchGestureRecognizer but a customized, private
  gesture recognizer.
* It is not clear, whether it works or not for complex usage of
  multiple gesture recognizers.

# Author

Written by Soutaro Matsumoto. (matsumoto at soutaro dot com)

Released under the MIT License: www.opensource.org/licenses/mit-license.php

github.com/soutaro/VirtualGesture
