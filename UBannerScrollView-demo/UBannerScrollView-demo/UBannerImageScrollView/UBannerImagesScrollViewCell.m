//
//  UBannerImagesScrollViewCell.m
//  UMarket
//
//  Created by limingshan on 2019/5/30.
//  Copyright © 2019 优社通. All rights reserved.
//

#import "UBannerImagesScrollViewCell.h"

@implementation UBannerImagesScrollViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStringImageUrl:(NSString *)stringImageUrl {
    if (_stringImageUrl != stringImageUrl) {
        _stringImageUrl = stringImageUrl;
    }
    _cellImageView.image = [UIImage imageNamed:stringImageUrl];;
}

@end
