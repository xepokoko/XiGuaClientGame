//
//  SceneDelegate.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "SceneDelegate.h"
#import "PlayViewController.h"
#import "UIImage+SFFont.h"
#import "HomeViewController.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    HomeViewController *controller1 = [[HomeViewController alloc] init];
    controller1.view.backgroundColor = [UIColor whiteColor];
    controller1.title = @"主页";
    controller1.tabBarItem.image = [UIImage systemImageNamed:@"list.dash"];
    
    UINavigationController *navi_1 = [[UINavigationController alloc]initWithRootViewController:controller1];
    [tabBarController addChildViewController:navi_1];
    
    PlayViewController *controller2 = [[PlayViewController alloc] init];
    controller2.view.backgroundColor = [UIColor whiteColor];
    controller2.title = @"我的";
    UINavigationController *navi_2 = [[UINavigationController alloc]initWithRootViewController:controller2];

    [tabBarController addChildViewController:navi_2];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
 
    //测试产品
    CGFloat tabHeight = tabBarController.tabBar.frame.size.height;
    CGFloat naviHeight = navi_1.navigationBar.frame.size.height;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0,ScreenHeight-tabHeight-naviHeight, ScreenWidth, 50)];
    view1.backgroundColor = [UIColor redColor];
    [tabBarController.view addSubview:view1];
    [tabBarController.view bringSubviewToFront:view1];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
