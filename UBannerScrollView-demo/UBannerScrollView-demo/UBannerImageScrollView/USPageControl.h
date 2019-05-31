//
//  USPageControl.h
//  UMarket
//
//  Created by limingshan on 2019/5/8.
//  Copyright © 2019 优社通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface USPageControl : UIView

@property (nonatomic) int number;
@property (nonatomic) int currentIndex;

- (void)setPageControlIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
