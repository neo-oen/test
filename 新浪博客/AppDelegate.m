//
//  AppDelegate.m
//  新浪博客
//
//  Created by neo on 2017/8/10.
//  Copyright © 2017年 neo. All rights reserved.
//

/*
 1.
 */


#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "AFNetworkActivityLogger.h"
#import "Public.h"
#import "NetWorkSingleton.h"

#import "HomeViewController.h"
#import "NearbyViewController.h"
#import "BrowserViewController.h"
#import "OrderViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()<CLLocationManagerDelegate>
//定位
@property(nonatomic,strong)CLLocationManager *locationManager;//用于获取位置
@property(nonatomic,strong)CLLocation *checkLocation;//用于保存位置信息
@property(nonatomic,strong)UIImage * adImage;



@end



@implementation AppDelegate


#pragma mark ============== 懒加载 ==============

/**
 STEP
 
 CLLocationManager判断是否已经存在
	存在直接返回
	不存在创建
        分配初始化一个
        设置代理
        检查系统是否授权
            没授权，进行授权
            授权过，可以使用
        设置过滤距离
        设置精确度
 */
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        [_locationManager setDelegate:self];
        [_locationManager setDistanceFilter:200];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        if (IOS_VERSION>=8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return _locationManager;
}

/**
 初始化框架页面
    初始化UITabBarController
        初始化ViewControllers
        并初始化ViewControllers的UINavigationControllers
        设置tabBar
            设置tabBarItem
                图片
                名称
                字体颜色
 */
