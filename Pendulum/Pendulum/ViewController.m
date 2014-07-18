//
//  ViewController.m
//  Pendulum
//
//  Created by techmaster on 5/13/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "ViewController.h"
#define MAX_ANGLE M_PI_4 * 0.5
#define MAX_ANGLE1 M_PI * 2
@interface ViewController ()
{
    NSTimer *_timer;
    double _angle;
    double _angleDelta;
    double _angle1;
    double _angleDelta1;
    double _angle2;
    double _angleDelta2;
}
@property (weak, nonatomic) IBOutlet UIImageView *clock;
@property (weak, nonatomic) IBOutlet UIImageView *kimGio;
@property (weak, nonatomic) IBOutlet UIImageView *pendulum;
@property (weak, nonatomic) IBOutlet UISlider *sliderAngle;
@property (weak, nonatomic) IBOutlet UIImageView *kimGiay;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = self.pendulum.bounds.size;
    CGSize size1 = self.kimGio.bounds.size;
    CGSize size2 = self.kimGio.bounds.size;
    self.pendulum.layer.anchorPoint = CGPointMake(0.5, 0);
    self.pendulum.frame = CGRectMake((self.view.bounds.size.width - size.width)* 0.5, 220, size.width, size.height);
    self.kimGio.layer.anchorPoint = CGPointMake(0.7, 1);
    self.kimGio.frame = CGRectMake((self.view.bounds.size.width - size1.width)*0.5, 60, size1.width, size1.height);
    self.kimGiay.layer.anchorPoint = CGPointMake(0.7, 1);
    self.kimGiay.frame = CGRectMake((self.view.bounds.size.width - size2.width)*0.5, 60, size2.width, size2.height);
    _angle = 0.0;
    _angleDelta = 0.05;
    _angle1 = 0.0;
    _angleDelta1 = 0.00036;
    _angle2 = 0.0;
    _angleDelta2 = 0.01;
    
}

- (void) startAnimation
{
    _timer = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                              target: self
                                            selector: @selector(animatePendulum)
                                            userInfo: nil
                                             repeats: YES];
    [_timer fire];
}
- (IBAction)startStopAnimation:(UISwitch *)sender {
    if ([sender isOn]) {
        [self startAnimation];
        self.sliderAngle.enabled = NO;
    } else if (_timer.isValid) {
        [_timer invalidate];
         _timer = nil;
        self.sliderAngle.enabled = YES;
    }
    
}

- (void) animatePendulum
{
    _angle += _angleDelta;
    _angle1 += _angleDelta1;
    _angle2 += _angleDelta2;
    if ((_angle > MAX_ANGLE) | (_angle < - MAX_ANGLE)) {
        _angleDelta = - _angleDelta;
    }
    self.pendulum.transform = CGAffineTransformMakeRotation(_angle);
    //NSLog(@"%3.2f - %3.2f", self.pendulum.center.x  , self.pendulum.center.y);
    self.kimGio.transform = CGAffineTransformMakeRotation(_angle1);
    NSLog(@"%3.2f - %3.2f", self.kimGio.center.x  , self.kimGio.center.y);
    self.kimGiay.transform = CGAffineTransformMakeRotation(_angle2);
    
}
- (IBAction)changeAngle:(UISlider *)sender {
    self.pendulum.transform = CGAffineTransformMakeRotation(MAX_ANGLE * sender.value);
}

@end
