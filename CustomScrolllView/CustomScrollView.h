//
//  CustomScrollView.h
//  CustomScrolllView
//
//  Created by 陈天宇 on 16/4/27.
//  Copyright © 2016年 陈天宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIView<UIScrollViewDelegate>

{
    UIScrollView *theScrollView;
    UIPageControl *thePageControl;
    NSTimer *timer;
}

- (id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)array;
@end
