//
//  AppDelegate.h
//  新浪博客
//
//  Created by neo on 2017/8/10.
//  Copyright © 2017年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double langitude;

@property(nonatomic,strong)UITabBarController * rootTabBarCtr;
@property(nonatomic,strong)UIImageView * adIamageView;

- (void)saveContext;


@end

