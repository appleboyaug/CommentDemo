//
//  ViewController.m
//  CommentDemo
//
//  Created by feng jia on 16/2/20.
//  Copyright © 2016年 caishi. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManager.h"
@interface ViewController ()
@property (nonatomic, strong) BulletManager *bulletManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configStartBtn];
    [self configStopBtn];
    
    self.bulletManager = [[BulletManager alloc] init];
    __weak ViewController *myself = self;
    self.bulletManager.generateBulletBlock = ^(BulletView *bulletView) {
        [myself addBulletView:bulletView];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configStartBtn {
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    start.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 80, 80, 70, 30);
    [start setTitle:@"start" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(clickStart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
}

- (void)configStopBtn {
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    stop.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 +10, 80, 70, 30);
    [stop setTitle:@"stop" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(clickStop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
}

- (void)clickStart:(UIButton *)btn {
    [self.bulletManager start];
}

- (void)clickStop:(UIButton *)btn {
    [self.bulletManager stop];
}

- (void)addBulletView:(BulletView *)bulletView {
    bulletView.frame = CGRectMake(CGRectGetWidth(self.view.frame)+50, 200 + 34 * bulletView.trajectory, CGRectGetWidth(bulletView.bounds), CGRectGetHeight(bulletView.bounds));
    [self.view addSubview:bulletView];
    [bulletView startAnimation];
}

@end
