//
//  BulletBackgroudView.m
//  CommentDemo
//
//  Created by jia feng on 2016/12/24.
//  Copyright © 2016年 caishi. All rights reserved.
//

#import "BulletBackgroudView.h"
#import "BulletView.h"

@implementation BulletBackgroudView

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = NO;
        
    }
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self findClickBulletView:point]) {
        return self;
    }
    return nil;
}

- (BulletView *)findClickBulletView:(CGPoint)point {
    BulletView *bulletView = nil;
    for (UIView *v in [self subviews]) {
        if ([v isKindOfClass:[BulletView class]]) {
            if ([v.layer.presentationLayer hitTest:point]) {
                bulletView = (BulletView *)v;
                break;
            }
        }
    }
    
    return bulletView;
}

- (void)dealTapGesture:(UITapGestureRecognizer *)gesture block:(void (^)(BulletView *bulletView))block {
    CGPoint clickPoint =  [gesture locationInView:self];
    
    BulletView *bulletView = [self findClickBulletView:clickPoint];
    if (bulletView) {
        bulletView.backgroundColor = [UIColor blueColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            bulletView.backgroundColor = [UIColor redColor];
        });
        if (block) {
            block(bulletView);
        }
    }

}

@end