-(UITabBarController *)rootTabBarCtr{
    if (!_rootTabBarCtr) {
        _rootTabBarCtr = [[UITabBarController alloc]init];
        
        HomeViewController * homeVC = [[HomeViewController alloc]init];
        UINavigationController *homeNC = [[UINavigationController alloc]initWithRootViewController:homeVC];
        NearbyViewController * nearbyVC = [[NearbyViewController alloc]init];
        UINavigationController * nearbyNC = [[UINavigationController alloc]initWithRootViewController:nearbyVC];
        BrowserViewController * browserVC = [[BrowserViewController alloc]init];
        UINavigationController * browserNC = [[UINavigationController alloc]initWithRootViewController:browserVC];
        OrderViewController * orderVC = [[OrderViewController alloc]init];
        UINavigationController * orderNC = [[UINavigationController alloc]initWithRootViewController:orderVC];
        MineViewController * mineVC = [[MineViewController alloc]init];
        UINavigationController * mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
        NSArray * array = @[homeNC,nearbyNC,browserNC,orderNC,mineNC];
        [_rootTabBarCtr setViewControllers:array animated:YES];
        UITabBarItem * homeItem = [_rootTabBarCtr.tabBar.items objectAtIndex:0];
        UITabBarItem * nearbyItem = [_rootTabBarCtr.tabBar.items objectAtIndex:1];
        UITabBarItem * browserItem = [_rootTabBarCtr.tabBar.items objectAtIndex:2];
        UITabBarItem * orderItem = [_rootTabBarCtr.tabBar.items objectAtIndex:3];
        UITabBarItem * mineItem = [_rootTabBarCtr.tabBar.items objectAtIndex:4];
        [homeItem initWithTitle:@"首页" image:[[UIImage imageNamed:@"icon_tabbar_homepage"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_homepage_selected"] imageWithRenderingMode:UIImageRenderingModeAutomatic ]];
        [nearbyItem initWithTitle:@"附近" image:[[UIImage imageNamed:@"icon_tabbar_onsite"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"icon_tabbar_onsite_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        [browserItem initWithTitle:@"逛一逛" image:[[UIImage imageNamed:@"icon_tabbar_merchant_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_merchant_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        [orderItem initWithTitle:@"订单" image:[[UIImage imageNamed:@"icon_tabbar_mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_mine_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        [mineItem initWithTitle:@"我的" image:[[UIImage imageNamed:@"icon_tabbar_misc"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_misc_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];

        
        
//        UITabBarItem * homeItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"icon_tabbar_homepage"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_homepage_selected"] imageWithRenderingMode:UIImageRenderingModeAutomatic ]];
//        UITabBarItem * nearbyItem = [[UITabBarItem alloc]initWithTitle:@"附近" image:[[UIImage imageNamed:@"icon_tabbar_onsite"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"icon_tabbar_onsite_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
//        UITabBarItem * browserItem = [[UITabBarItem alloc]initWithTitle:@"逛一逛" image:[[UIImage imageNamed:@"icon_tabbar_merchant_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_merchant_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
//        UITabBarItem * orderItem = [[UITabBarItem alloc]initWithTitle:@"订单" image:[[UIImage imageNamed:@"icon_tabbar_mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_mine_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
//        UITabBarItem * mineItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"icon_tabbar_misc"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_tabbar_misc_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
//        NSArray<UITabBarItem *> * items = @[homeItem,nearbyItem,browserItem,orderItem,mineItem];
//        
//        [_rootTabBarCtr.tabBar setItems:items];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
    }
    return _rootTabBarCtr;
}



/**
 <#Description#>

 @return <#return value description#>
 */
-(UIImageView *)adIamageView{
    if (!_adIamageView) {
            _adIamageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    }
    
    return _adIamageView;
}

/**
 广告视图
	拼写loading图片路径
	检查图片是否存在
        存在图片
            实例化uiimage
        获取广告图片
 */
-(UIImage *)adImage{
    if (!_adImage) {
        
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"longding.png"]];
        NSFileManager * filemange = [NSFileManager defaultManager];
        BOOL isExist = [filemange fileExistsAtPath:filePath isDirectory:FALSE];
        if (isExist) {
            _adImage = [UIImage imageWithContentsOfFile:filePath];
      
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getLoadingImage];
        });
    }
    return _adImage;
}

#pragma mark ============== 开始入口 ==============

/**
 STEP：
 开始入口
    启动网络日志
    设置定位
    初始化主视图
    初始化广告界面
        添加到window视图里
        设置图片3秒钟移除广告视图
	其他应用程序通过openURL:启动
        进入既定页面
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AFNetworkActivityLogger sharedLogger ] startLogging ];
    //[[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }else
    {
        NSLog(@"地位服务打开失败");
    }
    self.window.rootViewController = self.rootTabBarCtr;
    [self.window makeKeyWindow];
    
    [self.adIamageView setImage:_adImage];
    [self.window addSubview:self.adIamageView];
    [self performSelector:@selector(removeAdVImage) withObject:nil afterDelay:3];
    
    
    if (launchOptions) {
        
    }
    
    
    return YES;
}


/**
 在应用程序将要由活动状态切换到非活动状态时候，要执行的委托调用，如 按下 home 按钮，返回主屏幕，或全屏之间切换应用程序等。
 说明：当应用程序将要进入非活动状态时执行，在此期间，应用程序不接收消息或事件，比如来电话了。

 */
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


/**
 当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


/**
 当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反。
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


/**
 当应用程序进入活动状态时执行，这个刚好跟上面那个方法相反

 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


/**
 当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


/**
 iPhone设备只有有限的内存，如果为应用程序分配了太多内存操作系统会终止应用程序的运行，在终止前会执行这个方法，通常可以在这里进行内存清理工作防止程序被终止。
 */
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"____"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
#pragma mark ============== 方法 ==============


/**
 获取广告图片
	获取屏幕尺寸
	拼写url
	解码url
	获取广告图片
 获取成功
 打印获取图片成功
 从responseBody里取data 给可变数组
 打印数组
 使用GCD下载图片
 判断数组的长度是否为空
 不为空
 取出数组中的第一个元素的里的Imageurl
 从string格式化成nsurl
 从nsurl格式化成nsdata
 从nsdata转换成UIimage
 获取手机里文档路径
 获取手机里文档+loading.png路径
 打印路径
 图片转换成png原子保存进完整路径里
 为空
 无
 获取失败
 打印错误日志
 */
-(void)getLoadingImage{
    CGFloat  scale = [UIScreen mainScreen].scale;
     NSString *urlStr = [NSString stringWithFormat:@"http://api.meituan.com/config/v1/loading/check.json?app_name=group&app_version=5.7&ci=1&city_id=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&platform=iphone&resolution=%d%@%d&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7",(int)screen_width*scale,@"%2A",(int)screen_height*scale];
    
    urlStr = [urlStr stringByRemovingPercentEncoding];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    
}


/**
 移除广告视图
 */
-(void)removeAdVImage{
    
}
#pragma mark ============== 代理Delegate ==============


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.checkLocation = locations.lastObject;
    NSLog(@"经纬度：%f and %f------\n",_checkLocation.coordinate.latitude,_checkLocation.coordinate.latitude);
    //[self.locationManager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

@end
