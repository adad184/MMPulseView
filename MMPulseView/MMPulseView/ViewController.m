//
//  ViewController.m
//  MMPulseView
//
//  Created by Ralph Li on 12/29/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "ViewController.h"
#import "MMPulseView.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *pulseArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSInteger maxI = 2;
    NSInteger maxJ = 2;
    
    NSMutableArray *pulseArray = @[].mutableCopy;
    
    for ( int i = 0 ; i < maxI*maxJ ; ++i )
    {
        [pulseArray addObject:[MMPulseView new]];
    }
    self.pulseArray = pulseArray;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    for ( int i = 0 ; i < maxI ; ++i )
    {
        for ( int j = 0 ; j < maxJ ; ++j )
        {
            NSInteger index = i*maxJ+j;
            MMPulseView *pulseView = pulseArray[index];
            
            pulseView.frame = CGRectMake(CGRectGetWidth(screenRect)/maxJ*j,
                                         CGRectGetHeight(screenRect)/maxI*i,
                                         CGRectGetWidth(screenRect)/maxJ,
                                         CGRectGetHeight(screenRect)/maxI);
            
            [self.view addSubview:pulseView];
            
            
            switch (index) {
                case 0:
                {
                    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                    pulseView.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
                    
                    pulseView.minRadius = 0;
                    pulseView.maxRadius = 80;
                    
                    pulseView.duration = 5;
                    pulseView.count = 20;
                    pulseView.lineWidth = 1.0f;
                    
                    break;
                }
                case 1:
                {
                    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                    pulseView.colors = @[(__bridge id)[UIColor colorWithRed:0.996 green:0.647 blue:0.008 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:1 green:0.31 blue:0.349 alpha:1].CGColor];
                    
                    CGFloat posY = (CGRectGetHeight(screenRect)-320)/2/CGRectGetHeight(screenRect);
                    pulseView.startPoint = CGPointMake(0.5, posY);
                    pulseView.endPoint = CGPointMake(0.5, 1.0f - posY);
                    
                    pulseView.minRadius = 40;
                    pulseView.maxRadius = 100;
                    
                    pulseView.duration = 2;
                    pulseView.count = 4;
                    pulseView.lineWidth = 2.0f;
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [self.view addSubview:btn];
                    [btn setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
                    [btn setTitle:@"Tap" forState:UIControlStateNormal];
                    btn.frame = CGRectMake(0, 0, 100, 100);
                    btn.center = pulseView.center;
                    [btn addTarget:self action:@selector(actionPulse) forControlEvents:UIControlEventTouchUpInside];
                    
                    break;
                }
                case 2:
                {
                    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                    pulseView.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
                    pulseView.startPoint = CGPointMake(0, 0.5);
                    pulseView.endPoint = CGPointMake(1, 0.5);
                    
                    pulseView.minRadius = 0;
                    pulseView.maxRadius = 60;
                    
                    pulseView.duration = 5;
                    pulseView.count = 1;
                    pulseView.lineWidth = 5.0f;
                    
                    break;
                }
                case 3:
                {
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
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            if ( index != 1 )
            {
                [pulseView startAnimation];
            }
        }
    }
}

- (void)actionPulse
{
    MMPulseView *pulseView = self.pulseArray[1];
    
    pulseView.tag = 1 - pulseView.tag;
    
    (pulseView.tag>0)?[pulseView startAnimation]:[pulseView stopAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
