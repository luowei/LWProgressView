//
//  LWViewController.m
//  libProgressView
//
//  Created by luowei on 04/25/2019.
//  Copyright (c) 2019 luowei. All rights reserved.
//

#import <libProgressView/LWMaskProgressView.h>
#import "LWViewController.h"

@interface LWViewController ()

@property(nonatomic) int counter;
@end

@implementation LWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (IBAction)btnAction:(UIButton *)sender {

    self.counter = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self selector:@selector(scheduleTimer:) userInfo:nil repeats:YES];

}


- (void)scheduleTimer:(NSTimer *)timer {

    [LWMaskProgressView showMaskProgressViewin:self.view withText:@"取消" progress:(CGFloat) (self.counter / 100.0) dismissBlock:^{
    }];

    if (self.counter == 100) {
        [LWMaskProgressView dismissMaskProgressViewin:self.view];
        [timer invalidate];
        return;
    }

    NSLog(@"===counter:%d", self.counter);
    self.counter++;

}

@end
