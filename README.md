FFViewControlPlaceHoldView（本模块使用需要加入以下2个第三方库 MBProgressHUD 和 FFToastView）
==========================

Placehold View For UIViewControl, Like : Loading View, Empty View, Error View(Tap Reloading)

为IOS App开发提供一些便捷功能

在App启动时初始化 资源：loading 图片，界面错误图片等

    //loading数据时的动态图
    NSArray *loadImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_hud_1.png"], [UIImage imageNamed:@"icon_hud_2.png"], [UIImage imageNamed:@"icon_hud_3.png"], nil];
    
    //loading的提示，网络错误图片，空白页面图片
    [UIViewController initDefaultVCControllerPalceHoldRes:loadImageArray loadingText:@[@"第一个提示",   @"第二个提示"] errorImage:[UIImage imageNamed:@"icon_error_network.png"] errorText:@[@"第一个错误提示",   @"第二个错误提示"] emptyImage:[UIImage imageNamed:@"vcEmpty.png"] emptyText:@[@"我是空白页面"]];

************* 说明 ******************

主要类说明：UIViewController+FFViewControllerPlaceholdHelper 是一个UIViewcontroller 的 category

提供以下功能：

1.HUD loading

2.自定义动态图loading

3.展示错误界面，支持点击重新加载

4.展示空白页面

5.展示toast（类似于Android的一些消息提示功能）

你可以简单的设置 
  @property (nonatomic, assign)eViewControllerStates vcStates 的属性
  
  界面会根据你设置的属性，自动变化界面


    typedef enum viewcontrollerStates
    {
        eVCStatesNone = 0,
        eVCStatesLoading = 10,
        
        eVCStatesLoadingSucceed,
        
        //未对这3个状态进行细化
        eVCStatesLoadingFailedNetError,
        eVCStatesLoadingFailedDataError,
        eVCStatesLoadingFailedUnknowError,
        
        eVCStatesLoadingEmptyData
    }eViewControllerStates;
