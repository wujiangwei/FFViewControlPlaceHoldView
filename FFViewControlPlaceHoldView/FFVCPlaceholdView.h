//
//  FFVCPlaceholdView.h
//  AppFactory
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFVCPlaceholdView : UIControl

@property (nonatomic, strong, readonly)UIImageView *holdImageView;
@property (nonatomic, strong, readonly)UILabel *holdLable;

//You can custom the hold view Y offset by yOffset,and it'll auto refresh the hold view
@property (nonatomic, assign)CGFloat yOffset;

//Default image + lable view with vertical
- (instancetype)initWithSuperView:(UIView *)view;

//change view states to loading
- (void)refreshAnimationImageArray:(NSArray *)aniImageArray;
- (void)refreshAnimationImageArray:(NSArray *)aniImageArray duration:(CGFloat)duration loadingText:(NSString *)loadingText;

//change view states to error
- (void)refreshErrorImage:(UIImage *)errorImage errorMsg:(NSString *)errorMsg;

//change view states to empty
- (void)refreshEmptyImage:(UIImage *)emptyImage emptyText:(NSString *)emptyText;

/**
 Note: If Animation exist,will start animation auto
*/
- (void)show;
- (void)hidden;

@end
