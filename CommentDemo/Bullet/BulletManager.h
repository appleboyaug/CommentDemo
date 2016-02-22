//
//  BulletManager.h
//  CommentDemo
//
//  Created by feng jia on 16/2/20.
//  Copyright © 2016年 caishi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;
@interface BulletManager : NSObject
@property (nonatomic, copy) void(^generateBulletBlock)(BulletView *view);
- (void)start;
- (void)stop;
@end
