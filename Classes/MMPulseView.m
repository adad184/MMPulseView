//
//  MMPulseView.m
//  MMPulseView
//
//  Created by Ralph Li on 12/29/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMPulseView.h"

@interface MMPulseView()

@property (nonatomic, strong) CAGradientLayer   *gradientLayer;
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CAShapeLayer      *circleLayer;

@end

@implementation MMPulseView


- (instancetype)init
{
    self = [super init];
    if ( self )
    {
        self.gradientLayer = ({
            CAGradientLayer *layer = [CAGradientLayer new];
            
            [self.layer addSublayer:layer];
            
            layer;
        });
        
        self.replicatorLayer = ({
            CAReplicatorLayer *layer = [CAReplicatorLayer new];
            
            self.gradientLayer.mask = layer;
            
            layer;
        });
        
        self.circleLayer = ({
            CAShapeLayer *layer = [CAShapeLayer new];
            layer.strokeColor     = [UIColor whiteColor].CGColor;
            layer.fillColor       = [UIColor clearColor].CGColor;
            
            [self.replicatorLayer addSublayer:layer];
            
            layer;
        });
        
        self.minRadius = 10;
        self.maxRadius = 100;
        
        self.duration = 3.0f;
        self.count = 6;
        self.lineWidth = 2.0f;
        
        self.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor];
        
        self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    return self;
}

- (void)setColors:(NSArray *)colors
{
    self.gradientLayer.colors = colors;
}

- (NSArray *)colors
{
    return self.gradientLayer.colors;
}

- (void)setLocations:(NSArray<NSNumber *> *)locations
{
    self.gradientLayer.locations = locations;
}

- (NSArray *)locations
{
    return self.gradientLayer.locations;
}

- (void)setStartPoint:(CGPoint)startPoint
{
    self.gradientLayer.startPoint = startPoint;
}

- (CGPoint)startPoint
{
    return self.gradientLayer.startPoint;
}

- (void)setEndPoint:(CGPoint)endPoint
{
    self.gradientLayer.endPoint = endPoint;
}

- (CGPoint)endPoint
{
    return self.gradientLayer.endPoint;
}

- (void)setDuration:(CGFloat)duration
{
    _duration = duration;
    
    if ( _count != 0 )
    {
        self.replicatorLayer.instanceCount = _count;
        self.replicatorLayer.instanceDelay = self.duration/(CGFloat)_count;
    }
}

- (void)setCount:(NSUInteger)count
{
    _count = count;
    
    if ( _count != 0 )
    {
        self.replicatorLayer.instanceCount = _count;
        self.replicatorLayer.instanceDelay = self.duration/(CGFloat)_count;
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    
    self.circleLayer.lineWidth = lineWidth;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gradientLayer.frame = self.bounds;
    self.replicatorLayer.frame = self.bounds;
    self.circleLayer.frame     = self.bounds;
}

- (void)startAnimation
{
    CGRect fromRect = CGRectMake(CGRectGetMidX(self.bounds)-self.minRadius, CGRectGetMidY(self.bounds)-self.minRadius, self.minRadius*2, self.minRadius*2);
    CGRect toRect   = CGRectMake(CGRectGetMidX(self.bounds)-self.maxRadius, CGRectGetMidY(self.bounds)-self.maxRadius, self.maxRadius*2, self.maxRadius*2);
    
    CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    zoomAnimation.duration          = self.duration;
    zoomAnimation.fromValue         = (__bridge id)[UIBezierPath bezierPathWithOvalInRect:fromRect].CGPath;
    zoomAnimation.toValue           = (__bridge id)[UIBezierPath bezierPathWithOvalInRect:toRect].CGPath;
    zoomAnimation.repeatCount       = HUGE_VAL;
    zoomAnimation.timingFunction    = self.timingFunction;
    [self.circleLayer addAnimation:zoomAnimation forKey:@"zoom"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    fadeAnimation.duration          = self.duration;
    fadeAnimation.fromValue         = (__bridge id)[UIColor whiteColor].CGColor;
    fadeAnimation.toValue           = (__bridge id)[UIColor clearColor].CGColor;
    fadeAnimation.repeatCount       = HUGE_VAL;
    fadeAnimation.timingFunction    = self.timingFunction;
    [self.circleLayer addAnimation:fadeAnimation forKey:@"fade"];
}

- (void)stopAnimation
{   
    [self.circleLayer removeAllAnimations];
}

@end
