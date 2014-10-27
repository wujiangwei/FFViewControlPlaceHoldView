//
//  UIViewController+FFViewControllerPlaceholdHelper.h
//  FFViewControllerHelper
//
//  Created by wujiangwei on 14/10/27.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFVCPlaceholdView.h"

typedef enum viewcontrollerStates
{
    eVCStatesLoading = 1,
    
    eVCStatesLoadingSucceed,
    
    eVCStatesLoadingFailedNetError,
    eVCStatesLoadingFailedDataError,
    eVCStatesLoadingFailedUnknowError,
    
    eVCStatesLoadingEmptyData
}eViewControllerStates;

@interface UIViewController (FFViewControllerPlaceholdHelper)

@property (nonatomic, strong, readonly)FFVCPlaceholdView *vcPlaceholdView;

/**
 Init the viewController helper with default hold resource
 
 Set your app loading resource:
    loadImageArray:if more than 1,it's dynamic loading
    loadTextArray :if more than 1,it's will random show one text when show loading
        Note:errorTextArray and emptyTextArray is equal with loadTextArray
*/
+ (void)initDefaultVCControllerPalceHoldRes:
               (NSArray *)loadImageArray loadingText:(NSArray *)loadTextArray
    errorImage:(UIImage *)errorImage     errorText:(NSArray *)errorTextArray
    emptyImage:(UIImage *)emptyImage     emptyText:(NSArray *)emptyTextArray;

//hud loading data
- (void)loadingDataWithHUD;
- (void)hiddedHUDLoading;

//custom view controller placehold view
- (void)hiddenVCPlaceholdView;

- (void)showDefaultLoadingPlaceholdView;
- (void)showLoadingPlaceholdView:(NSArray *)aniImageArray duration:(CGFloat)duration loadingText:(NSString *)loadingText;

//show error view
- (void)showDefaultErrorPlaceholdView;
- (void)showErrorPlaceholdView:(UIImage *)errorImage errorMsg:(NSString *)errorMsg;

//show empty view
- (void)showDefaultEmptyPlaceholdView;
- (void)showEmptyPlaceholdView:(UIImage *)emptyImage emptyMsg:(NSString *)emptyMsg;

//show toast like Android
- (void)showAToast:(NSString *)toast;
- (void)showAToast:(NSString *)toast offY:(CGFloat)offY;

@end
