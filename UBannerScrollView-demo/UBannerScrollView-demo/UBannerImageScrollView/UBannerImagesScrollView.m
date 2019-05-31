//
//  UBannerImagesScrollView.m
//  UMarket
//
//  Created by limingshan on 2019/5/30.
//  Copyright © 2019 优社通. All rights reserved.
//

#import "UBannerImagesScrollView.h"
#import "UBannerImagesScrollViewCell.h"
#import "USPageControl.h"

#define kTagCollectionView 90001

#define kCellIdentifier @"UBannerImagesScrollViewCell"

@interface UBannerImagesScrollView() <UICollectionViewDelegate,UICollectionViewDataSource> {
    NSInteger _index;
    BOOL _isScroll;
    UICollectionViewScrollPosition _scrollPosition;
    UICollectionViewScrollDirection _scrollDirection;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) USPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation UBannerImagesScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        _bottomPageControl = 10;
        self.moveDirection = UBannerImagesMoveDirectionTypeDirectionForHorizontally;
        self.timeInterval = 3.;
    }
    return self;
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
}

- (void)setArrayImages:(NSArray *)arrayImages {
    if (_arrayImages != arrayImages) {
        _arrayImages = arrayImages;
    }
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = _scrollDirection;
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.tag = kTagCollectionView;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        
        if (!_pageControl) {
            CGFloat widthPageControl = (_arrayImages.count - 1) * (5 + 3) + 9;
            _pageControl = [[USPageControl alloc] initWithFrame:CGRectMake((self.bounds.size.width - widthPageControl) / 2.0, self.bounds.size.height - 3 - _bottomPageControl - 10, widthPageControl, 3)];
            _pageControl.number = (int)arrayImages.count;
            _pageControl.currentIndex = 0;
            [_pageControl setPageControlIndex:0];
        }
        [self addSubview:_pageControl];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:_scrollPosition animated:NO];
    }
    [self.collectionView reloadData];
    [self startTimer];
}

- (void)setBottomPageControl:(CGFloat)bottomPageControl {
    _bottomPageControl = bottomPageControl;
    CGFloat widthPageControl = (_arrayImages.count - 1) * (5 + 3) + 9;
    _pageControl.frame = CGRectMake((self.bounds.size.width - widthPageControl) / 2.0, self.bounds.size.height - 3 - _bottomPageControl - 10, widthPageControl, 3);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayImages.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UBannerImagesScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.stringImageUrl = self.arrayImages[indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag == kTagCollectionView) {
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == kTagCollectionView) {
        [self startTimer];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.tag == kTagCollectionView) {
        if (_isScroll) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:_scrollPosition animated:NO];
            _isScroll = NO;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == kTagCollectionView) {
        NSInteger currentPage = 0;
        if (!self.moveDirection) {
            currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
        } else {
            currentPage = scrollView.contentOffset.y / scrollView.bounds.size.height;
        }

        currentPage = currentPage % self.arrayImages.count;
        [_pageControl setPageControlIndex:(int)currentPage];

        _index = currentPage;

        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentPage inSection:1] atScrollPosition:_scrollPosition animated:NO];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerImagesScrollView:didSelectItemAtIndex:)]) {
        [self.delegate bannerImagesScrollView:self didSelectItemAtIndex:indexPath.row];
    }
}

#pragma mark - timer action
- (void)startTimer {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerCycleImageAction:) userInfo:nil repeats:YES];
    }
    
    if (_timer) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
//    [self.timer invalidate];
//    self.timer = nil;
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:_scrollPosition animated:YES];
    [_pageControl setPageControlIndex:0];
    _index = 0;
}

- (void)timerCycleImageAction:(NSTimer *)timer {
    if (_index == self.arrayImages.count) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:_scrollPosition animated:YES];
        [_pageControl setPageControlIndex:0];
        _index = 1;
        _isScroll = YES;
    }else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:1] atScrollPosition:_scrollPosition animated:YES];
        [_pageControl setPageControlIndex:(int)_index];
        _index += 1;
    }
}

#pragma mark - setter
- (void)setMoveDirection:(UBannerImagesMoveDirectionType)moveDirection {
    _moveDirection = moveDirection;
    if (!moveDirection) {
        _scrollPosition = UICollectionViewScrollPositionCenteredHorizontally;
        _scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else {
        _scrollPosition = UICollectionViewScrollPositionCenteredVertically;
        _scrollDirection = UICollectionViewScrollDirectionVertical;
    }
}

- (void)setHidePageControl:(BOOL)hidePageControl {
    _hidePageControl = hidePageControl;
    self.pageControl.hidden = hidePageControl;
}

- (void)setCanFingersSliding:(BOOL)canFingersSliding {
    _canFingersSliding = canFingersSliding;
    self.collectionView.scrollEnabled = canFingersSliding;
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
