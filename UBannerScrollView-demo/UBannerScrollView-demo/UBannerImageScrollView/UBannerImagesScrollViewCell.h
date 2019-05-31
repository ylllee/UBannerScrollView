//
//  UBannerImagesScrollViewCell.h
//  UMarket
//
//  Created by limingshan on 2019/5/30.
//  Copyright © 2019 优社通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UBannerImagesScrollViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (nonatomic, strong) NSString *stringImageUrl;

@end

NS_ASSUME_NONNULL_END
