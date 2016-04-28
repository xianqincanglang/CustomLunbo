//
//  CustomScrollView.m
//  CustomScrolllView
//
//  Created by 陈天宇 on 16/4/27.
//  Copyright © 2016年 陈天宇. All rights reserved.
//

#import "CustomScrollView.h"

#define kImageWidth self.frame.size.width

@interface CustomScrollView()

{
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    
    
    NSInteger currentImageIndex;
    NSInteger leftImageIndex;
    NSInteger rightImageIndex;
    
    NSArray *imageArray;
    
}

@end

@implementation CustomScrollView


- (id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageArray = array;
        [self scrollView];
        [self pageControl];
        [self setUpTimer];
    }
    return self;
}

- (void)setUpTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)nextImage
{
    if (theScrollView.contentOffset.x == kImageWidth) {
        theScrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + kImageWidth, 0);
    }
    [self reloadImages];
    [theScrollView setContentOffset:CGPointMake(kImageWidth, 0) animated:NO];//一直显示中央的imageView
    NSLog(@"-----%@",NSStringFromCGPoint(theScrollView.contentOffset));
}


- (UIScrollView *)scrollView
{
    if (theScrollView == nil) {
        theScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        theScrollView.showsHorizontalScrollIndicator = NO;
        theScrollView.showsVerticalScrollIndicator = NO;
        theScrollView.pagingEnabled = YES;
        theScrollView.bounces = NO;//是否反弹
        
        theScrollView.delegate = self;
        theScrollView.contentSize = CGSizeMake(3*kImageWidth, 0);//设置为3，左右
        [theScrollView setContentOffset:CGPointMake(kImageWidth, 0) animated:YES];

        [self addSubview:theScrollView];
        
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageWidth, self.frame.size.height)];
        [theScrollView addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kImageWidth, 0, kImageWidth, self.frame.size.height)];
        [theScrollView addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*kImageWidth, 0, kImageWidth, self.frame.size.height)];
        [theScrollView addSubview:_rightImageView];
        
        leftImageIndex = imageArray.count - 1;
        currentImageIndex = 0;
        rightImageIndex = 1;
        
        _leftImageView.image = [imageArray objectAtIndex:leftImageIndex];
        _centerImageView.image = [imageArray objectAtIndex:currentImageIndex];
        _rightImageView.image = [imageArray objectAtIndex:rightImageIndex];
        
        
    }
    return theScrollView;
}

- (UIPageControl *)pageControl
{
    if (thePageControl ==  nil) {
        thePageControl = [[UIPageControl alloc] init];
        thePageControl.numberOfPages = imageArray.count;
        CGSize size = [thePageControl sizeForNumberOfPages:imageArray.count];
        
        //确定位置
        thePageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        thePageControl.center = CGPointMake(self.center.x, self.frame.size.height-5);
        
        thePageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        thePageControl.pageIndicatorTintColor = [UIColor grayColor];
        
        [self addSubview:thePageControl];
        thePageControl.currentPage = 0;
        
        [thePageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    }
    return thePageControl;
}

- (void)pageChange:(UIPageControl *)paPageControl
{
    
    NSLog(@"--------");
//    [self reloadImageView];
//    [theScrollView setContentOffset:CGPointMake(kImageWidth,0) animated:YES];
//    thePageControl.currentPage = currentImageIndex;
}



#pragma mark - scrollView Delegate
////停止滚动，刷新页面
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self reloadImages];
    [theScrollView setContentOffset:CGPointMake(kImageWidth, 0) animated:NO];
}



////结束拖曳，开始滚动
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [self setUpTimer];
//}
//
////开始拖曳
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [timer invalidate];//关闭定时器
//}

//滚动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self changeImageWithOffset:scrollView.contentOffset.x];
    
}



- (void)reloadImages {
    
    CGPoint point = [theScrollView contentOffset];
    
    //求currentImageIndex的值
    if (point.x == 2 * kImageWidth) {
        
        if ((currentImageIndex + 1)  == imageArray.count) {
            currentImageIndex = 0;
            
        }else {
            currentImageIndex = (currentImageIndex + 1);
        }
        
    }else if (point.x == 0) {
        if (currentImageIndex - 1 < 0) {
            currentImageIndex = imageArray.count - 1;
            
        }else {
            currentImageIndex = currentImageIndex - 1;
        }
    }
    self.pageControl.currentPage = currentImageIndex;
    
    //求leftImageIndex的值
    if (currentImageIndex - 1 < 0) {    //如果当前图像索引为0，则左为-1
        leftImageIndex = imageArray.count - 1;
    }else {
        leftImageIndex = currentImageIndex - 1;
    }
    
    //求rightImageIndex的值
    if (currentImageIndex + 1 == imageArray.count) {
        rightImageIndex = 0;
    }else {
        rightImageIndex= currentImageIndex + 1;
    }
    _centerImageView.image = [imageArray objectAtIndex:currentImageIndex];
    _leftImageView.image = [imageArray objectAtIndex:leftImageIndex];
    _rightImageView.image = [imageArray objectAtIndex:rightImageIndex];
    
}
@end
