//
//  UBannerImagesScrollView.h
//  UMarket
//
//  Created by limingshan on 2019/5/30.
//  Copyright © 2019 优社通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UBannerImagesMoveDirectionType) {
    
    UBannerImagesMoveDirectionTypeDirectionForHorizontally = 0,
    UBannerImagesMoveDirectionTypeDirectionVertically,
};

@class UBannerImagesScrollView;
@protocol UBannerImagesScrollViewDelegate <NSObject>

@optional

- (void)bannerImagesScrollView:(UBannerImagesScrollView *)bannerImagesScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface UBannerImagesScrollView : UIView

@property (nonatomic, strong) NSArray *arrayImages;

@property (nonatomic) CGFloat bottomPageControl;

@property(nonatomic,weak) id <UBannerImagesScrollViewDelegate> delegate;

@property(nonatomic,assign) UBannerImagesMoveDirectionType moveDirection;

@property(nonatomic,assign) NSTimeInterval timeInterval;

@property(nonatomic,assign) BOOL hidePageControl;

@property(nonatomic,assign) BOOL canFingersSliding;

@property (nonatomic) BOOL showCountView;

- (void)startTimer;
- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END
