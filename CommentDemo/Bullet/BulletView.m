//
//  BulletView.m
//  CommentDemo
//
//  Created by feng jia on 16/2/20.
//  Copyright © 2016年 caishi. All rights reserved.
//

#import "BulletView.h"

#define mWidth [UIScreen mainScreen].bounds.size.width
#define mHeight [UIScreen mainScreen].bounds.size.height
#define mDuration   5
#define Padding  5
@interface BulletView ()

@property (nonatomic, strong) UILabel *lbComment;

@end

@implementation BulletView

- (void)dealloc {
    [self stopAnimation];
    self.moveBlock = nil;
}

- (instancetype)initWithContent:(NSString *)content {
    if (self == [super init]) {
        self.backgroundColor = [UIColor redColor];
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:14]
                                     };
        float width = [content sizeWithAttributes:attributes].width;
        self.bounds = CGRectMake(0, 0, width + Padding*2, 25);
        
        self.lbComment = [UILabel new];
        self.lbComment.frame = CGRectMake(Padding, 0, (width), 25);
        self.lbComment.backgroundColor = [UIColor clearColor];
        self.lbComment.text = content;
        self.lbComment.font = [UIFont systemFontOfSize:14];
        self.lbComment.textColor = [UIColor blackColor];
        [self addSubview:self.lbComment];
    }
    return self;
}


- (void)startAnimation {
    
    //根据定义的duration计算速度以及完全进入屏幕的时间
    CGFloat wholeWidth = CGRectGetWidth(self.frame) + mWidth + 50;
    CGFloat speed = wholeWidth/mDuration;
    CGFloat dur = (CGRectGetWidth(self.frame) + 50)/speed;
    
    
    __block CGRect frame = self.frame;
    if (self.moveBlock) {
        //弹幕开始进入屏幕
        self.moveBlock(Start);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dur * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //dur时间后弹幕完全进入屏幕
        if (self.moveBlock) {
            self.moveBlock(Enter);
        }
    });
    
    //弹幕完全离开屏幕
    [UIView animateWithDuration:mDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x = -CGRectGetWidth(frame);
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (self.moveBlock) {
            self.moveBlock(End);
        }
        [self removeFromSuperview];
    }];
}


- (void)stopAnimation {
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

@end
