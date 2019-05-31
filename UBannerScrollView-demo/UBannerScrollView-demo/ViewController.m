//
//  ViewController.m
//  UBannerScrollView-demo
//
//  Created by limingshan on 2019/5/31.
//  Copyright © 2019 li.mingshan. All rights reserved.
//

#import "ViewController.h"
#import "UBannerImageScrollView/UBannerImagesScrollView.h"

@interface ViewController () <UBannerImagesScrollViewDelegate>

@property (nonatomic, strong) UBannerImagesScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_scrollView) {
        _scrollView = [[UBannerImagesScrollView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 278 / 578.)];
        _scrollView.bottomPageControl = 0;
        _scrollView.showCountView = NO;
        _scrollView.layer.cornerRadius = 8;
        _scrollView.layer.masksToBounds = YES;
    }
    _scrollView.delegate = self;
    _scrollView.arrayImages = @[@"image1",@"image2"];
    [self.view addSubview:_scrollView];
}

- (void)bannerImagesScrollView:(UBannerImagesScrollView *)bannerImagesScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",index);
}


@end
