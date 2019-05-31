//
//  USPageControl.m
//  UMarket
//
//  Created by limingshan on 2019/5/8.
//  Copyright © 2019 优社通. All rights reserved.
//
/**
 * 颜色rgb自定义
 */
#define kColorWith(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

#import "USPageControl.h"

@interface USPageControl()

@end

@implementation USPageControl

- (id) initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _currentIndex = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setNumber:(int)number {
    _number = number;
}

- (void)___updateDots {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    for (int i = 0; i < _number; i ++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kColorWith(88, 205, 65, .6);
        if (_currentIndex == 0) {
            if (i == _currentIndex) {
                view.backgroundColor = kColorWith(88, 205, 65, 1);
                view.frame = CGRectMake(0, 0, 9, 3);
            }else {
                view.frame = CGRectMake(9 + 5 + (i - 1) * (3 + 5), 0, 3, 3);
            }
        }else {
            if (i < _currentIndex) {
                view.frame = CGRectMake(i * (3 + 5), 0, 3, 3);
            }else if (i > _currentIndex) {
                view.frame = CGRectMake((i - 1) * (3 + 5) + (9 + 5), 0, 3, 3);
            }else {
                view.backgroundColor = kColorWith(88, 205, 65, 1);
                view.frame = CGRectMake(i * (3 + 5), 0, 9, 3);
            }
        }
        view.layer.cornerRadius = 1.5;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
    }
}

- (void)setPageControlIndex:(int)index {
    _currentIndex = index;
    [self ___updateDots];
}

@end
