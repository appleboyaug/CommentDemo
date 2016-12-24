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
#import "BulletBackgroudView.h"
@interface ViewController ()
@property (nonatomic, strong) BulletManager *bulletManager;
@property (nonatomic, strong) BulletBackgroudView *bulletBgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(100, 370, 100, 40);
    [btn setTitle:@"点击我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"1111"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    [self configStartBtn];
    [self configStopBtn];
    [self addTapGesture];
    
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

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}

- (void)tapHandler:(UITapGestureRecognizer *)gesture {
    [self.bulletBgView dealTapGesture:gesture block:^(BulletView *bulletView){
        NSLog(@"%@", bulletView.lbComment.text);
    }];
}

- (void)clickBtn {
    NSLog(@"clickBtn");
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
    bulletView.frame = CGRectMake(CGRectGetWidth(self.view.frame)+50, 20 + 34 * bulletView.trajectory, CGRectGetWidth(bulletView.bounds), CGRectGetHeight(bulletView.bounds));
    [self.bulletBgView addSubview:bulletView];
    [bulletView startAnimation];
}

- (BulletBackgroudView *)bulletBgView {
    if (!_bulletBgView) {
        _bulletBgView = [[BulletBackgroudView alloc] init];
        _bulletBgView.frame = CGRectMake(0, 300, CGRectGetWidth(self.view.frame), 150);
        _bulletBgView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_bulletBgView];
    }
    return _bulletBgView;
}


@end
