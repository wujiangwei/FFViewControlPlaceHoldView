//
//  FFVCPlaceholdView.m
//  FFVCPlaceholdView
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "FFVCPlaceholdView.h"

@implementation FFVCPlaceholdView
{
    UIView *_animationContentView;
}

#pragma mark - init

- (id)initWithSuperView:(UIView *)superView {
    
    if (self = [super initWithFrame:superView.bounds]) {
        self.userInteractionEnabled = NO;
        
        CGFloat lableHeight = 40.0;
        CGFloat width = CGRectGetWidth(superView.bounds) * 0.46;
        CGFloat height = width + lableHeight;
        
        _animationContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [_animationContentView setBackgroundColor:[UIColor clearColor]];
        
        _holdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_animationContentView addSubview:_holdImageView];
        
        _holdLable = [[UILabel alloc] initWithFrame:CGRectMake(0, height - lableHeight, width, lableHeight)];
        [_holdLable setTextColor:[UIColor lightGrayColor]];
        [_holdLable setTextAlignment:NSTextAlignmentCenter];
        [_holdLable setFont:[UIFont systemFontOfSize:14.0]];
        [_holdLable setBackgroundColor:[UIColor clearColor]];
        [_animationContentView addSubview:_holdLable];
        
        [self addSubview:_animationContentView];
        
        //for error view reloading
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadingData)];
        [self addGestureRecognizer:tapGes];
        
        //inside add self to super view
        [superView addSubview:self];
    }
    
    return self;
}

- (void)resetPlaceholdState
{
    self.userInteractionEnabled = NO;
    self.holdImageView.image = nil;
    self.holdImageView.animationImages = nil;
    [self.holdImageView setAnimationDuration:0];
}

#pragma mark - loading int

- (void)refreshAnimationImageArray:(NSArray *)aniImageArray
{
    [self refreshAnimationImageArray:aniImageArray duration:0.5 loadingText:@"努力加载中..."];
}

- (void)refreshAnimationImageArray:(NSArray *)aniImageArray duration:(CGFloat)duration loadingText:(NSString *)loadingText
{
    NSAssert(aniImageArray.count > 1, @"Your loading image count is less than 2,can not be a loading");
    //[_holdImageView setAnimationImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"icon_hud_1.png"], [UIImage imageNamed:@"icon_hud_2.png"], [UIImage imageNamed:@"icon_hud_3.png"], nil]];
    [self resetPlaceholdState];
    
    self.holdImageView.animationImages = aniImageArray;
    [self.holdImageView setAnimationDuration:duration];
    self.holdLable.text = loadingText;
    
    [self show];
}

#pragma mark - error int
- (void)refreshErrorImage:(UIImage *)errorImage errorMsg:(NSString *)errorMsg
{
    [self resetPlaceholdState];
    
    self.userInteractionEnabled = YES;
    self.holdImageView.image = errorImage;
    self.holdLable.text = errorMsg;
    
    [self show];
}

#pragma mark - empty init
- (void)refreshEmptyImage:(UIImage *)emptyImage emptyText:(NSString *)emptyText
{
    [self resetPlaceholdState];
    
    self.holdImageView.image = emptyImage;
    self.holdLable.text = emptyText;
    
    [self show];
}

#pragma mark - layout subviews

- (void)layoutSubviews {
    //居中显示
    UIView *parentView = self.superview;
    if (parentView) {
        [self setFrame:CGRectMake(0, self.yOffset, CGRectGetWidth(parentView.bounds), CGRectGetHeight(parentView.bounds) - self.yOffset)];
    }
    
    [_animationContentView setCenter:CGPointMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5)];
}

- (void)setYOffset:(CGFloat)yOffset
{
    _yOffset = yOffset;
    [self setNeedsLayout];
}

#pragma mark - Show and Hidden VC Placehold View

- (void)show{
    [self setAlpha:1];
    if (_holdImageView.animationImages.count) {
        [_holdImageView startAnimating];
    }
}


- (void)hidden{
    [self setAlpha:0];
    if (_holdImageView.animationImages.count) {
        [_holdImageView stopAnimating];
    }
}

#pragma mark - error view reloading data
- (void)reloadingData
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
