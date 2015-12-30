MMPulseView
=============
[![CocoaPods](https://img.shields.io/cocoapods/v/MMPulseView.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/MMPulseView.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/l/MMPulseView.svg)]()

A simple view to show circle pulse repeatly. 

![demo](https://github.com/adad184/MMPulseView/blob/master/demo.gif)

Installation
============

The preferred way of installation is via [CocoaPods](http://cocoapods.org). Just add

```ruby
pod 'MMPulseView'
```

and run `pod install`. It will install the most recent version of MMPopupView.

If you would like to use the latest code of MMPopupView use:

```ruby
pod 'MMPulseView', :head
```

Usage
===============
```objc
pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
pulseView.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                     (__bridge id)[UIColor blackColor].CGColor,
                     (__bridge id)[UIColor whiteColor].CGColor];
pulseView.locations = @[@(0.3),@(0.5),@(0.7)];
pulseView.startPoint = CGPointMake(0, 0.5);
pulseView.endPoint = CGPointMake(1, 0.5);

pulseView.minRadius = 0;
pulseView.maxRadius = 100;

pulseView.duration = 3;
pulseView.count = 6;
pulseView.lineWidth = 3.0f;

[pulseView startAnimation];
```	

Changelog
===============
v1.0  first version
