FFViewControlPlaceHoldView（本模块使用需要加入以下2个第三方库 MBProgressHUD 和 FFToastView）
==========================

Placehold View For UIViewControl, Like : Loading View, Empty View, Error View(Tap Reloading)

为IOS App开发提供一些便捷功能

************ 使用 **************

1.App启动时初始化相关资源

    //loading数据时的动态图(由大于等于2张图组成）
    NSArray *loadImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_hud_1.png"], [UIImage imageNamed:@"icon_hud_2.png"], [UIImage imageNamed:@"icon_hud_3.png"], nil];
    
    
    //loading的提示，网络错误图片，空白页面图片，以及屏幕上的提示字符串
    [UIViewController initDefaultVCControllerPalceHoldRes:loadImageArray loadingText:@[@"第一个提示",   @"第二个提示"] errorImage:[UIImage imageNamed:@"icon_error_network.png"] errorText:@[@"第一个错误提示",   @"第二个错误提示"] emptyImage:[UIImage imageNamed:@"vcEmpty.png"] emptyText:@[@"我是空白页面"]];
    
2.在你的UIViewController中import头文件   UIViewController+FFViewControllerPlaceholdHelper.h

当你开始请求网络数据时

    self.vcStates = eVCStatesLoading;
    
网络请求成功，且有数据

    self.vcStates = eVCStatesLoadingSucceed;
    
网络请求成功，但是数据为空

    self.vcStates = eVCStatesLoadingEmptyData;
    
网络请求失败

    self.vcStates = eVCStatesLoadingFailedNetError;
    

************* 细节说明 ******************

主要类说明：UIViewController+FFViewControllerPlaceholdHelper 是一个UIViewcontroller 的 category

提供以下功能：

1.HUD loading

2.自定义动态图loading

3.展示错误界面，支持点击重新加载

4.展示空白页面

5.展示toast（类似于Android的一些消息提示功能）

