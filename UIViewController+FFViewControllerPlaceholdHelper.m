//
//  UIViewController+FFViewControllerPlaceholdHelper.m
//  FFViewControllerHelper
//
//  Created by wujiangwei on 14/10/27.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "UIViewController+FFViewControllerPlaceholdHelper.h"

#import "MBProgressHUD.h"
#import "FFToastView.h"
#import <objc/runtime.h>

//loading view for viewcontroller
static NSArray *_loadImageArray = nil;
static NSArray *_loadTextArray = nil;

//default error view for viewcontroller
static UIImage *_errorImage = nil;
static NSArray *_errorTextArray = nil;

//default empty view for viewcontroller
static UIImage *_emptyImage = nil;
static NSArray *_emptyTextArray = nil;

static const char associatedPlaceholdViewkey;
static const char associatedVCStatekey;

//default message
#define kFFDefaultLoadingMsg    @"努力加载中..."
#define kFFDefaultErrorMsg      @"抱歉，失败了，点击重新加载"
#define kFFDefaultEmptyMsg      @"数据为空，看看别的页面吧"

@implementation UIViewController (FFViewControllerPlaceholdHelper)

@dynamic vcStates;

#pragma mark - init resource for App

+ (void)initDefaultVCControllerPalceHoldRes:(NSArray *)loadImageArray loadingText:(NSArray *)loadTextArray errorImage:(UIImage *)errorImage errorText:(NSArray *)errorTextArray emptyImage:(UIImage *)emptyImage emptyText:(NSArray *)emptyTextArray
{
    _loadImageArray = loadImageArray;
    _loadTextArray = loadTextArray;
    
    _errorImage = errorImage;
    _errorTextArray = errorTextArray;
    
    _emptyImage = emptyImage;
    _emptyTextArray = emptyTextArray;
    
    //init random seed  
    srandom((unsigned)time(NULL));
}

#pragma mark - getter

- (FFVCPlaceholdView *)vcPlaceholdView
{
    FFVCPlaceholdView *vc = objc_getAssociatedObject(self, &associatedPlaceholdViewkey);
    if (!vc) {
        vc = [[FFVCPlaceholdView alloc] initWithSuperView:self.view];
        objc_setAssociatedObject(self, &associatedPlaceholdViewkey, vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return vc;
}

- (void)setVcStates:(eViewControllerStates )vcStates
{
    switch (vcStates) {
        case eVCStatesNone:
        case eVCStatesLoadingSucceed:
            [self hiddenVCPlaceholdView];
            [self hiddedHUDLoading];//may be not need
            break;
            
        case eVCStatesLoading:
            [self showDefaultLoadingPlaceholdView];
            break;
            
        case eVCStatesLoadingFailedNetError:
            [self showDefaultErrorPlaceholdView];
            break;
            
        case eVCStatesLoadingFailedDataError:
            [self showDefaultErrorPlaceholdView];
            break;
            
        case eVCStatesLoadingFailedUnknowError:
            [self showDefaultErrorPlaceholdView];
            break;
            
        case eVCStatesLoadingEmptyData:
            [self showDefaultEmptyPlaceholdView];
            break;
            
        default:
            break;
    }
}

- (NSString *)loadingText
{
    NSUInteger textCount = _loadTextArray.count;
    if (textCount > 0) {
        return [_loadTextArray objectAtIndex:(random() % textCount)];
    }
    return kFFDefaultLoadingMsg;
}

- (NSString *)errorText
{
    NSUInteger textCount = _errorTextArray.count;
    if (textCount > 0) {
        return [_errorTextArray objectAtIndex:(random() % textCount)];
    }
    return kFFDefaultErrorMsg;
}

- (NSString *)emptyText
{
    NSUInteger textCount = _emptyTextArray.count;
    if (textCount > 0) {
        return [_emptyTextArray objectAtIndex:(random() % textCount)];
    }
    return kFFDefaultEmptyMsg;
}

#pragma mark - HUD Loading
- (void)loadingDataWithHUD
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hiddedHUDLoading
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - FFPlacehold View


//custom view controller placehold view
- (void)hiddenVCPlaceholdView
{
    [self.vcPlaceholdView hidden];
}

- (void)showDefaultLoadingPlaceholdView
{
    [self.vcPlaceholdView refreshAnimationImageArray:_loadImageArray duration:0.5 loadingText:[self loadingText]];
}

- (void)showLoadingPlaceholdView:(NSArray *)aniImageArray duration:(CGFloat)duration loadingText:(NSString *)loadingText
{
    [self.vcPlaceholdView refreshAnimationImageArray:aniImageArray duration:duration loadingText:loadingText];
}

//show error view
- (void)showDefaultErrorPlaceholdView
{
    [self.vcPlaceholdView refreshErrorImage:_errorImage errorMsg:[self errorText]];
}

- (void)showErrorPlaceholdView:(UIImage *)errorImage errorMsg:(NSString *)errorMsg
{
    [self.vcPlaceholdView refreshErrorImage:errorImage errorMsg:errorMsg];
}

- (void)addReloadTarget:(id)target action:(SEL)action
{
    [self.vcPlaceholdView addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}

//show empty view
- (void)showDefaultEmptyPlaceholdView
{
    [self.vcPlaceholdView refreshEmptyImage:_emptyImage emptyText:[self emptyText]];
}

- (void)showEmptyPlaceholdView:(UIImage *)emptyImage emptyMsg:(NSString *)emptyMsg
{
    [self.vcPlaceholdView refreshEmptyImage:emptyImage emptyText:emptyMsg];
}

//show toast like Android
- (void)showAToast:(NSString *)toast
{
    [[FFToastView sharedInstance] showToast:toast inView:self.view];
}

- (void)showAToast:(NSString *)toast offY:(CGFloat)offY
{
    [[FFToastView sharedInstance] showToast:toast inView:self.view centerOffY:offY];
}

//tools for UIViewController
- (UIEdgeInsets)originalContentInset {
    CGFloat navHeight = ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? 64.0 : 0.0;
    return UIEdgeInsetsMake(navHeight, 0, 0, 0);
}

@end
